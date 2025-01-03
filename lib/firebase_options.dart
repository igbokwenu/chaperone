// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAE0HSpqVd_WfwPpXPB21YKMJoEIvTv8iQ',
    appId: '1:338700867842:web:3673a1dddb060d88954a1b',
    messagingSenderId: '338700867842',
    projectId: 'chaperonegame',
    authDomain: 'chaperonegame.firebaseapp.com',
    storageBucket: 'chaperonegame.firebasestorage.app',
    measurementId: 'G-8FJ0CCYKVR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2G4QXQauRdmBs2U4MsKGItJuJUdx6abI',
    appId: '1:338700867842:android:5b20594c0a7ff7a9954a1b',
    messagingSenderId: '338700867842',
    projectId: 'chaperonegame',
    storageBucket: 'chaperonegame.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAji7w3QC4pUVxyDb_RqgNCf2Fs5-pwr04',
    appId: '1:338700867842:ios:9dad0d27e7d4a856954a1b',
    messagingSenderId: '338700867842',
    projectId: 'chaperonegame',
    storageBucket: 'chaperonegame.firebasestorage.app',
    iosClientId: '338700867842-ej4cl0g1lrg659hvt0fmbrkfveiq0t7q.apps.googleusercontent.com',
    iosBundleId: 'com.increasedw.chaperonegame',
  );

}