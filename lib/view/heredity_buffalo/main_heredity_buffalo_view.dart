import 'dart:convert';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_wrapper.dart';
import 'package:buffalo_thai/view/promote_buffalo/main_promote_buffalo_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';

class MainHeredityBuffaloView extends StatefulWidget {
  const MainHeredityBuffaloView({super.key});

  @override
  State<MainHeredityBuffaloView> createState() => _MainHeredityBuffaloViewState();
}

class _MainHeredityBuffaloViewState extends State<MainHeredityBuffaloView> {
  late Future<List<BuffaloModel>> futureBuffaloes;
  List<BuffaloModel> filteredBuffaloes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureBuffaloes = fetchHistoryBuffaloes();

    futureBuffaloes.then((buffaloes) {
      setState(() {
        filteredBuffaloes = buffaloes; // ตั้งค่าเริ่มต้นเป็น futureBuffaloes
      });
    });

    // ฟังการเปลี่ยนแปลงของช่องค้นหา
    searchController.addListener(() {
      filterBuffaloes();
    });
  }

  void filterBuffaloes() async {
  String query = searchController.text.trim().toLowerCase(); // Trim ข้อมูลและแปลงเป็นตัวพิมพ์เล็ก
  List<BuffaloModel> buffaloList = await futureBuffaloes;

  // เช็คว่า buffaloList มีข้อมูลหรือไม่
  if (buffaloList.isNotEmpty) {
    setState(() {
      if (query.isNotEmpty) {
        filteredBuffaloes = buffaloList.where((buffalo) {
          // ตรวจสอบว่าชื่อควายมีค่าและไม่เป็น null หรือ empty ก่อนทำการกรอง
          if (buffalo.name != null && buffalo.name.isNotEmpty) {
            return buffalo.name.toLowerCase().contains(query);
          }
          return false;
        }).toList();
      } else {
        // คืนค่าเป็นข้อมูลทั้งหมดเมื่อไม่มีการค้นหา
        filteredBuffaloes = buffaloList;
      }
    });
  } else {
    setState(() {
      filteredBuffaloes = [];
    });
  }
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
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 35),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              StrokeText(
                text: "พันธุกรรมเหล่ากอ",
                textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 30),
                    color: Colors.red),
                strokeColor: Colors.white,
                strokeWidth: 6,
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: screenWidth / 1.5,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red,
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.white,
                      hintText: 'ค้นหา',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (searchController.text.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: screenHeight * 0.5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StrokeText(
                                  text:
                                      'พบควายที่ค้นหา (${filteredBuffaloes.length})',
                                  textStyle: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 14),
                                    color: Colors.white,
                                  ),
                                  strokeColor: Colors.black,
                                  strokeWidth: 3,
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'ล้างการค้นหา',
                                          style: TextStyle(color: Colors.white),
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
                                    imagePath: 'https://placeholder.com/150',
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
                                        builder: (context) => PromoteBuffalo(),
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
                                      StrokeText(
                                        text: buffalo.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textStyle: TextStyle(
                                          fontSize: ScreenUtils.calculateFontSize(
                                              context, 12),
                                          color: Colors.white,
                                        ),
                                        strokeColor: Colors.black,
                                        strokeWidth: 3,
                                      ),
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
                ),
              if (!searchController.text.isNotEmpty)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder<List<BuffaloModel>>(
                      future: futureBuffaloes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No buffaloes found.'));
                        }
          
                        final buffaloes = snapshot.data!;
          
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final buffalo = buffaloes[index];
                            final profileImage = buffalo.buffaloImages.firstWhere(
                              (image) => image.isProfileImage,
                              orElse: () => BuffaloImageModel(
                                imageId: 0,
                                imagePath: 'https://placeholder.com/150',
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
                                    .setSelectedBuffalo(
                                        buffalo); // Assuming 'name' is a property in BuffaloModel
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PromoteBuffalo(),
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  StrokeText(
                                    text: buffalo
                                        .name, // Assuming 'name' is a property in BuffaloModel
                                    textStyle: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                          context, 12),
                                      color: Colors.white,
                                    ),
                                    strokeColor: Colors.black,
                                    strokeWidth: 3,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
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
