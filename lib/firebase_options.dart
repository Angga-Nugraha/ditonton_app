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
    apiKey: 'AIzaSyCGtGE3Ww0SKUyd-zpiZgzvkwOdWAoNyDA',
    appId: '1:957666081711:web:57bbf6c828e056e8524d5a',
    messagingSenderId: '957666081711',
    projectId: 'ditonton-8208e',
    authDomain: 'ditonton-8208e.firebaseapp.com',
    storageBucket: 'ditonton-8208e.appspot.com',
    measurementId: 'G-W6M8QN9WKB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8lX1EnN8hcjIScn1pqUQgPW4b2-tNPEE',
    appId: '1:957666081711:android:1f6b2283c4b711b4524d5a',
    messagingSenderId: '957666081711',
    projectId: 'ditonton-8208e',
    storageBucket: 'ditonton-8208e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmvvcMX-JR82HVY8fOl3PSUFbopVOgWQQ',
    appId: '1:957666081711:ios:7f9cb0e4a985f5fc524d5a',
    messagingSenderId: '957666081711',
    projectId: 'ditonton-8208e',
    storageBucket: 'ditonton-8208e.appspot.com',
    iosClientId: '957666081711-7sha70fl00fok56q16sf2rg2hre9vrc8.apps.googleusercontent.com',
    iosBundleId: 'com.example.submissionAkhir',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmvvcMX-JR82HVY8fOl3PSUFbopVOgWQQ',
    appId: '1:957666081711:ios:7f9cb0e4a985f5fc524d5a',
    messagingSenderId: '957666081711',
    projectId: 'ditonton-8208e',
    storageBucket: 'ditonton-8208e.appspot.com',
    iosClientId: '957666081711-7sha70fl00fok56q16sf2rg2hre9vrc8.apps.googleusercontent.com',
    iosBundleId: 'com.example.submissionAkhir',
  );
}
