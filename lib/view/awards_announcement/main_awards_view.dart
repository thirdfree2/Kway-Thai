import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/video_buffalo_view.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class MainAwardsView extends StatefulWidget {
  const MainAwardsView({super.key});

  @override
  State<MainAwardsView> createState() => _MainAwardsViewState();
}

class _MainAwardsViewState extends State<MainAwardsView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  )
                ],
              ),
              Card(
                color: Colors.white.withOpacity(0.8),
                child: Column(
                  children: [
                    StrokeText(
                      text: "รางวัลงานประกวด",
                      textStyle: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 34),
                          color: Colors.yellow),
                      strokeColor: Colors.black,
                      strokeWidth: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StrokeText(
                          text: "เจ้าซูโม่",
                          textStyle: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 48),
                              color: Colors.red),
                          strokeColor: Colors.white,
                          strokeWidth: 3,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            StrokeText(
                              text: "2",
                              textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 28),
                                  color: Colors.white),
                              strokeColor: Colors.black,
                              strokeWidth: 3,
                            ),
                            StrokeText(
                              text: "(รางวัล)",
                              textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 20),
                                  color: Colors.white),
                              strokeColor: Colors.black,
                              strokeWidth: 3,
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.5,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15) // Adjust the radius as needed
                            ),
                        child: Image.asset(
                          'assets/images/banner-5.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "แกรนด์แชมป์งานเทศกาลควายไทย อุทัยธานี 2558",
                              style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 16),
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              "แชมป์รุ่นเล็กงานกระบือแห่งชาติ ขอนแก่น 2558",
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 13),
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
