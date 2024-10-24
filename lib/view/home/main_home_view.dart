import 'package:buffalo_thai/model/annouce_model.dart';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/services/anounce_services.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/view/promote_buffalo/main_promote_buffalo_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:buffalo_thai/view/farm/main_farm_view.dart';
import 'package:buffalo_thai/view/farm_register/main_farm_register.dart';
import 'package:buffalo_thai/view/history_buffalo/main_history_buffalo_view.dart';
import 'package:buffalo_thai/view/heredity_buffalo/main_heredity_buffalo_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<BuffaloModel>> futureBuffaloes;
  late Future<List<BuffaloModel>> allBuffalo;
  late Future<List<AnnouceModel>> annoucement;

  List<BuffaloModel> filteredBuffaloes = []; // รายการที่กรองแล้ว
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureBuffaloes = fetchBuffaloesPromoteBuff(); // ข้อมูลการโปรโมท
    allBuffalo = fetchAllBuffaloes(); // ข้อมูลควายทั้งหมด
    annoucement = fetchAnnouce();

    allBuffalo.then((buffaloes) {
      setState(() {
        filteredBuffaloes = buffaloes; // ตั้งค่าเริ่มต้นเป็น allBuffalo
      });
    });

    // ฟังการเปลี่ยนแปลงของช่องค้นหา
    searchController.addListener(() {
      filterBuffaloes();
    });
  }

  // ฟังก์ชันสำหรับกรอง buffalo.name ตามค่าที่พิมพ์ใน TextFormField
  void filterBuffaloes() async {
    String query = searchController.text
        .toLowerCase(); // เปลี่ยนเป็นตัวพิมพ์เล็กเพื่อง่ายต่อการค้นหา
    List<BuffaloModel> buffaloList =
        await allBuffalo; // โหลดข้อมูลทั้งหมดจาก Future

    setState(() {
      if (query.isNotEmpty) {
        // กรองชื่อควายที่มีใน buffaloList ตามคำค้นหา
        filteredBuffaloes = buffaloList
            .where((buffalo) => buffalo.name.toLowerCase().contains(query))
            .toList();
      } else {
        // คืนค่าเป็นข้อมูลทั้งหมดเมื่อไม่มีการค้นหา
        filteredBuffaloes = buffaloList;
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // ปิดตัวควบคุมเมื่อ widget ถูกทำลาย
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    CarouselSliderController buttonCarouselController =
        CarouselSliderController();

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              opacity: 0.7,
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            child: SingleChildScrollView(
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
                                        context, 12),
                                  ),
                                ),
                                Text(
                                  'ควายไทย',
                                  style: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                        context,
                                        21,
                                      ),
                                      color: Colors.white),
                                ),
                                Text(
                                  'KWAY THAI',
                                  style: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                        context,
                                        21,
                                      ),
                                      color: Colors.black),
                                ),
                                // StrokeText(
                                //   text: "ควายไทย",
                                //   textStyle: TextStyle(
                                //       fontSize: ScreenUtils.calculateFontSize(
                                //           context, 21),
                                //       color: Colors.red),
                                //   strokeColor: Colors.white,
                                //   strokeWidth: 6,
                                // ),
                                // StrokeText(
                                //   text: "KWAY THAI",
                                //   textStyle: TextStyle(
                                //       fontSize: ScreenUtils.calculateFontSize(
                                //           context, 15),
                                //       color: Colors.white),
                                //   strokeColor: Colors.black,
                                //   strokeWidth: 4,
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (!searchController.text.isNotEmpty)
                                  FutureBuilder<List<BuffaloModel>>(
                                    future: futureBuffaloes,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator(); // แสดงโหลดเดอร์ขณะรอ
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            'Error: ${snapshot.error}'); // แสดงข้อความเมื่อเกิดข้อผิดพลาด
                                      } else if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        BuffaloModel firstBuffalo = snapshot
                                            .data![0]; // เข้าถึงข้อมูลตัวแรก

                                        final profileImage = firstBuffalo
                                            .buffaloImages
                                            .firstWhere(
                                          (image) => image.isProfileImage,
                                          orElse: () => BuffaloImageModel(
                                            imageId: 0,
                                            imagePath:
                                                'https://placeholder.com/150',
                                            isProfileImage: false,
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                            buffaloId: firstBuffalo.id,
                                          ),
                                        );

                                        final imageUrl = profileImage != null
                                            ? profileImage.imagePath
                                            : 'https://placeholder.com/150';
                                        return InkWell(
                                          onTap: () {
                                            Provider.of<SelectedBuffalo>(
                                                    context,
                                                    listen: false)
                                                .setSelectedBuffalo(
                                                    firstBuffalo);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PromoteBuffalo(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                firstBuffalo.name,
                                                style: TextStyle(
                                                    fontSize: ScreenUtils
                                                        .calculateFontSize(
                                                      context,
                                                      12,
                                                    ),
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                width: screenHeight *
                                                    0.12, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                                                height: screenHeight *
                                                    0.12, // ใช้ screenHeight เพื่อให้เท่ากับขนาดของไอคอนด้านล่าง
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15), // ปรับแต่งความโค้งของมุมตามต้องการ
                                                ),
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )

                                              // StrokeText(
                                              //   text: firstBuffalo.name,
                                              //   textStyle: TextStyle(
                                              //       fontSize: ScreenUtils
                                              //           .calculateFontSize(
                                              //               context, 10),
                                              //       color: Colors.red),
                                              //   strokeColor: Colors.white,
                                              //   strokeWidth: 3,
                                              // ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const Text(
                                            'No Buffaloes found'); // เมื่อไม่มีข้อมูล
                                      }
                                    },
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
                                controller: searchController,
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
                                                'https://lin.ee/Uu7X7Vsa', // Replace with your Line ID URL
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
                  if (!searchController.text.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<List<BuffaloModel>>(
                          future: futureBuffaloes,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // แสดงโหลดเดอร์ขณะรอ
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: ${snapshot.error}'); // แสดงข้อความเมื่อเกิดข้อผิดพลาด
                            } else if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty) {
                              // ถ้ามีข้อมูลและไม่ว่าง
                              List<BuffaloModel> buffaloList = snapshot.data!;

                              // ถ้าข้อมูลมีมากกว่า 1 buffalo ให้ข้ามรายการแรก
                              if (buffaloList.length > 1) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        buffaloList.length - 1, (index) {
                                      // เริ่มที่ index 1
                                      BuffaloModel buffalo =
                                          buffaloList[index + 1];

                                      final profileImage =
                                          buffalo.buffaloImages.firstWhere(
                                        (image) => image.isProfileImage,
                                        orElse: () => BuffaloImageModel(
                                          imageId: 0,
                                          imagePath:
                                              'https://placeholder.com/150',
                                          isProfileImage: false,
                                          createdAt: DateTime.now(),
                                          updatedAt: DateTime.now(),
                                          buffaloId: buffalo.id,
                                        ),
                                      );

                                      final imageUrl = profileImage.imagePath;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Provider.of<SelectedBuffalo>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedBuffalo(
                                                        buffalo);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const PromoteBuffalo(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: screenHeight * 0.09,
                                                height: screenHeight * 0.09,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              buffalo.name,
                                              style: TextStyle(
                                                  fontSize: ScreenUtils
                                                      .calculateFontSize(
                                                    context,
                                                    12,
                                                  ),
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // StrokeText(
                                            //   text: buffalo.name,
                                            //   textStyle: TextStyle(
                                            //     fontSize:
                                            //         ScreenUtils.calculateFontSize(
                                            //             context, 10),
                                            //     color: Colors.red,
                                            //   ),
                                            //   strokeColor: Colors.white,
                                            //   strokeWidth: 3,
                                            // ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              } else {
                                return const Text(
                                    'No additional buffaloes found');
                              }
                            } else {
                              return const Text(
                                  'No Buffaloes found'); // เมื่อไม่มีข้อมูล
                            }
                          },
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (!searchController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                "ข่าวประชาสัมพันธ์",
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 20),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FutureBuilder<List<AnnouceModel>>(
                              future:
                                  annoucement, // Future ที่จะดึงข้อมูลประกาศ
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // กรณีที่กำลังโหลดข้อมูล
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  // กรณีที่เกิดข้อผิดพลาดในการดึงข้อมูล
                                  return Center(
                                      child: Text(
                                          'เกิดข้อผิดพลาด: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  // กรณีไม่มีข้อมูลที่จะแสดง
                                  return const Center(
                                      child: Text('ไม่พบประกาศใดๆ'));
                                } else {
                                  // กรณีดึงข้อมูลได้สำเร็จ
                                  final annoucements = snapshot.data!;

                                  // สร้าง List<Widget> สำหรับ CarouselSlider
                                  final List<Widget> child =
                                      annoucements.map((annouce) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("ประชาสัมพันธ์"),
                                              content: Image.network(
                                                annouce
                                                    .filepath, // ใช้ URL ของรูปภาพจาก AnnouceModel
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Text(
                                                      'ไม่สามารถโหลดรูปภาพได้');
                                                },
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // ปิด Popup
                                                  },
                                                  child: const Text("ปิด"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: screenWidth,
                                        height: screenHeight * 0.18,
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15), // ปรับ radius ตามต้องการ
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Image.network(
                                          annouce
                                              .filepath, // ใช้ URL ของรูปภาพจาก AnnouceModel
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                              child: Text(
                                                'ไม่สามารถโหลดรูปภาพได้',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList();

                                  // แสดง CarouselSlider ด้วย child ที่สร้างจาก annoucements
                                  return CarouselSlider(
                                    items: child,
                                    carouselController:
                                        buttonCarouselController,
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      viewportFraction: 0.9,
                                      aspectRatio: 2.0,
                                      initialPage: 0,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!searchController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FarmView())),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: screenHeight * 0.09,
                                        width: screenHeight * 0.09,
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/buffalo.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "คอก/ฟาร์ม",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenUtils.calculateFontSize(
                                                    context, 10),
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainHistoryBuffaloView())),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                      Text(
                                        "คอก/ฟาร์ม",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenUtils.calculateFontSize(
                                                    context, 10),
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainHeredityBuffaloView())),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 243, 243, 243),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                      Text(
                                        "พันธุกรรม",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenUtils.calculateFontSize(
                                                    context, 10),
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                              Color.fromARGB(
                                                  255, 255, 227, 225),
                                              Color.fromARGB(255, 255, 98, 86),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                    Text(
                                      "ลงทะเบียน",
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 10),
                                        color: Colors.white,
                                      ),
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
                  if (searchController.text.isNotEmpty)
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: screenHeight * 0.5,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'พบควายที่ค้นหา (${filteredBuffaloes.length})',
                                      style: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 14),
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        searchController.text = '';
                                      },
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              'ล้างการค้นหา',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: filteredBuffaloes.length,
                                  itemBuilder: (context, index) {
                                    final buffalo = filteredBuffaloes[index];
                                    final profileImage =
                                        buffalo.buffaloImages.firstWhere(
                                      (image) => image.isProfileImage,
                                      orElse: () => BuffaloImageModel(
                                        imageId: 0,
                                        imagePath:
                                            'https://placeholder.com/150',
                                        isProfileImage: false,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        buffaloId: buffalo.id,
                                      ),
                                    );

                                    final imageUrl = profileImage != null
                                        ? profileImage.imagePath
                                        : 'https://placeholder.com/150';

                                    return InkWell(
                                      onTap: () {
                                        Provider.of<SelectedBuffalo>(context,
                                                listen: false)
                                            .setSelectedBuffalo(buffalo);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PromoteBuffalo(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            buffalo.name,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize:
                                                  ScreenUtils.calculateFontSize(
                                                      context, 12),
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
