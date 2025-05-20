import 'package:flutter/material.dart';

import '../auth/model/pages/login.dart';

class PushNotifications extends StatelessWidget {
  const PushNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Login()),
    );
  }
}
