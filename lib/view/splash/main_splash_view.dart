import 'dart:async';

import 'package:buffalo_thai/mainwrapper.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/auth/main_auth_view.dart';
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
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainAuthView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StrokeText(
                text: "สวัสดี",
                textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 20),
                    color: Colors.white),
                strokeColor: Colors.black,
                strokeWidth: 4,
              ),
              StrokeText(
                text: "ควายไทย",
                textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 28),
                    color: Colors.red),
                strokeColor: Colors.white,
                strokeWidth: 6,
              ),
              StrokeText(
                text: "KWAY THAI",
                textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 20),
                    color: Colors.white),
                strokeColor: Colors.black,
                strokeWidth: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
