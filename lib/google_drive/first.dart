//
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// class PredictionScreen extends StatefulWidget {
//   const PredictionScreen({super.key});

//   @override
//   State<PredictionScreen> createState() => _PredictionScreenState();
// }

// class _PredictionScreenState extends State<PredictionScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _setupFCM();
//   }

//   Future<void> _setupFCM() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await messaging.requestPermission();
//     print('User granted permission: ${settings.authorizationStatus}');

//     String? token = await messaging.getToken();
//     if (token != null) {
//       await FirebaseFirestore.instance.collection('fcm_tokens').doc(token).set({
//         'token': token,
//         'created_at': FieldValue.serverTimestamp(),
//       });
//     }

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(message.notification!.body ?? 'New Notification'),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mango Predictions')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance
//                 .collection('predictions')
//                 .orderBy('timestamp', descending: true)
//                 .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No predictions yet."));
//           }

//           final predictions = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: predictions.length,
//             itemBuilder: (context, index) {
//               var data = predictions[index];
//               return Card(
//                 margin: const EdgeInsets.all(8),
//                 child: ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: data['image_url'],
//                     placeholder:
//                         (context, url) => const CircularProgressIndicator(),
//                     errorWidget:
//                         (context, url, error) => const Icon(Icons.error),
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(data['prediction'] ?? ''),
//                   subtitle: Text(data['image_name'] ?? ''),
//                   trailing: Text(
//                     data['timestamp'] != null
//                         ? (data['timestamp'] as Timestamp)
//                             .toDate()
//                             .toString()
//                             .split(".")[0]
//                         : '',
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("📩 Background message: ${message.notification?.title}");
// }

// Future<void> initNotifications() async {
//   const AndroidInitializationSettings androidInitSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initSettings = InitializationSettings(
//     android: androidInitSettings,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initSettings);
// }

// Future<void> showImageNotification(RemoteMessage message) async {
//   final title = message.notification?.title ?? 'No Title';
//   final body = message.notification?.body ?? 'No Body';
//   final imageUrl = message.notification?.android?.imageUrl ?? '';

//   String? filePath;
//   if (imageUrl.isNotEmpty) {
//     final response = await http.get(Uri.parse(imageUrl));
//     final tempDir = await getTemporaryDirectory();
//     filePath = '${tempDir.path}/notif.jpg';
//     final file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//   }

//   final style =
//       filePath != null
//           ? BigPictureStyleInformation(
//             FilePathAndroidBitmap(filePath),
//             contentTitle: title,
//             summaryText: body,
//           )
//           : null;

//   final androidDetails = AndroidNotificationDetails(
//     'image_channel',
//     'Image Notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//     styleInformation: style,
//   );

//   final details = NotificationDetails(android: androidDetails);
//   await flutterLocalNotificationsPlugin.show(0, title, body, details);
// }

// class PredictionScreen extends StatefulWidget {
//   @override
//   State<PredictionScreen> createState() => _PredictionScreenState();
// }

// class _PredictionScreenState extends State<PredictionScreen> {
//   @override
//   void initState() {
//     super.initState();
//     requestPermission();
//     registerFCMToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showImageNotification(message);
//     });
//   }

//   void requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission();
//     print('User granted permission: ${settings.authorizationStatus}');
//   }

//   void registerFCMToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print("FCM Token: $token");
//     // اختياري: أرسل التوكن لـ Firestore بنفس طريقة الكود في الـ backend
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("إشعارات النبات")),
//         body: Center(child: Text("منتظرين الإشعارات...")),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path/path.dart';

// // 🔔 إعداد إشعارات FCM
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> setupFCM() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     final notification = message.notification;
//     final imageUrl =
//         notification?.android?.imageUrl ?? notification?.apple?.imageUrl;

//     if (notification != null) {
//       flutterLocalNotificationsPlugin.show(
//         0,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'channel_id',
//             'Notifications',
//             importance: Importance.max,
//             priority: Priority.high,
//             styleInformation:
//                 imageUrl != null
//                     ? BigPictureStyleInformation(
//                       NetworkImage(imageUrl) as AndroidBitmap<Object>,
//                       contentTitle: notification.title,
//                       summaryText: notification.body,
//                     )
//                     : null,
//           ),
//         ),
//       );
//     }
//   });

//   // 🔐 حفظ توكن الجهاز في Firestore
//   final token = await FirebaseMessaging.instance.getToken();
//   if (token != null) {
//     await FirebaseFirestore.instance.collection("fcm_tokens").doc(token).set({
//       'token': token,
//       'created_at': FieldValue.serverTimestamp(),
//     });
//   }

//   // التعامل مع الإشعارات عند كون التطبيق في الخلفية
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // إضافة الإشعار هنا بناءً على الرسالة المستلمة
// }

// // 🚀 التطبيق الرئيسي
// class PredictionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'تحليل النبات',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// // 🧭 الصفحة الرئيسية
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Plant Disease Analysis System")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton.icon(
//               icon: Icon(Icons.upload),
//               label: Text("Upload Image"),
//               onPressed:
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => UploadImagePage()),
//                   ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               icon: Icon(Icons.history),
//               label: Text("View Previous Analyses"),
//               onPressed:
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => PredictionHistory()),
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 📤 رفع صورة
// class UploadImagePage extends StatefulWidget {
//   @override
//   _UploadImagePageState createState() => _UploadImagePageState();
// }

// class _UploadImagePageState extends State<UploadImagePage> {
//   File? _imageFile;

//   Future<void> pickAndUploadImage(BuildContext context) async {
//     // تمرير context هنا
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile == null) return;

