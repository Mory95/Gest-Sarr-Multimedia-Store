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
    apiKey: 'AIzaSyC0hlgsI8leWOSbztcygIPnssXWhq_8afQ',
    appId: '1:827310554680:web:c187525c2f65b22ebf70cd',
    messagingSenderId: '827310554680',
    projectId: 'gest-stock-sms',
    authDomain: 'gest-stock-sms.firebaseapp.com',
    storageBucket: 'gest-stock-sms.appspot.com',
    measurementId: 'G-0J2575077H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDESefgCFP_doAjqloOEs5MxoV7nHiBJjw',
    appId: '1:827310554680:android:580d466bae91c142bf70cd',
    messagingSenderId: '827310554680',
    projectId: 'gest-stock-sms',
    storageBucket: 'gest-stock-sms.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfHnkC2pZLhf3x2nxhiiVFzZYbeK-5iCE',
    appId: '1:827310554680:ios:92bcf8c7cd9fed1fbf70cd',
    messagingSenderId: '827310554680',
    projectId: 'gest-stock-sms',
    storageBucket: 'gest-stock-sms.appspot.com',
    iosClientId:
        '827310554680-89d4su5v9vgcv2ki1t11aat1pddvhm3b.apps.googleusercontent.com',
    iosBundleId: 'com.example.smsBoutique',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfHnkC2pZLhf3x2nxhiiVFzZYbeK-5iCE',
    appId: '1:827310554680:ios:92bcf8c7cd9fed1fbf70cd',
    messagingSenderId: '827310554680',
    projectId: 'gest-stock-sms',
    storageBucket: 'gest-stock-sms.appspot.com',
    iosClientId:
        '827310554680-89d4su5v9vgcv2ki1t11aat1pddvhm3b.apps.googleusercontent.com',
    iosBundleId: 'com.example.smsBoutique',
  );
}