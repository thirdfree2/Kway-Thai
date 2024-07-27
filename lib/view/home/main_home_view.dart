import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/main_farm_view.dart';
import 'package:buffalo_thai/view/heredity_buffalo/main_heredity_buffalo_view.dart';
import 'package:buffalo_thai/view/history_buffalo/main_history_buffalo_view.dart';
import 'package:buffalo_thai/view/register_award/main_register_award.dart';
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

    return Scaffold(
      backgroundColor: Colors.green[20],
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background-5.jpg"),
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
                                  fontSize:
                                      ScreenUtils.calculateFontSize(context, 19),
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
                                      '@kwaythai',
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
                    height: 150,
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
                        onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context) => FarmView())),
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
                        onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context) => MainHistoryBuffaloView())),
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
                        onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context) => MainHeredityBuffaloView())),
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
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context) => MainRegisterAward())),
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
                    height: screenHeight * 0.22,
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
      ),
    );
  }
}
