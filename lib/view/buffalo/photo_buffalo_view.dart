import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/cache_manager.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class PhotoBuffaloView extends StatefulWidget {
  const PhotoBuffaloView({super.key});

  @override
  State<PhotoBuffaloView> createState() => _PhotoBuffaloViewState();
}

class _PhotoBuffaloViewState extends State<PhotoBuffaloView> {
  @override
  void initState() {
    super.initState();
    final buffalo =
        Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
    print(buffalo?.buffaloImages);
  }

  @override
  Widget build(BuildContext context) {
    final selectedBuffalo = Provider.of<SelectedBuffalo>(context);
    final buffalo = selectedBuffalo.buffalo;

    // แปลงข้อมูล buffaloImages ให้เป็น list ของ URLs
    final List<String> imageUrls =
        buffalo!.buffaloImages.map((image) => image.imagePath).toList();

    // Set numOfShowImages based on the length of imageUrls
    final int numOfShowImages = imageUrls.length >= 12 ? 12 : imageUrls.length;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: StrokeText(
                    text: buffalo.name, // แสดงชื่อของ buffalo
                    textStyle: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 14),
                      color: Colors.black,
                    ),
                    strokeColor: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GalleryImage(
                    numOfShowImages: numOfShowImages,
                    imageUrls:
                        imageUrls, // ใช้ list ของ URLs ที่ได้จาก buffaloImages
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