//     setState(() => _imageFile = File(pickedFile.path));

//     final fileName =
//         "images/${DateTime.now().millisecondsSinceEpoch}_${basename(pickedFile.path)}";
//     final ref = FirebaseStorage.instance.ref().child(fileName);
//     await ref.putFile(_imageFile!);

//     final downloadUrl = await ref.getDownloadURL(); // ✅ رابط الصورة

//     // ✅ احفظ بيانات الصورة في Firestore
//     await FirebaseFirestore.instance.collection('predictions').add({
//       'image_url': downloadUrl,
//       'image_name': basename(pickedFile.path),
//       'prediction': 'جارٍ التحليل...', // سيتم استبداله لاحقًا بعد التحليل
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     // إرسال إشعار عند رفع الصورة بنجاح
//     FirebaseMessaging.instance.subscribeToTopic('new_uploads');
//     FirebaseMessaging.instance.sendMessage(
//       to: '/topics/new_uploads',
//       data: {
//         'title': 'New Image Uploaded',
//         'body': 'A new image has been uploaded and is being processed.',
//       },
//     );

//     // عرض SnackBar باستخدام context الممرر
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           '✅ Image uploaded successfully. Please wait for the analysis...',
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Upload Image")),
//       body: Column(
//         children: [
//           if (_imageFile != null) Image.file(_imageFile!),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => pickAndUploadImage(context), // تمرير context هنا
//             child: Text("Choose and Upload Image"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 📄 عرض سجل التحليلات
// class PredictionHistory extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Previous Analyses")),
//       body: StreamBuilder(
//         stream:
//             FirebaseFirestore.instance
//                 .collection('predictions')
//                 .orderBy('timestamp', descending: true)
//                 .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData)
//             return Center(child: CircularProgressIndicator());
//           final docs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final data = docs[index].data() as Map<String, dynamic>;
//               return ListTile(
//                 leading: Image.network(
//                   data['image_url'],
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                   errorBuilder:
//                       (_, __, ___) => Icon(Icons.broken_image, size: 50),
//                 ),
//                 title: Text("Prediction: ${data['prediction']}"),
//                 subtitle: Text("Image: ${data['image_name']}"),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// إضافة صفحة جديدة لعرض تفاصيل الصورة والتنبؤ
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_disease_application/component/tcolor.dart';

// Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
}

class PredictionScreen extends StatefulWidget {
  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int _selectedIndex = 0;

  final List<Widget> _screens = [PredictionsList()];

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final iosSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.subscribeToTopic('predictions');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.messageId}');
      RemoteNotification? notification = message.notification;
      Map<String, dynamic> data = message.data;

      String title =
          notification?.title ?? data['prediction'] ?? 'Notification';
      String body = notification?.body ?? data['image_name'] ?? '';
      String imageUrl = data['image_url'] ?? '';

      _showNotificationWithImage(title, body, imageUrl);
    });
  }

  Future<void> _showNotificationWithImage(
    String title,
    String body,
    String imageUrl,
  ) async {
    String? bigPicturePath;

    if (imageUrl.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(imageUrl));
        final bytes = response.bodyBytes;

        final tempDir = await getTemporaryDirectory();
        final file =
            await File('${tempDir.path}/notification_image.jpg').create();
        await file.writeAsBytes(bytes);
        bigPicturePath = file.path;
      } catch (e) {
        print('Image download error: $e');
      }
    }

    final style =
        bigPicturePath != null
            ? BigPictureStyleInformation(
              FilePathAndroidBitmap(bigPicturePath),
              largeIcon: FilePathAndroidBitmap(bigPicturePath),
              contentTitle: title,
              summaryText: body,
            )
            : BigTextStyleInformation(body, contentTitle: title);

    final androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: style,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(0, title, body, details);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Predictions')),
        body: _screens[_selectedIndex],
        // تم إزالة الـ BottomNavigationBar بناءً على طلبك السابق
      ),
    );
  }
}

// شاشة عرض سجل التوقعات
class PredictionsList extends StatelessWidget {
  final CollectionReference predictionsCollection = FirebaseFirestore.instance
      .collection('predictions');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          predictionsCollection
              .orderBy('timestamp', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error loading data'));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) return Center(child: Text('No predictions yet'));

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final imageUrl = data['image_url'] ?? '';
            final prediction = data['prediction'] ?? 'Unknown';
            final imageName = data['image_name'] ?? 'Unnamed';

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading:
                    imageUrl.isNotEmpty
                        ? Image.network(
                          imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                        : Icon(Icons.image_not_supported),
                title: Text(prediction),
                subtitle: Text(imageName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PredictionDetailScreen(
                            imageUrl: imageUrl,
                            imageName: imageName,
                            prediction: prediction,
                          ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

// صفحة تفاصيل التنبؤ مع عرض الصورة والبيانات
class PredictionDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String imageName;
  final String prediction;

  const PredictionDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.imageName,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prediction Details',
          style: TextStyle(color: Tcolor.background),
        ),
        backgroundColor: Tcolor.buttonColor,
      ),
      body: Container(
        height: 500,
        margin: const EdgeInsets.all(16), // مسافة margin من جميع الجهات
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  imageUrl.isNotEmpty
                      ? Image.network(imageUrl, fit: BoxFit.contain)
                      : Icon(Icons.image_not_supported, size: 100),
            ),
            const SizedBox(height: 16),
            Text(
              'Image Name: $imageName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Tcolor.textcolor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Prediction: $prediction',
              style: TextStyle(fontSize: 16, color: Tcolor.textcolor),
            ),
          ],
        ),
      ),
    );
  }
}
