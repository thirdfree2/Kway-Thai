import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/upload_video_buffalo.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoteVideoBuffaloView extends StatefulWidget {
  const PromoteVideoBuffaloView({super.key});

  @override
  State<PromoteVideoBuffaloView> createState() =>
      _PromoteVideoBuffaloViewState();
}

class _PromoteVideoBuffaloViewState extends State<PromoteVideoBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final buffalo = Provider.of<SelectedBuffalo>(context).buffalo;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  )
                ],
              ),
              StrokeText(
                text: buffalo?.name ?? '',
                textStyle: TextStyle(
                  fontSize: ScreenUtils.calculateFontSize(context, 26),
                  color: Colors.red,
                ),
                strokeColor: Colors.white,
                strokeWidth: 6,
              ),
              const SizedBox(height: 30),

              // ตรวจสอบว่ามีคลิปหรือไม่
              if (buffalo?.buffaloClips.isEmpty ?? true)
                const Expanded(
                  child: Center(
                    child: Text(
                      'ไม่พบคลิปวิดีโอของควายตัวนี้',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              else
                // แสดง GridView เมื่อมีคลิปวิดีโอ
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // แสดง 3 รายการต่อแถว
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          1.4, // ปรับตามต้องการเพื่อให้ได้ขนาดที่เหมาะสม
                    ),
                    itemCount:
                        buffalo?.buffaloClips.length ?? 0, // จำนวนไอเท็มในลิสต์
                    itemBuilder: (context, index) {
                      final imageUrl =
                          buffalo?.buffaloClips[index].imageUrl ?? '';

                      // ตรวจสอบว่ามีรูปภาพหรือไม่ ถ้าไม่มีให้แสดงข้อความแทนรูปภาพ
                      return InkWell(
                        onTap: () async {
                          final url = buffalo?.buffaloClips[index].url;
                          if (url != null &&
                              await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            // แสดงข้อความแจ้งเตือนเมื่อไม่สามารถเปิด URL ได้
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('ไม่สามารถเปิดลิงก์ได้')),
                            );
                          }
                        },
                        child: Container(
                          width: 120,
                          height: 85,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15), // ปรับ radius ตามต้องการ
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ), // เพิ่ม border เพื่อเน้นกรอบของภาพหรือข้อความ
                          ),
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl, // แสดงรูปภาพจาก URL
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Text(
                                        'ไม่สามารถแสดงรูปได้',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text(
                                    'ไม่มีรูปภาพ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ), // แสดงข้อความ 'ไม่มีรูปภาพ' ถ้าไม่มี URL ของภาพ
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
