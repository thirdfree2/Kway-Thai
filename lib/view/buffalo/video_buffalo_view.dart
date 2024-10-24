import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/upload_video_buffalo.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoBuffaloView extends StatefulWidget {
  const VideoBuffaloView({super.key});

  @override
  State<VideoBuffaloView> createState() => _VideoBuffaloViewState();
}

class _VideoBuffaloViewState extends State<VideoBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final buffalo = Provider.of<SelectedBuffalo>(context).buffalo;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              opacity: 0.8,
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Text(
                buffalo?.name ?? '',
                style: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 26),
                    color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
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
                      return InkWell(
                        onTap: () async {
                          final url = buffalo?.buffaloClips[index].url;
                          print(url);
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
                          ),
                          child: Image.network(
                            buffalo?.buffaloClips[index].imageUrl ??
                                '', // เปลี่ยนเป็น items[index] ถ้ามีหลายภาพ
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadVideoBuffalo(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'เพิ่มวิดีโอ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
    );
  }
}
