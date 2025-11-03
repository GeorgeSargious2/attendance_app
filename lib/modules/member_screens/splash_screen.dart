import 'package:attendance_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'layout/member_layout.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      // Adjust delay as needed
      navigateAndFinish(
        context,
        MemberLayout(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100.h,
          width: 100.w,
          child: Image.asset(
              'assets/WhatsApp_Image_2025-07-12_at_12.41.11_5a2db3da-removebg-preview.png'),
        ), // Replace with your desired content
      ),
    );
  }
}
