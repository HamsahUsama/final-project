import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plant_disease_application/screens/download/storageimage.dart';
import 'package:plant_disease_application/screens/chatbot.dart';
import '../component/tcolor.dart';
import '../google_drive/first.dart';
import 'controlscreen.dart';
import 'homescreen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Mainscreen> {
  int index = 2;

  final item = [
    Myimage(),
    PredictionScreen(),
    Homescreen(),
    BotScreen(),
    RobotControlScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: item[index],
      backgroundColor: Tcolor.background,
      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(iconTheme: IconThemeData(color: Tcolor.background)),
        child: CurvedNavigationBar(
          color: Color.fromARGB(221, 0, 100, 0),

          backgroundColor: Colors.transparent,

          height: 50,
          index: index,

          onTap: (index) => setState(() => this.index = index),

          animationCurve: Curves.bounceInOut,
          animationDuration: Duration(milliseconds: 500),
          items: [
            Icon(Icons.notifications_active),
            Icon(Icons.image_rounded),
            Icon(Icons.home),
            Icon(Icons.chat),
            Icon(Icons.control_camera),
          ],
        ),
      ),
    );
  }
}
