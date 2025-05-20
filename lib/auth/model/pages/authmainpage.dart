import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../screens/firstscreen.dart';
import '../shared/snackbar.dart';
import 'login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "myApp",
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasError) {
            return showSnackBar(context, "Something went wrong");
          } else if (snapshot.hasData) {
            return Firstscreen();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
