import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/features/subscription/model/subscription_plan.dart';
import 'package:one_ai/features/subscription/provider/subscription_provider.dart';
import 'package:one_ai/utils/validation/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_usage.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/utils/navigation/navigation_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  String? _profilePicUrl;
  bool _isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserUsage? _userUsage;
  StreamSubscription<DocumentSnapshot>? _usageSubscription;

  AuthProvider() {
    initialize();
  }

  User? get user => _user;

  String? get profilePicUrl => _profilePicUrl;

  bool get isLoading => _isLoading;

  UserUsage? get userUsage => _userUsage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    _user = _auth.currentUser;
    if (_user != null) {
      await _getProfilePicUrl();
      await _setupUsageListener();
      if (NavigationService.currentContext != null) {
        Provider.of<SubscriptionProvider>(
          NavigationService.currentContext!,
          listen: false,
        ).setUserId(_user!.uid);
      }
      if (_user!.emailVerified == false) {
        await sendEmailVerification();
      }
    }
    notifyListeners();
  }

  Future<void> _setupUsageListener() async {
    _usageSubscription?.cancel();

    try {
      // Get initial data
      final doc =
          await _firestore.collection('user_usage').doc(_user!.uid).get();
      if (doc.exists && doc.data() != null) {
        _userUsage = UserUsage.fromMap(doc.data()!);
      } else {
        _userUsage = UserUsage();
        await _firestore
            .collection('user_usage')
            .doc(_user!.uid)
            .set(_userUsage!.toMap());
      }

      // Check for day change and reset if needed
      if (_userUsage!.lastResetDate.day != DateTime.now().day) {
        _userUsage = UserUsage();
        await _firestore
            .collection('user_usage')
            .doc(_user!.uid)
            .set(_userUsage!.toMap());
      }

      // Set up listener for future updates
      _usageSubscription = _firestore
          .collection('user_usage')
          .doc(_user!.uid)
          .snapshots()
          .listen((snapshot) async {
        if (snapshot.exists && snapshot.data() != null) {
          try {
            _userUsage = UserUsage.fromMap(snapshot.data()!);

            // Check for day change and reset if needed
            if (_userUsage!.lastResetDate.day != DateTime.now().day) {
              _userUsage = UserUsage();
              await _firestore
                  .collection('user_usage')
                  .doc(_user!.uid)
                  .set(_userUsage!.toMap());
            }

            notifyListeners();
          } catch (e) {
            print('Error parsing user usage data: $e');
            // Create new usage data if parsing fails
            _userUsage = UserUsage();
            await _firestore
                .collection('user_usage')
                .doc(_user!.uid)
                .set(_userUsage!.toMap());
          }
        }
      });
    } catch (e) {
      print('Error setting up usage listener: $e');
      // Create a local instance if Firestore fails
      _userUsage = UserUsage();
    }
  }

  @override
  void dispose() {
    _usageSubscription?.cancel();
    super.dispose();
  }

  Future<String?> signUpWithEmail(
      String email, String password, String firstName, String lastName) async {
    String? emailError = ValidationUtils.validateEmail(email);
    if (emailError != null) return emailError;

    String? passwordError = ValidationUtils.validatePassword(password);
    if (passwordError != null) return passwordError;

    String? firstNameError = ValidationUtils.validateName(firstName);
    if (firstNameError != null) return firstNameError;

    String? lastNameError = ValidationUtils.validateName(lastName);
    if (lastNameError != null) return lastNameError;

    try {
      _setLoading(true);
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      await _user?.updateDisplayName('$firstName $lastName');
      await sendEmailVerification();
      await _setupUsageListener();

      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signInWithEmail(String email, String password) async {
    String? emailError = ValidationUtils.validateEmail(email);
    if (emailError != null) return emailError;

    String? passwordError = ValidationUtils.validatePassword(password);
    if (passwordError != null) return passwordError;

    try {
      _setLoading(true);
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      if (!_user!.emailVerified) {
        return 'Please verify your email before signing in';
      }

      await _getProfilePicUrl();
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return 'Google sign-in was cancelled';

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      _profilePicUrl = _user?.photoURL;
      await _saveProfilePicUrl(_profilePicUrl);
      await _setupUsageListener();

      if (NavigationService.currentContext != null) {
        Provider.of<SubscriptionProvider>(
          NavigationService.currentContext!,
          listen: false,
        ).setUserId(_user!.uid);
      }

      return null;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return 'Failed to sign in with Google. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _user?.sendEmailVerification();
    } catch (e) {
      print('Error sending email verification: $e');
    }
  }

  Future<void> signOut() async {
    try {
      if (NavigationService.currentContext != null) {
        Provider.of<SubscriptionProvider>(
          NavigationService.currentContext!,
          listen: false,
        ).setUserId(''); // Use empty string instead of null
      }
      await _auth.signOut();
      await _googleSignIn.signOut();
      _user = null;
      _profilePicUrl = null;
      _usageSubscription?.cancel();
      _userUsage = null;
      await _clearProfilePicUrl();
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'email-already-in-use':
        return 'Email is already in use';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'Authentication error: ${e.message}';
    }
  }

  Future<void> _saveProfilePicUrl(String? url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_pic_url', url ?? '');
  }

  Future<void> _getProfilePicUrl() async {
    final prefs = await SharedPreferences.getInstance();
    _profilePicUrl = prefs.getString('profile_pic_url');
    notifyListeners();
  }

  Future<void> _clearProfilePicUrl() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_pic_url');
  }

  Future<bool> canUseTextGeneration(BuildContext context) async {
    if (_user == null) return false;
    await _setupUsageListener();

    final plan =
        Provider.of<SubscriptionProvider>(context, listen: false).currentPlan;
    if (plan.isUnlimited) return true;

    return _userUsage!.textGenerationCount < plan.textLimit;
  }

  Future<bool> canUseImageGeneration(BuildContext context) async {
    if (_user == null) return false;
    await _setupUsageListener();

    final plan =
        Provider.of<SubscriptionProvider>(context, listen: false).currentPlan;
    return _userUsage!.imageGenerationCount < plan.imageLimit;
  }

  Future<void> incrementTextGeneration() async {
    if (_user == null) return;
    try {
      _userUsage!.textGenerationCount++;
      await _firestore.collection('user_usage').doc(_user!.uid).update({
        'textGenerationCount': _userUsage!.textGenerationCount,
      });
      notifyListeners();
    } catch (e) {
      print('Error incrementing text generation: $e');
      // Revert the increment if the update fails
      _userUsage!.textGenerationCount--;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> incrementImageGeneration() async {
    if (_user == null) return;
    try {
      _userUsage!.imageGenerationCount++;
      await _firestore.collection('user_usage').doc(_user!.uid).update({
        'imageGenerationCount': _userUsage!.imageGenerationCount,
      });
      notifyListeners();
    } catch (e) {
      print('Error incrementing image generation: $e');
      // Revert the increment if the update fails
      _userUsage!.imageGenerationCount--;
      notifyListeners();
      rethrow;
    }
  }

  Future<String?> checkUsageLimits(BuildContext context, String feature) async {
    if (_user == null) {
      return 'Please login to use this feature';
    }

    await _setupUsageListener();
    final plan =
        Provider.of<SubscriptionProvider>(context, listen: false).currentPlan;

    switch (feature) {
      case 'text':
        if (_userUsage!.textGenerationCount >= plan.textLimit) {
          if (plan.type == SubscriptionType.free) {
            return 'Daily limit reached. Upgrade to continue using.';
          }
          return 'Daily limit reached (${plan.textLimit} generations). Try again tomorrow.';
        }
        break;
      case 'image':
        if (_userUsage!.imageGenerationCount >= plan.imageLimit) {
          if (plan.type == SubscriptionType.free) {
            return 'Daily limit reached. Upgrade to continue using.';
          }
          return 'Daily limit reached (${plan.imageLimit} images). Try again tomorrow.';
        }
        break;
    }

    return null;
  }
}
