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
    apiKey: 'AIzaSyDRtfruoyHNC-Kzr_SGxnGJBvXmM7rDBAA',
    appId: '1:780909776597:web:aa7d2e132403226ace5c5c',
    messagingSenderId: '780909776597',
    projectId: 'arfriend-47efa',
    authDomain: 'arfriend-47efa.firebaseapp.com',
    storageBucket: 'arfriend-47efa.appspot.com',
    measurementId: 'G-TM7GRLEP2F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2yNNwoccMOr624B7mFgV7Q7GnHPa0rtc',
    appId: '1:780909776597:android:217665f89f769079ce5c5c',
    messagingSenderId: '780909776597',
    projectId: 'arfriend-47efa',
    storageBucket: 'arfriend-47efa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQKZ80nmuyIqu8Ds-0L6g9AA4sVsXAICU',
    appId: '1:780909776597:ios:d230240682e84bffce5c5c',
    messagingSenderId: '780909776597',
    projectId: 'arfriend-47efa',
    storageBucket: 'arfriend-47efa.appspot.com',
    iosClientId: '780909776597-9eetdosmk7tjir3o791h6ltje3481aog.apps.googleusercontent.com',
    iosBundleId: 'com.arfriendv2.app',
  );
}
