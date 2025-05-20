// to upload image
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// class ImageGallery extends StatefulWidget {
//   @override
//   _ImageGalleryState createState() => _ImageGalleryState();
// }

// class _ImageGalleryState extends State<ImageGallery> {
//   final ImagePicker _picker = ImagePicker();
//   List<File> _localImages = [];

//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.instance.subscribeToTopic('allUsers');

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final String? imageUrl = message.data['imageUrl'];
//       if (imageUrl != null) {
//         _saveImageLocally(imageUrl);
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('📸 New image added!')));
//       }
//     });
//   }

//   Future<void> uploadImage() async {
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile == null) return;

//     File file = File(pickedFile.path);
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final storageRef = FirebaseStorage.instance.ref().child(
//       'images/$fileName.jpg',
//     );

//     await storageRef.putFile(file);
//     final downloadUrl = await storageRef.getDownloadURL();

//     await FirebaseFirestore.instance.collection('images').add({
//       'url': downloadUrl,
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('✅ Image uploaded successfully!')));
//   }

//   Future<void> _saveImageLocally(String imageUrl) async {
//     try {
//       final response = await http.get(Uri.parse(imageUrl));
//       final directory = await getApplicationDocumentsDirectory();
//       final fileName = imageUrl.split('/').last.split('?').first;
//       final file = File('${directory.path}/$fileName');

//       await file.writeAsBytes(response.bodyBytes);
//       setState(() {
//         _localImages.add(file);
//       });
//     } catch (e) {
//       print("Error saving image locally: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("📷 Image Gallery"),
//         actions: [IconButton(icon: Icon(Icons.upload), onPressed: uploadImage)],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance
//                 .collection('images')
//                 .orderBy('timestamp', descending: true)
//                 .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData)
//             return Center(child: CircularProgressIndicator());

//           final docs = snapshot.data!.docs;
//           final firestoreImages =
//               docs.map((doc) => doc['url'] as String).toList();

//           return ListView(
//             children: [
//               ...firestoreImages.map((url) => Image.network(url)).toList(),
//               ..._localImages.map((file) => Image.file(file)).toList(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plant_disease_application/screens/download/firebase_file.dart';
import 'package:plant_disease_application/screens/download/firebaseapi.dart';
import 'package:plant_disease_application/screens/download/image_page_first_option.dart';

class Myimage extends StatelessWidget {
  static final String title = 'Firebase Download';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ImageGallery(),
  );
}

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(Myimage.title), centerTitle: true),
    body: FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Some error occurred!'));
            } else {
              final files = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(files.length),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return buildFile(context, file);
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
    leading: ClipOval(
      child: Image.network(file.url, width: 52, height: 52, fit: BoxFit.cover),
    ),
    title: Text(
      file.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.blue,
      ),
    ),
    onTap:
        () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => ImagePage(file: file))),
  );

  Widget buildHeader(int length) => ListTile(
    tileColor: Colors.blue,
    leading: Container(
      width: 52,
      height: 52,
      child: Icon(Icons.file_copy, color: Colors.white),
    ),
    title: Text(
      '$length Files',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}
