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
    apiKey: 'AIzaSyCMYvKxmauI6ApofOy1CvtoupvHu83E5w8',
    appId: '1:20566826325:web:936df7de17d4bcfbc923dc',
    messagingSenderId: '20566826325',
    projectId: 'notes-877b6',
    authDomain: 'notes-877b6.firebaseapp.com',
    storageBucket: 'notes-877b6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASGYrZRC7PPsVk536AOpVt03tp8IvFEaI',
    appId: '1:20566826325:android:89ee9e6396c413dcc923dc',
    messagingSenderId: '20566826325',
    projectId: 'notes-877b6',
    storageBucket: 'notes-877b6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0WmdeK7yA5Tb1aBeVP3dsagXFzFgE-3E',
    appId: '1:20566826325:ios:477d6befbfee857ac923dc',
    messagingSenderId: '20566826325',
    projectId: 'notes-877b6',
    storageBucket: 'notes-877b6.appspot.com',
    iosClientId: '20566826325-4oa2rhstiq2omtnkv8dlgbdkk0bl7ago.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0WmdeK7yA5Tb1aBeVP3dsagXFzFgE-3E',
    appId: '1:20566826325:ios:d3405242a54a60f2c923dc',
    messagingSenderId: '20566826325',
    projectId: 'notes-877b6',
    storageBucket: 'notes-877b6.appspot.com',
    iosClientId: '20566826325-eaunj1mcl326ndincrfumocjeesjrfcs.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes.RunnerTests',
  );
}
