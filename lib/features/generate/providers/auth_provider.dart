import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_ai/utils/validations/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  String? _profilePicUrl;
  bool _isLoading = false;

  AuthProvider() {
    initialize();
  }

  User? get user => _user;

  String? get profilePicUrl => _profilePicUrl;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initialize() async {
    _user = _auth.currentUser;
    if (_user != null) {
      await _getProfilePicUrl();
      if (_user!.emailVerified == false) {
        await sendEmailVerification();
      }
    }
    notifyListeners();
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

      return null;
    } catch (e) {
      return 'Error during Google sign-in: $e';
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
      await _auth.signOut();
      await _googleSignIn.signOut();
      _user = null;
      _profilePicUrl = null;
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
}
