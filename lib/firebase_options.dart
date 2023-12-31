// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDTwyBH7cKG3EX1RGPeYya9JlsWNiGjnTU',
    appId: '1:215466985126:web:788c14104e56311b601667',
    messagingSenderId: '215466985126',
    projectId: 'chatterbox-cbe1a',
    authDomain: 'chatterbox-cbe1a.firebaseapp.com',
    storageBucket: 'chatterbox-cbe1a.appspot.com',
    measurementId: 'G-8LJ3VDNJPV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARncrFYE5fd_LQApcP33r8OL07vT9cRkc',
    appId: '1:215466985126:android:84cb5476a62feb4d601667',
    messagingSenderId: '215466985126',
    projectId: 'chatterbox-cbe1a',
    storageBucket: 'chatterbox-cbe1a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqTHqUIInnCMxM9zkVAiSXA6iNnIK6Np0',
    appId: '1:215466985126:ios:0f51ead5b4f2f12f601667',
    messagingSenderId: '215466985126',
    projectId: 'chatterbox-cbe1a',
    storageBucket: 'chatterbox-cbe1a.appspot.com',
    iosBundleId: 'com.example.chatterboxApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqTHqUIInnCMxM9zkVAiSXA6iNnIK6Np0',
    appId: '1:215466985126:ios:59ee04cea22cb844601667',
    messagingSenderId: '215466985126',
    projectId: 'chatterbox-cbe1a',
    storageBucket: 'chatterbox-cbe1a.appspot.com',
    iosBundleId: 'com.example.chatterboxApp.RunnerTests',
  );
}
