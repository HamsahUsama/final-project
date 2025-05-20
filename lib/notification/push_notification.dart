// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class PushNotificationservice {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;

//   static Future init() async {
//     await messaging.requestPermission();
//     String? token = await messaging.getToken();
//     log(token ?? 'null');
//     FirebaseMessaging.onBackgroundMessage(handlebackgroundmessage);
//   }

//   static Future<void> handlebackgroundmessage(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     log(message.notification?.title ?? 'null');
//   }
// }
