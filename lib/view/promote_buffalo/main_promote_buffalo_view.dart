import 'package:buffalo_thai/view/buffalo/update_buffalo_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';

class MainPromoteBuffaloView extends StatefulWidget {
  const MainPromoteBuffaloView({super.key});

  @override
  State<MainPromoteBuffaloView> createState() => _MainPromoteBuffaloViewState();
}

class _MainPromoteBuffaloViewState extends State<MainPromoteBuffaloView> {
  String _formatDateToBuddhist(DateTime date) {
    // แปลงปี ค.ศ. เป็น พ.ศ. โดยบวกเพิ่ม 543
    final thaiDate = DateTime(date.year + 543, date.month, date.day);
    return DateFormat('dd MMMM yyyy', 'th_TH')
        .format(thaiDate); // กำหนดฟอร์แมตวันที่
  }

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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()),
                            ),
                            child: const Icon(
                              Icons.home,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth / 5),
                  child: Container(
                    height: screenHeight * 0.75,
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
                          SizedBox(
                            height: screenHeight * 0.35,
                            child: ListView(
                              // เปลี่ยนจาก SingleChildScrollView เป็น ListView
                              children: [
                                const SizedBox(height: 10),
                                if (buffalo?.gender != '')
                                  _buildInfoRow('ควายไทย เพศ ',
                                      buffalo?.gender ?? '-', Colors.blue[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.color != '')
                                  _buildInfoRow('สี ', buffalo?.color ?? '',
                                      Colors.black),
                                const SizedBox(height: 5),
                                if (buffalo?.birthDate != '')
                                  _buildInfoRow(
                                    'เกิด ',
                                    buffalo?.birthDate != '-'
                                        ? _formatDateToBuddhist(buffalo!
                                            .birthDate!) // เรียกฟังก์ชันสำหรับแปลงวันที่
                                        : '-',
                                    Colors.amber[800],
                                  ),
                                const SizedBox(height: 5),
                                if (buffalo?.bornAt != '')
                                  _buildInfoRow(
                                      'เกิดที่ ลอก/ฟาร์ม ',
                                      buffalo?.bornAt ?? '-',
                                      Colors.green[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.birthMethod != null)
                                  _buildInfoRow(
                                      'โดยวิธีการ ',
                                      buffalo?.birthMethod ?? '-',
                                      Colors.red[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.fatherName != '')
                                  _buildInfoRow(
                                      'พ่อพันธุ์ คือ',
                                      buffalo?.fatherName ?? '-',
                                      Colors.red[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.motherName != '')
                                  _buildInfoRow(
                                      'แม่พันธุ์ คือ ',
                                      buffalo?.motherName ?? '-',
                                      Colors.red[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.fatherGrandfatherName != '')
                                  _buildInfoRow(
                                      'สายเลือดทางปู่',
                                      buffalo?.fatherGrandfatherName ?? '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.fatherGrandmotherName != '')
                                  _buildInfoRow(
                                      'สายเลือดทางย่า',
                                      buffalo?.fatherGrandmotherName ?? '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.motherGrandfatherName != '')
                                  _buildInfoRow(
                                      'สายเลือดทางตา',
                                      buffalo?.motherGrandfatherName ?? '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.motherGrandmotherName != '')
                                  _buildInfoRow(
                                      'สายเลือดทางยาย',
                                      buffalo?.motherGrandmotherName ?? '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.fatherGreatGrandfatherName != '')
                                  _buildInfoRow(
                                      'สืบสายเลือดปู่ทวด',
                                      buffalo?.fatherGreatGrandfatherName ??
                                          '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.motherGreatGrandfatherName != '')
                                  _buildInfoRow(
                                      'สืบสายเลือดตาทวด',
                                      buffalo?.motherGreatGrandfatherName ??
                                          '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.fatherGreatGrandmotherName != '')
                                  _buildInfoRow(
                                      'สืบสายเลือดย่าทวด',
                                      buffalo?.fatherGreatGrandmotherName ??
                                          '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 5),
                                if (buffalo?.motherGreatGrandmotherName != '')
                                  _buildInfoRow(
                                      'สืบสายเลือดยายทวด',
                                      buffalo?.motherGreatGrandmotherName ??
                                          '-',
                                      Colors.pink[800]),
                                const SizedBox(height: 10),
                              ],
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
                    Container(
                      width: 150,
                      child: Card(
                        color: Colors.green[500],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            buffalo?.farm?.farmName ?? 'Not Found 404',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 2, // กำหนดจำนวนบรรทัดสูงสุดของข้อความ
                            overflow: TextOverflow
                                .ellipsis, // ทำให้ข้อความที่ยาวเกินไปแสดง ... (ellipsis)
                          ),
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
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the popup
                          },
                          child: Text("ปิด"),
                        ),
                      ],
                    );
                  },
                );
              },
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color? color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: AutoSizeText(
            '$label ',
            maxFontSize: 13,
            maxLines: 2,
            style:
                TextStyle(fontSize: ScreenUtils.calculateFontSize(context, 13)),
          ),
        ),
        Flexible(
          child: AutoSizeText(
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
        ),
      ],
    );
  }
}
