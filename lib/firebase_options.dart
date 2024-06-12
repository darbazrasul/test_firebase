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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAqRbXXMt26SU31fCDqgv6Z06GFVoc28Ro',
    appId: '1:330770634026:web:b72a1f80e11241f7dfba53',
    messagingSenderId: '330770634026',
    projectId: 'firesttest-d13c6',
    authDomain: 'firesttest-d13c6.firebaseapp.com',
    storageBucket: 'firesttest-d13c6.appspot.com',
    measurementId: 'G-10K6LBLGV4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDi4QoIozuuyZQGUQqtUlOow4pFnOIxysw',
    appId: '1:330770634026:android:e1120e2074bbce66dfba53',
    messagingSenderId: '330770634026',
    projectId: 'firesttest-d13c6',
    storageBucket: 'firesttest-d13c6.appspot.com',
  );
}