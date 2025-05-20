import 'package:flutter/material.dart';

import '../component/tcolor.dart';
import 'clipper.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Tcolor.background,
              child: Column(
                children: [
                  ClipPath(
                    clipper: ClipperImage2(),
                    child: Image(
                      image: AssetImage('assets/images/Homepage3.jpg'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    width: 250,
                    child: Center(
                      child: Text(
                        "Welcome to the world of plants ",
                        style: TextStyle(
                          fontFamily: 'assets/fonts/Poppins-Bold.ttf',
                          fontSize: 30,
                          color: Tcolor.textcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Tcolor.buttonColor,
                    ),
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        label: Text(
                          "some tips",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Tcolor.background,
                          ),
                        ),
                        icon: Icon(
                          Icons.lightbulb_sharp,
                          color: Tcolor.background,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: 430,
                    decoration: BoxDecoration(
                      color: Tcolor.lemonYellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: '/fonts/Poppins-Bold.ttf',
                          fontWeight: FontWeight.normal,
                          color: Tcolor.textcolor,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: "Use Natural Fertilizers: ",
                            style: TextStyle(
                              fontFamily: '/fonts/Poppins-Bold.ttf',
                              fontWeight: FontWeight.bold,
                              color: Tcolor.textcolor,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Organic fertilizers like compost enrich the soil without harmful chemicals.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: 430,
                    decoration: BoxDecoration(
                      color: Tcolor.lemonYellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: '/fonts/Poppins-Bold.ttf',
                          fontWeight: FontWeight.normal,
                          color: Tcolor.textcolor,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: "Choose the Right Soil:  ",
                            style: TextStyle(
                              fontFamily: '/fonts/Poppins-Bold.ttf',
                              fontWeight: FontWeight.bold,
                              color: Tcolor.textcolor,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Ensure that your soil is suitable for the type of plant you are growing.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: 430,
                    decoration: BoxDecoration(
                      color: Tcolor.lemonYellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: '/fonts/Poppins-Bold.ttf',
                          fontWeight: FontWeight.normal,
                          color: Tcolor.textcolor,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: "Sunlight:  ",
                            style: TextStyle(
                              fontFamily: '/fonts/Poppins-Bold.ttf',
                              fontWeight: FontWeight.bold,
                              color: Tcolor.textcolor,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Most crops require at least 6-8 hours of direct sunlight daily to grow healthy.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: 430,
                    decoration: BoxDecoration(
                      color: Tcolor.lemonYellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: '/fonts/Poppins-Bold.ttf',
                          fontWeight: FontWeight.normal,
                          color: Tcolor.textcolor,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: "Harvest on Time:  ",
                            style: TextStyle(
                              fontFamily: '/fonts/Poppins-Bold.ttf',
                              fontWeight: FontWeight.bold,
                              color: Tcolor.textcolor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Harvest crops when they reach maturity to get the best yield and quality.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
