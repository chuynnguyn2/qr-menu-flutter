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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC2-yvUpBsRw7OvWJdK4bYYL4H0P7JeIjg',
    appId: '1:873223081579:web:81483b31156574edd6eb2e',
    messagingSenderId: '873223081579',
    projectId: 'qr-menu-dbb2f',
    authDomain: 'qr-menu-dbb2f.firebaseapp.com',
    storageBucket: 'qr-menu-dbb2f.appspot.com',
    measurementId: 'G-WTVJLKFYHJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAelhVck4pScq_XmpVO6VlRUMQaWkRxSE',
    appId: '1:873223081579:android:099f23b83676a5eed6eb2e',
    messagingSenderId: '873223081579',
    projectId: 'qr-menu-dbb2f',
    storageBucket: 'qr-menu-dbb2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcRMpiF3RBnTJGMOA6MEZru9mNSLrP4LE',
    appId: '1:873223081579:ios:d00733a858e3fea8d6eb2e',
    messagingSenderId: '873223081579',
    projectId: 'qr-menu-dbb2f',
    storageBucket: 'qr-menu-dbb2f.appspot.com',
    iosClientId: '873223081579-6fchsipheqnhidoknfm76qrjfr43ub89.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrMenu',
  );
}
