import 'package:flutter/material.dart';

import '../component/tcolor.dart';
import 'clipper.dart';
import 'mainscreen.dart';

class Firstscreen extends StatelessWidget {
  const Firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Tcolor.background,
        child: Column(
          children: [
            Container(
              color: Tcolor.background,
              width: double.infinity,
              child: SizedBox(
                child: Column(
                  children: [
                    ClipPath(
                      clipper: ClipperImage(),
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/background.jpg'),
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 300,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Tcolor.textcolor,
                                    fontFamily: 'fonts/Poppins-Regular.ttf',
                                  ),

                                  children: [
                                    const TextSpan(
                                      text:
                                          "Discover and protect your plants with the",
                                    ),
                                    TextSpan(
                                      text: " Plant Disease app",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Tcolor.secoundTextColor,
                                        fontFamily: 'fonts/Poppins-Bold.ttf',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mainscreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Tcolor.buttonColor,
                        elevation: 2,
                      ),

                      child: Text(
                        'Countinue',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Tcolor.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
