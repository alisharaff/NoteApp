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
    apiKey: 'AIzaSyAicq_XHXv3_HzA8zkNSXXoKTqMd_9ME4k',
    appId: '1:1098361411795:web:196e9005d3fde5d5969c26',
    messagingSenderId: '1098361411795',
    projectId: 'notealiapp',
    authDomain: 'notealiapp.firebaseapp.com',
    storageBucket: 'notealiapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWOvj8cU2gdrcaSmCarrUxw4Oy3RyW9Ic',
    appId: '1:1098361411795:android:b04dd43daf137f40969c26',
    messagingSenderId: '1098361411795',
    projectId: 'notealiapp',
    storageBucket: 'notealiapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3mc7eL4qZeKfdR_AK37GU2AuCpgDlLDE',
    appId: '1:1098361411795:ios:a97dc018b77e7147969c26',
    messagingSenderId: '1098361411795',
    projectId: 'notealiapp',
    storageBucket: 'notealiapp.appspot.com',
    androidClientId: '1098361411795-sdq0i9p4cbcoljb4t1007hi99b9eu6ut.apps.googleusercontent.com',
    iosClientId: '1098361411795-gi5q21qie25e0c30o1q1r2f7omu8vuet.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteapp',
  );
}
