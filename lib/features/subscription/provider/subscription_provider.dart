import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lottie/lottie.dart';
import 'package:one_ai/features/subscription/model/restricted_feature.dart';
import 'package:one_ai/features/subscription/model/subscription_plan.dart';
import 'package:one_ai/features/subscription/screen/subscription_screen.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SubscriptionProvider extends ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails>? _products;
  bool _isLoading = true;
  String? _userId;
  SubscriptionPlan _currentPlan = SubscriptionPlan.free;

  SubscriptionProvider() {
    _initialize();
  }

  bool get isLoading => _isLoading;

  List<ProductDetails>? get products => _products;

  SubscriptionPlan get currentPlan => _currentPlan;

  Future<void> _initialize() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    _subscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () => _subscription?.cancel(),
      onError: (error) => print('Error: $error'),
    );

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final Set<String> ids = {
      SubscriptionPlan.basic.id,
      SubscriptionPlan.premium.id,
    };

    try {
      final available = await _inAppPurchase.isAvailable();
      if (!available) {
        throw Exception(
            'Play Store is not available. Please make sure you have Google Play Store installed.');
      }

      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails(ids);

      if (response.notFoundIDs.isNotEmpty) {
        print('Products not found: ${response.notFoundIDs}');
        _products = response.productDetails;
      } else {
        _products = response.productDetails;
      }

      print(
          'Available products: ${_products?.map((p) => '${p.id}: ${p.price}')}');
    } catch (e) {
      print('Error loading products: $e');
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buySubscription(ProductDetails product) async {
    try {
      final bool available = await _inAppPurchase.isAvailable();
      if (!available) {
        throw Exception('Play Store is not available');
      }

      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product,
        applicationUserName: _userId,
      );

      final bool pending = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!pending) {
        throw Exception('Unable to start purchase. Please try again.');
      }
    } catch (e) {
      print('Error purchasing subscription: $e');
      rethrow;
    }
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _isLoading = true;
        notifyListeners();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handlePurchaseError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          try {
            await _verifyPurchaseOnBackend(purchaseDetails);
            await _verifyPurchase(purchaseDetails);
            if (purchaseDetails.pendingCompletePurchase) {
              await _inAppPurchase.completePurchase(purchaseDetails);
            }
          } catch (e) {
            print('Error verifying purchase: $e');
          }
        }
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> _verifyPurchaseOnBackend(PurchaseDetails purchase) async {
    // TODO: Implement server-side purchase verification
    print('Verifying purchase on backend: ${purchase.purchaseID}');
  }

  void _handlePurchaseError(IAPError error) {
    print('Purchase error: ${error.code} - ${error.message}');
    switch (error.code) {
      case 'user_cancelled':
        break;
      case 'item_already_owned':
        break;
      default:
        break;
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    if (_userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      SubscriptionType type;
      if (purchaseDetails.productID == 'android.test.purchased' ||
          purchaseDetails.productID == SubscriptionPlan.basic.id) {
        type = SubscriptionType.basic;
        _currentPlan = SubscriptionPlan.basic;
      } else if (purchaseDetails.productID == 'android.test.item_unavailable' ||
          purchaseDetails.productID == SubscriptionPlan.premium.id) {
        type = SubscriptionType.premium;
        _currentPlan = SubscriptionPlan.premium;
      } else {
        return;
      }

      await _firestore.collection('subscriptions').doc(_userId).set({
        'type': type.toString(),
        'purchaseToken': purchaseDetails.purchaseID,
        'expiryDate':
            DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      });
    } catch (e) {
      print('Error verifying purchase: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setUserId(String userId) async {
    _userId = userId.isEmpty ? null : userId;
    await loadUserSubscription();
  }

  Future<void> loadUserSubscription() async {
    if (_userId == null) {
      _currentPlan = SubscriptionPlan.free;
      notifyListeners();
      return;
    }

    try {
      final doc =
          await _firestore.collection('subscriptions').doc(_userId).get();

      if (!doc.exists) {
        _currentPlan = SubscriptionPlan.free;
      } else {
        final data = doc.data()!;
        final expiryDate = DateTime.parse(data['expiryDate']);

        if (DateTime.now().isAfter(expiryDate)) {
          _currentPlan = SubscriptionPlan.free;
        } else {
          final type = SubscriptionType.values
              .firstWhere((e) => e.toString() == data['type']);

          switch (type) {
            case SubscriptionType.basic:
              _currentPlan = SubscriptionPlan.basic;
              break;
            case SubscriptionType.premium:
              _currentPlan = SubscriptionPlan.premium;
              break;
            default:
              _currentPlan = SubscriptionPlan.free;
          }
        }
      }
    } catch (e) {
      print('Error loading subscription: $e');
      _currentPlan = SubscriptionPlan.free;
    }

    notifyListeners();
  }

  bool canUseFeature(RestrictedFeature feature) {
    switch (_currentPlan.type) {
      case SubscriptionType.premium:
        return true;
      case SubscriptionType.basic:
        return feature.minimumPlan != SubscriptionType.premium;
      case SubscriptionType.free:
        return feature.minimumPlan == SubscriptionType.free;
    }
  }

  void showUpgradeDialog(BuildContext context, RestrictedFeature feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.primary.withOpacity(0.5),
            width: 1,
          ),
        ),
        title: Text(
          'Feature Locked',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/locked_feature.json',
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 16),
            Text(
              feature.lockedMessage,
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Later',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriptionScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Upgrade Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
