import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/upload_video_buffalo.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class PromoteVideoBuffaloView extends StatefulWidget {
  const PromoteVideoBuffaloView({super.key});

  @override
  State<PromoteVideoBuffaloView> createState() => _PromoteVideoBuffaloViewState();
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
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
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
            StrokeText(
              text: buffalo?.name ?? '',
              textStyle: TextStyle(
                  fontSize: ScreenUtils.calculateFontSize(context, 26),
                  color: Colors.red),
              strokeColor: Colors.white,
              strokeWidth: 6,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // แสดง 3 รายการต่อแถว
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      1.4, // ปรับตามต้องการเพื่อให้ได้ขนาดที่เหมาะสม
                ),
                itemCount: buffalo?.buffaloClips.length ?? 0, // จำนวนไอเท็มในลิสต์
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    height: 85,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15), // ปรับ radius ตามต้องการ
                    ),
                    child: Image.network(
                       buffalo?.buffaloClips[index].imageUrl ?? '', // เปลี่ยนเป็น items[index] ถ้ามีหลายภาพ
                      fit: BoxFit.cover,  
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
