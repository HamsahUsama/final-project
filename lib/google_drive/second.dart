// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../component/tcolor.dart';
// import 'first.dart';
// import 'upload.dart';

// class Second extends StatefulWidget {
//   String url;
//   Second({required this.url});

//   @override
//   State<Second> createState() => _SecondState(url: url);
// }

// class _SecondState extends State<Second> {
//   String url;
//   _SecondState({required this.url});

//   GoogleSignIn _googleSignIn = GoogleSignIn();
//   final _auth = FirebaseAuth.instance;
//   TextEditingController title = TextEditingController();
//   CollectionReference ref = FirebaseFirestore.instance.collection('users');

//   var options = ['PDF', 'Image', 'video'];
//   bool value = false;
//   var _currentItemSelected = "PDF";

//   @override
//   Widget build(BuildContext context) {
//     User? user = _auth.currentUser;
//     final Stream<QuerySnapshot> _usersStream =
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uid)
//             .collection('folders')
//             .snapshots();
//     return Scaffold(
//       appBar: AppBar(
//         leading: CircleAvatar(
//           backgroundColor: Tcolor.background,
//           radius: 50, // Image radius
//           backgroundImage: AssetImage("assets/images/plantIcon.png"),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _googleSignIn
//                   .signOut()
//                   .then((value) {
//                     setState(() {});
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => (First())),
//                     );
//                   })
//                   .catchError((e) {});
//             },
//             icon: Icon(Icons.logout),
//           ),
//         ],
//         backgroundColor: Tcolor.buttonColor2,
//         title: Row(
//           children: [
//             Text(
//               'The',
//               style: TextStyle(color: Tcolor.background, fontSize: 35),
//             ),
//             Text(
//               'Result',
//               style: TextStyle(color: Tcolor.background, fontSize: 35),
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: _usersStream,
//             builder: (
//               BuildContext context,
//               AsyncSnapshot<QuerySnapshot> snapshot,
//             ) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Text("Loading");
//               }

//               return ListView(
//                 children:
//                     snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data()! as Map<String, dynamic>;
//                       return GestureDetector(
//                         onTap: () {
//                           print(data['type']);
//                           print(document.id);

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder:
//                                   (context) => (Upload(
//                                     url: url,
//                                     did: document.id,
//                                     type: data['type'],
//                                   )),
//                             ),
//                           );
//                         },
//                         child: ListTile(
//                           // leading: (data['type'] == "PDF" || data['type'] == "Image")
//                           //     ? ((data['type'] == "PDF")
//                           //         ? (Icon(
//                           //             Icons.picture_as_pdf,
//                           //           ))
//                           //         : (Icon(
//                           //             Icons.image,
//                           //           )))
//                           //     : (Icon(
//                           //         Icons.play_circle_fill,
//                           //       )),
//                           leading: Icon(
//                             Icons.folder,
//                             color: Tcolor.buttonColor2,
//                             size: 50,
//                           ),
//                           title: Text(data['name']),
//                           subtitle: Text(data['type']),
//                         ),
//                       );
//                     }).toList(),
//               );
//             },
//           ),
//           Positioned(
//             bottom: 10,
//             // left: 0,
//             right: 10,
//             child: Center(
//               child: FloatingActionButton(
//                 onPressed: () async {
//                   await showInformationDialog(context);
//                 },
//                 child: Icon(Icons.add),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> showInformationDialog(BuildContext context) async {
//     return await showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         bool isChecked = false;
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               content: Form(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller: title,
//                       validator: (value) {
//                         // return value.isNotEmpty ? null : "Enter any text";
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Please Enter Text",
//                       ),
//                     ),
//                     SizedBox(height: 40),
//                     DropdownButton<String>(
//                       dropdownColor: Color.fromARGB(255, 239, 243, 250),
//                       isDense: true,
//                       isExpanded: false,
//                       iconEnabledColor: Tcolor.buttonColor2,
//                       // focusColor: Color.fromARGB(255, 245, 245, 245),
//                       items:
//                           options.map((String dropDownStringItem) {
//                             return DropdownMenuItem<String>(
//                               value: dropDownStringItem,
//                               child: Text(
//                                 dropDownStringItem,
//                                 style: TextStyle(
//                                   color: Tcolor.textcolor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                       onChanged: (newValueSelected) {
//                         setState(() {
//                           _currentItemSelected = newValueSelected!;
//                           print(_currentItemSelected);
//                         });
//                       },
//                       value: _currentItemSelected,
//                     ),
//                     SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//               title: Text('Stateful Dialog'),
//               actions: <Widget>[
//                 InkWell(
//                   child: Text('Cancel'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     // }
//                   },
//                 ),
//                 SizedBox(width: 40),
//                 InkWell(
//                   child: Text('Create'),
//                   onTap: () {
//                     if (title.text != '') {
//                       User? user = _auth.currentUser;
//                       ref.doc(user!.uid).collection('folders').add({
//                         'name': title.text,
//                         'type': _currentItemSelected,
//                       });
//                       title.clear();
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//                 SizedBox(width: 40),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
