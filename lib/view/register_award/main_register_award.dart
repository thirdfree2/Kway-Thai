import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class MainRegisterAward extends StatefulWidget {
  const MainRegisterAward({super.key});

  @override
  State<MainRegisterAward> createState() => _MainRegisterAwardState();
}

class _MainRegisterAwardState extends State<MainRegisterAward> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
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
              Center(
                child: StrokeText(
                  text: "ลงทะเบียนรางวัลประกวด",
                  textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 24),
                    color: Colors.red,
                  ),
                  strokeColor: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'รางวัล',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtils.calculateFontSize(context, 16)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 12)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'อันดับ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtils.calculateFontSize(context, 16)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 12)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ประเภท/รุ่น',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtils.calculateFontSize(context, 16)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 12)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'เพศ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtils.calculateFontSize(context, 16)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 12)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'ความสูง',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtils.calculateFontSize(context, 16)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 12)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    'งานประกวด',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtils.calculateFontSize(context, 16)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 12)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                          ),
                          color: Colors.white),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          Text(
                            'เพิ่มรูปถ่ายรางวัล',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {},
                child: const Text(
                  'ตกลง >>>',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
