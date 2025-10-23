import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:nilean/config.dart';
import 'package:nilean/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.sendEmailVerification();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw 'Sign Up Error: ${e.message}';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    try {
      await googleSignIn.initialize(
        clientId: Config.googleAuthClientId,
        serverClientId: Config.googleServerClientId,
      );

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );
      final user = await FirebaseAuth.instance.signInWithCredential(credential);

      final userBox = await Hive.openBox('user');
      await userBox.put(
        'user',
        UserModel(
          uid: user.user!.uid,
          email: user.user!.email.toString(),
          name: user.user?.displayName,
          isEmailVerified: user.user?.emailVerified ?? false,
          registrationComplete: user.user?.displayName != null,
        ),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Google Sign-In Error: ${e.message}');
      throw 'Sign In Error: ${e.message}';
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      throw 'Sign In Error: $e';
    }
  }

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userBox = await Hive.openBox('user');
      await userBox.put(
        'user',
        UserModel(
          uid: user.user!.uid,
          email: user.user!.email.toString(),
          name: user.user?.displayName,
          isEmailVerified: user.user?.emailVerified ?? false,
          registrationComplete: user.user?.displayName != null,
        ),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw 'Sign In Error: ${e.message}';
    } catch (e) {
      throw 'Sign In Error: $e';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await Hive.deleteFromDisk();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> isEmailVerified() async {
    await _firebaseAuth.currentUser?.reload();

    final userBox = await Hive.openBox('user');
    await userBox.put(
      'user',
      UserModel(
        uid: currentUser!.uid,
        email: currentUser!.email.toString(),
        name: currentUser?.displayName,
        registrationComplete: false,
        isEmailVerified: true,
      ),
    );

    return _firebaseAuth.currentUser?.emailVerified ?? false;
  }

  User? get currentFirebaseUser => _firebaseAuth.currentUser;
  Future<void> completeRegistration(String name) async {
    try {
      Future.delayed(const Duration(seconds: 2));
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();

        final userBox = await Hive.openBox('user');
        await userBox.put(
          'user',
          UserModel.fromJson({
            'uid': currentUser?.uid,
            'email': currentUser?.email,
            'name': currentUser?.displayName,
            'registrationComplete': true,
            'isEmailVerified': true,
          }),
        );
      }
    } on FirebaseException catch (e) {
      throw 'Error completing registration: ${e.message}';
    }
  }
}
