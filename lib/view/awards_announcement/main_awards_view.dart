import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/video_buffalo_view.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:buffalo_thai/view/register_award/main_register_award.dart';
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
                          fontSize: ScreenUtils.calculateFontSize(context, 26),
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "(1.) แกรนด์แชมป์งานเทศกาลควายไทย อุทัยธานี 2558",
                              maxLines: 3,
                              style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 18),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: BorderRadius.circular(20)),
                            width: 50,
                            height: 50,
                            child: Icon(Icons.camera_alt),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "(2.) แกรนด์แชมป์งานเทศกาลควายไทย อุทัยธานี 2558",
                              maxLines: 3,
                              style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 18),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
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
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("ปิด"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  borderRadius: BorderRadius.circular(20)),
                              width: 50,
                              height: 50,
                              child: Icon(Icons.camera_alt),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainRegisterAward(),
                        ),
                      );
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'เพิ่มรางวัลการแข่งขัน',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
