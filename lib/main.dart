import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:plant_disease_application/google_drive/first.dart';
import 'notification/app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider(
      'your-recaptcha-site-key',
    ), // إذا كنت تدعم الويب
    androidProvider: AndroidProvider.debug, // استخدم `playIntegrity` في الإنتاج
    appleProvider:
        AppleProvider.debug, // استخدم `deviceCheck` أو `appAttest` في الإنتاج
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(const PushNotifications());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Plant disease',
//       theme: ThemeData(),
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
