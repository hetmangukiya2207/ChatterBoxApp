import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Verification ID
  String? verificationId;

  // Verify phone number
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    PhoneAuthProvider phoneAuthProvider = PhoneAuthProvider();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        // Auto sign in the user with the phone auth credential
        await firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException error) {
        FirebaseAuthException error = FirebaseAuthException(
          code: 'FirebaseAuth/InvalidPhoneNumber',
          message: 'Error Please try again after sometimes...',
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Store the verification ID for later use
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        this.verificationId = verificationId;
      },
    );
  }

  // Sign in with phone number
  Future<UserCredential> signInWithPhoneNumber(String verificationCode) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: verificationCode,
    );

    // Sign in the user with the phone auth credential
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(phoneAuthCredential);

    // Return the user credential
    return userCredential;
  }

  // Sign out
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // Get the current user
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
