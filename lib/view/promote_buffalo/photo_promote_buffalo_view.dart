import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';

class PromotePhotoBuffaloView extends StatefulWidget {
  const PromotePhotoBuffaloView({super.key});

  @override
  State<PromotePhotoBuffaloView> createState() =>
      _PromotePhotoBuffaloViewState();
}

class _PromotePhotoBuffaloViewState extends State<PromotePhotoBuffaloView> {
  @override
  void initState() {
    super.initState();
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
      backgroundColor: Colors.green[200],
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.7,
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          buffalo.name,
                          style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 26),
                            color: Colors.white,
                          ),
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
