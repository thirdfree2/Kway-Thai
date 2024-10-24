import 'dart:async';

import 'package:buffalo_thai/mainwrapper.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/auth/main_auth_view.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class MainSplashView extends StatefulWidget {
  const MainSplashView({super.key});

  @override
  State<MainSplashView> createState() => _MainSplashViewState();
}

class _MainSplashViewState extends State<MainSplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              opacity: 0.8,
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "สวัสดี",
                style: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 20),
                    color: Colors.black),
              ),
              Text(
                "ควายไทย",
                style: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 20),
                    color: Colors.white),
              ),
              Text(
                "KWAY THAI",
                style: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 20),
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
