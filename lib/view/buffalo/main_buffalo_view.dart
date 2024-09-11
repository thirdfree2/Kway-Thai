import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';

class MainBuffaloView extends StatefulWidget {
  const MainBuffaloView({super.key});

  @override
  State<MainBuffaloView> createState() => _MainBuffaloViewState();
}

class _MainBuffaloViewState extends State<MainBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final buffalo = Provider.of<SelectedBuffalo>(context).buffalo;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final profileImage = buffalo?.buffaloImages.firstWhere(
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

    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background-2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                        ),
                        child: const Icon(
                          Icons.home,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth / 5),
                  child: Container(
                    height:
                        screenHeight * 0.75, // Adjusted to accommodate image
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(65),
                        bottomLeft: Radius.circular(65),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: StrokeText(
                              text: "ประวัติ",
                              textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 14),
                                color: Colors.black,
                              ),
                              strokeColor: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          Center(
                            child: StrokeText(
                              text: buffalo?.name ?? '',
                              textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 24),
                                color: Colors.red,
                              ),
                              strokeColor: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.35,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  _buildInfoRow(
                                      'ควายไทย เพศ ', 'ผู้', Colors.blue[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow('สี ', 'ดำ', Colors.black),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'เกิด ',
                                      buffalo?.birthDate?.toString() ?? '',
                                      Colors.amber[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow('เกิดที่ ลอก/ฟาร์ม ',
                                      'บ้านคึกควายไทย', Colors.green[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'โดยวิธีการ ',
                                      buffalo?.birthMethod ?? '',
                                      Colors.red[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'พ่อพันธุ์ คือ',
                                      buffalo?.father?.name ?? '',
                                      Colors.red[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'แม่พันธุ์ คือ ',
                                      buffalo?.mother?.name ?? '',
                                      Colors.red[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'สายเลือดทางปู่คือ ',
                                      buffalo?.fatherGrandfatherName ?? '',
                                      Colors.pink[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'สายเลือดทางย่าคือ ',
                                      buffalo?.fatherGrandmotherName ?? '',
                                      Colors.pink[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'สายเลือดทางตาคือ ',
                                      buffalo?.motherGrandfatherName ?? '',
                                      Colors.pink[800]),
                                  const SizedBox(height: 5),
                                  _buildInfoRow(
                                      'สายเลือดทางยายคือ ',
                                      buffalo?.motherGrandmotherName ?? '',
                                      Colors.pink[800]),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'สืบสายเลือดปู่ทวดคือ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  _buildInfoRow(
                                      'คือ ',
                                      buffalo?.fatherGreatGrandfatherName ?? '',
                                      Colors.pink[800]),
                                  const Text(
                                    'สืบสายเลือดตาทวดคือ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  _buildInfoRow(
                                      'คือ ',
                                      buffalo?.motherGreatGrandfatherName ?? '',
                                      Colors.pink[800]),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
            right: screenWidth * 0.05,
            bottom: screenHeight * 0.075,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    const Text(
                      'สังกัดปัจจุบัน',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      color: Colors.green[500],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          buffalo?.currentFarm?.farmName ?? 'Not Found 404',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.025,
            left: 20,
            child: Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.29,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color? color) {
    return Row(
      children: [
        AutoSizeText(
          label,
          maxFontSize: 13,
          maxLines: 2,
          style:
              TextStyle(fontSize: ScreenUtils.calculateFontSize(context, 13)),
        ),
        AutoSizeText(
          value,
          maxFontSize: 13,
          maxLines: 2,
          style: TextStyle(
            color: color,
            fontSize: ScreenUtils.calculateFontSize(context, 13),
            decoration: TextDecoration.underline,
            decorationColor: color,
            decorationThickness: 2,
          ),
        ),
      ],
    );
  }
}
