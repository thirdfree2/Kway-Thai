import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/record/breeding/breeding_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/record/develop/tracking_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/record/vaccine/vaccine_buffalo_view.dart';
import 'package:flutter/material.dart';

class RecordBuffaloView extends StatefulWidget {
  const RecordBuffaloView({super.key});

  @override
  State<RecordBuffaloView> createState() => _RecordBuffaloViewState();
}

class _RecordBuffaloViewState extends State<RecordBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.8,
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: screenHeight,
            child: ListView(
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
                Center(
                  child: Text(
                    "ข้อมูล \n (Information)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 24),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // แถวที่ 1
                      Row(
                        children: [
                          Expanded(
                            child: RecordCard(
                              title: "พัฒนาการ \n (Development)",
                              height: screenHeight * 0.3,
                              imageAssetPath: 'assets/images/develop.png',
                              imagePosition:
                                  ImagePosition.bottomLeft, // หรือ bottomLeft
                              imageOpacity: 1,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TrackingBuffaloView(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RecordCard(
                              title: "ผสมพันธุ์ \n (Breeding)",
                              height: screenHeight * 0.3,
                              imageAssetPath: 'assets/images/breeding.png',
                              imagePosition:
                                  ImagePosition.topRight, // หรือ bottomLeft
                              imageOpacity: 1,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BreedingBuffaloView(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      RecordCard(
                        title: "ฉีดวัคซีน \n (Vaccine)",
                        height: screenHeight * 0.3,
                        imageAssetPath: 'assets/images/vaccine.png',
                        imagePosition:
                            ImagePosition.topRight, // หรือ bottomLeft
                        imageOpacity: 1,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VaccineBuffaloView(),
                            ),
                          );
                        },
                      ),
                    ],
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

enum ImagePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;

  bool get isTop => this == topLeft || this == topRight;
  bool get isBottom => this == bottomLeft || this == bottomRight;
  bool get isLeft => this == topLeft || this == bottomLeft;
  bool get isRight => this == topRight || this == bottomRight;
}

class RecordCard extends StatelessWidget {
  const RecordCard({
    super.key,
    required this.title,
    required this.onTap,
    this.imageAssetPath,
    this.imagePosition = ImagePosition.topRight,
    this.imageOpacity = 0.2,
    this.height = 200, // ค่า default ถ้าไม่ส่งมา
  });
  final String title;
  final VoidCallback onTap;
  final double height;

  final String? imageAssetPath;
  final ImagePosition imagePosition;
  final double imageOpacity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          if (imageAssetPath != null)
            Positioned(
              top: imagePosition.isTop ? 0 : null,
              bottom: imagePosition.isBottom ? 0 : null,
              left: imagePosition.isLeft ? 0 : null,
              right: imagePosition.isRight ? 0 : null,
              child: Opacity(
                opacity: imageOpacity,
                child: Image.asset(
                  imageAssetPath!,
                  width: 150,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.6 * 255).round()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
