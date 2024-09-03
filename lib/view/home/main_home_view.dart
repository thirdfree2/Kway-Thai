import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/main_farm_view.dart';
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart';
import 'package:buffalo_thai/view/farm_register/main_farm_register.dart';
import 'package:buffalo_thai/view/heredity_buffalo/main_heredity_buffalo_view.dart';
import 'package:buffalo_thai/view/history_buffalo/main_history_buffalo_view.dart';
import 'package:buffalo_thai/view/register_award/main_register_award.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;

    CarouselSliderController buttonCarouselController =
        CarouselSliderController();

    final List<Widget> child = [
      Container(
        width: screenWidth,
        height: screenHeight * 0.18,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(15) // Adjust the radius as needed
            ),
        child: Image.asset(
          'assets/images/banner-4.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: screenWidth,
        height: screenHeight * 0.18,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(15) // Adjust the radius as needed
            ),
        child: Image.asset(
          'assets/images/banner-4.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: screenWidth,
        height: screenHeight * 0.18,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(15) // Adjust the radius as needed
            ),
        child: Image.asset(
          'assets/images/banner-4.jpg',
          fit: BoxFit.cover,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.green[20],
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background-2.jpg"),
                fit: BoxFit.cover),
          ),
          child: Container(
            height: screenHeight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
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
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 19),
                                ),
                              ),
                              StrokeText(
                                text: "ควายไทย",
                                textStyle: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 26),
                                    color: Colors.red),
                                strokeColor: Colors.white,
                                strokeWidth: 6,
                              ),
                              StrokeText(
                                text: "KWAY THAI",
                                textStyle: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 19),
                                    color: Colors.white),
                                strokeColor: Colors.black,
                                strokeWidth: 4,
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                child: Container(
                                  width: screenHeight *
                                      0.2, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                                  height: screenHeight *
                                      0.2, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        15), // ปรับแต่งความโค้งของมุมตามต้องการ
                                  ),
                                  child: Image.asset(
                                    'assets/images/banner-5.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                fillColor: Colors.white.withOpacity(0.8),
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
                                child: Card(
                                  color: Colors.white.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        QrImageView(
                                          data:
                                              'https://line.me/r/@kwaythai', // Replace with your Line ID URL
                                          version: QrVersions.auto,
                                          size: screenWidth * 0.2,
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          '@kwaythai',
                                          style: TextStyle(
                                            fontSize:
                                                ScreenUtils.calculateFontSize(
                                                    context, 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      height: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15), // ปรับแต่งความโค้งของมุมตามต้องการ
                      ),
                      child: Image.asset(
                        'assets/images/banner-1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      height: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15), // ปรับแต่งความโค้งของมุมตามต้องการ
                      ),
                      child: Image.asset(
                        'assets/images/banner-2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      height: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15), // ปรับแต่งความโค้งของมุมตามต้องการ
                      ),
                      child: Image.asset(
                        'assets/images/banner-3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      height: screenHeight *
                          0.10, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15), // ปรับแต่งความโค้งของมุมตามต้องการ
                      ),
                      child: Image.asset(
                        'assets/images/banner-4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FarmView())),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * 0.09,
                                    width: screenHeight * 0.09,
                                    child: const Center(
                                      child: Icon(
                                        Icons.pets_outlined,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StrokeText(
                                    text: "คอก/ฟาร์ม",
                                    textStyle: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 14),
                                        color: Colors.black),
                                    strokeColor: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainHistoryBuffaloView())),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * 0.09,
                                    width: screenHeight * 0.09,
                                    child: const Center(
                                      child: Icon(
                                        Icons.menu_book_sharp,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StrokeText(
                                    text: "ประวัติ",
                                    textStyle: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 14),
                                        color: Colors.black),
                                    strokeColor: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainHeredityBuffaloView())),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * 0.09,
                                    width: screenHeight * 0.09,
                                    child: const Center(
                                      child: Icon(
                                        Icons.share,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StrokeText(
                                    text: "พันธุกรรม",
                                    textStyle: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 14),
                                        color: Colors.black),
                                    strokeColor: Colors.white,
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
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainFarmRegister())),
                                  child: Container(
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
                                    height: screenHeight * 0.09,
                                    width: screenHeight * 0.09,
                                    child: const Center(
                                      child: Icon(
                                        Icons.person_outlined,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                StrokeText(
                                  text: "ลงทะเบียน",
                                  textStyle: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                          context, 14),
                                      color: Colors.black),
                                  strokeColor: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          StrokeText(
                            text: "ข่าวประชาสัมพันธ์",
                            textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 20),
                                color: Colors.red),
                            strokeColor: Colors.white,
                            strokeWidth: 3,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CarouselSlider(
                          items: child,
                          carouselController: buttonCarouselController,
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            aspectRatio: 2.0,
                            initialPage: 2,
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
      ),
    );
  }
}
