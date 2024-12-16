import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  String? _profilePicUrl;

  AuthProvider() {
    initialize();
  }

  User? get user => _user;
  String? get profilePicUrl => _profilePicUrl;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in was canceled');
        return;
      }

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

      print('User signed in: ${_user?.displayName}');
      notifyListeners();
    } catch (error) {
      print('Error during Google sign-in: $error');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    _profilePicUrl = null;
    await _clearProfilePicUrl();
    notifyListeners();
  }

  Future<void> _saveProfilePicUrl(String? url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_pic_url', url ?? '');
  }

  Future<void> _getProfilePicUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _profilePicUrl = prefs.getString('profile_pic_url') ?? '';
    notifyListeners();
  }

  Future<void> _clearProfilePicUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_pic_url');
  }

  void initialize() async {
    _user = _auth.currentUser;
    if (_user != null) {
      await _getProfilePicUrl();
    }
    notifyListeners();
  }
}
