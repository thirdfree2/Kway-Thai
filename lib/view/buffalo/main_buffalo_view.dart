import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/awards_announcement/main_awards_view.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/video_buffalo_view.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class MainBuffaloView extends StatefulWidget {
  const MainBuffaloView({super.key});

  @override
  State<MainBuffaloView> createState() => _MainBuffaloViewState();
}

class _MainBuffaloViewState extends State<MainBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final selectedBuffalo = Provider.of<SelectedBuffalo>(context);
    final buffaloNames = selectedBuffalo.buffalo;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background-1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth / 5),
                  child: Container(
                    height: screenHeight * 0.8, // Adjusted to accommodate image
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
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
                              text: buffaloNames,
                              textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 24),
                                color: Colors.red,
                              ),
                              strokeColor: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow(
                              'ควายไทย เพศ ', 'ผู้', Colors.blue[800]),
                          _buildInfoRow('สี ', 'ดำ', Colors.black),
                          _buildInfoRow('เกิด ', 'ปี 2560', Colors.amber[800]),
                          _buildInfoRow('เกิดที่ ลอก/ฟาร์ม ', 'บ้านคึกควายไทย',
                              Colors.green[800]),
                          _buildInfoRow(
                              'โดยวิธีการ ', 'ผสมจริง', Colors.red[800]),
                          _buildInfoRow('พ่อพันธุ์ ', 'เจ้าหนุ่ม(กำนันโป๊ด)',
                              Colors.red[800]),
                          _buildInfoRow(
                              'กับ แม่พันธุ์ ', 'แม่บุญมาก', Colors.red[800]),
                          _buildInfoRow('สายเลือดทางปู่คือ ',
                              'ทองสุข(เปี่ยวใหญ่)', Colors.pink[800]),
                          _buildInfoRow('สายเลือดทางย่าคือ ', 'ควายสายอุทัย',
                              Colors.pink[800]),
                          _buildInfoRow('สายเลือดทางตาคือ ',
                              'เจ้าแอ(กำนัดโป๊ด)', Colors.pink[800]),
                          _buildInfoRow('สายเลือดทางยายคือ ', 'แม่บุญลู่',
                              Colors.pink[800]),
                          const SizedBox(height: 15),
                          const Text(
                            'สืบสายเลือดจากทางทวด',
                            style: TextStyle(fontSize: 14),
                          ),
                          _buildInfoRow('คือ ', 'เจ้าหมื่นยักษ์ (ทำแทนปิด)',
                              Colors.pink[800]),
                          const SizedBox(height: 10),
                          Row(
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'บ้านติ๊กควายไทย',
                                        style: TextStyle(color: Colors.white),
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.08,
            right: 20,
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.25,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Image.asset(
                'assets/images/banner-5.jpg',
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
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            decoration: TextDecoration.underline,
            decorationColor: color,
            decorationThickness: 2,
          ),
        ),
      ],
    );
  }
}
