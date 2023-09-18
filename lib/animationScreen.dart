// ignore_for_file: camel_case_types

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenScreenState createState() => _AnimationScreenScreenState();
}

class _AnimationScreenScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  double percentage = 0.0;

  // Color color = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )
      ..addListener(() {
        setState(() {
          percentage = (_controller.value * 100).roundToDouble();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat(reverse: true);
          // color = Colors.pink; uncomment this if you want to change the bg color after the loading finished

          //add a animations you want after loading finished
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.r),
                  borderRadius: BorderRadius.circular(10.r)),
              width: 45.h,
              height: 200.h,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: ClipPath(
                      clipper: loadBar(_controller.value),
                      child: Container(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            '$percentage%',
            style: GoogleFonts.electrolize(
              fontSize: 12.sp,
              letterSpacing: 1.r,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class loadBar extends CustomClipper<Path> {
  final double animationValue;

  loadBar(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();

    final topEdgeY = size.height * (1 - animationValue);

    path.moveTo(0, topEdgeY);
    path.lineTo(size.width, topEdgeY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
