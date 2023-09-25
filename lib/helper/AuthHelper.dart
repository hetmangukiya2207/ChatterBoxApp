import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'FirestoreHelper.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper auth_helper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> SigninAnonymous() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User?> SignUp(
      {required String email,
      required String password,
      required String username}) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<Map<String, dynamic>> SignIn(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      FirestoreHelper.fireStore_Helper.addUser(data: {
        "email": userCredential.user?.email,
        "uid": userCredential.user?.uid,
      });
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  // SigninWith Google
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);

    User? user = userCredential.user;
    FirestoreHelper.fireStore_Helper.addUser(data: {
      "email": user?.email,
      "uid": user?.uid,
    });
    return user;
  }

  // SignIn With Facebook

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  void SignOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
