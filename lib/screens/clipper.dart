import 'package:flutter/material.dart';

class ClipperImage extends CustomClipper<Path> {
  
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, 4 * size.height / 5);

    p.quadraticBezierTo(1 * size.width / 4, size.height, 1 * size.width / 2,
        4 * size.height / 5);
    p.quadraticBezierTo(3 * size.width / 4, 3 * size.height / 5, size.width,
        4 * size.height / 5);

    p.lineTo(size.width, 0);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipperImage2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p2 = Path();
    p2.lineTo(0, size.height);
    p2.quadraticBezierTo(1 * size.width / 2, 3 * size.height / 4, size.width, size.height);
    p2.lineTo(size.width, 0);
    p2.close();
    return p2;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
