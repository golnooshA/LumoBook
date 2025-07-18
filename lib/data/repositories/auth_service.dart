import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<User?> signUpWithEmail(String email, String password, String name) async {
    try {
      log('Attempting sign up with email: $email');
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user?.updateDisplayName(name);
      await cred.user?.reload();

      log('User registered: ${_auth.currentUser?.uid}');
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException during sign up: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Unknown error during sign up: $e');
      rethrow;
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      log('Attempting login with email: $email');
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Login successful: ${cred.user?.uid}');
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException during login: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Unknown error during login: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      log('Signing out user');
      await _auth.signOut();
      await _googleSignIn.signOut();
      log('User signed out successfully');
    } catch (e) {
      log('Sign-out error: $e');
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      log('Starting Google Sign-In');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        log('Google Sign-In cancelled');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);
      log('Google Sign-In successful: ${userCred.user?.email}');
      return userCred.user;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException during Google sign-in: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      log('Unknown error during Google sign-in: $e');
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      log('Deleting user account');
      await _auth.currentUser?.delete();
      log('Account deleted');
    } catch (e) {
      log('Delete account error: $e');
      rethrow;
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      log('Changing user password');
      await _auth.currentUser?.updatePassword(newPassword);
      log('Password changed successfully');
    } catch (e) {
      log('Password change error: $e');
      rethrow;
    }
  }
}
