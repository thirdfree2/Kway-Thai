import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stroke_text/stroke_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green[20],
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background-3.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth / 1.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'สวัสดี',
                              style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 20),
                              ),
                            ),
                            StrokeText(
                              text: "ควายไทย",
                              textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 28),
                                  color: Colors.red),
                              strokeColor: Colors.white,
                              strokeWidth: 6,
                            ),
                            StrokeText(
                              text: "KWAY THAI",
                              textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 20),
                                  color: Colors.white),
                              strokeColor: Colors.black,
                              strokeWidth: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'ค้นหา',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  QrImageView(
                                    data:
                                        'https://line.me/r/@kwaythai', // Replace with your Line ID URL
                                    version: QrVersions.auto,
                                    size: screenWidth * 0.2,
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    'Line Id : @kwaythai',
                                    style: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                          context, 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: screenWidth,
                  height: 120,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/farm'),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 80,
                            width: 80,
                            child: const Center(
                              child: Icon(
                                Icons.pets_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          StrokeText(
                            text: "คอก/ฟาร์ม",
                            textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 13),
                                color: Colors.white),
                            strokeColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/buffHistory'),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            
                            height: 80,
                            width: 80,
                            child: const Center(
                              child: Icon(
                                Icons.menu_book_sharp,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          
                          StrokeText(
                            text: "ประวัติ",
                            textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 13),
                                color: Colors.white),
                            strokeColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/buffHeredity'),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 80,
                            width: 80,
                            child: const Center(
                              child: Icon(
                                Icons.share,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          StrokeText(
                            text: "พันธุกรรม",
                            textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 13),
                                color: Colors.white),
                            strokeColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 255, 227, 225),
                                Color.fromARGB(255, 255, 98, 86),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 80,
                          width: 80,
                          child: const Center(
                            child: Icon(
                              Icons.person_outlined,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        StrokeText(
                          text: "ลงทะเบียน",
                          textStyle: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 13),
                              color: Colors.white),
                          strokeColor: Colors.black,
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  StrokeText(
                    text: "ข่าวประชาสัมพันธ์",
                    textStyle: TextStyle(
                        fontSize: ScreenUtils.calculateFontSize(context, 20),
                        color: Colors.red),
                    strokeColor: Colors.white,
                    strokeWidth: 3,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: screenWidth,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          15) // Adjust the radius as needed
                      ),
                  child: Image.asset(
                    'assets/images/banner-4.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
