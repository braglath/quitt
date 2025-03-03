import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quitt/utils/log.dart';

import '../firebase_options.dart';

class FirebaseService {
  // Private constructor
  FirebaseService._();

  // Static variable to hold the singleton instance
  static FirebaseService? _instance;

  // Factory method to get the instance
  factory FirebaseService() {
    _instance ??= FirebaseService._();
    return _instance!;
  }

  // Flag to ensure Firebase is initialized only once
  bool _initialized = false;

  // Method to initialize Firebase
  Future<void> initialize() async {
    if (!_initialized) {
      await initializeFirebase();
      firebaseSettings();
      firebaseAuthState();
      _initialized = true;
    } else {
      LogUtil().i('firebase already initialized');
    }
  }

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      LogUtil().e('firebase initialization failed: $e');
    }
  }

  void firebaseSettings() {
    final auth = FirebaseAuth.instance;
    auth.setSettings(
      // Ensure reCAPTCHA is not bypassed
      appVerificationDisabledForTesting: false,
      forceRecaptchaFlow: false,
    );
  }

  void firebaseAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        LogUtil().i('User is currently signed out!');
      } else {
        LogUtil().i('User is signed in!');
      }
    });
  }

  Future<void> verifyPhoneWithSMS() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 8939243462',
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          LogUtil().i('phone number verified: ${credential.signInMethod}');
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          LogUtil().e('verification failed: ${e.code}');
          if (e.code == 'invalid-phone-number') {
            LogUtil().e('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          LogUtil().e('verification code sent: $verificationId');
          // Update the UI - wait for the user to enter the SMS code
          // String smsCode = 'xxxx';
          //
          // // Create a PhoneAuthCredential with the code
          // PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);
          //
          // // Sign the user in (or link) with the credential
          // await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          LogUtil()
              .e('verification code AutoRetrievalTimeout: $verificationId');
        },
      );
    } catch (e) {
      LogUtil().e('verifyPhoneWithSMS failed\n${e.toString()}');
    }
  }
  //
  // Future<void> verifyPhoneWithReCaptcha() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
  //   try {
  //     ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
  //         '+91 8939243462',
  //         RecaptchaVerifier(
  //           auth: auth.app.options,
  //           container: 'recaptcha',
  //           size: RecaptchaVerifierSize.compact,
  //           theme: RecaptchaVerifierTheme.dark,
  //           onSuccess: () => print('reCAPTCHA Completed!'),
  //           onError: (FirebaseAuthException error) => print(error),
  //           onExpired: () => print('reCAPTCHA Expired!'),
  //         ));
  //   } catch (e) {
  //     LogUtil().e('verifyPhoneWithReCaptcha failed\n${e.toString()}');
  //   }
  // }

  Future<void> verifyCode(ConfirmationResult confirmationResult) async {
    UserCredential userCredential = await confirmationResult.confirm('123456');
  }
}
