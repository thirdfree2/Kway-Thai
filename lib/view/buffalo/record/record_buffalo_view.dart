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
                    "บันทึก/ข้อมูล \n (Data)",
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
                              title: "การพัฒนาการ \n (Development)",
                              height: screenHeight * 0.3,
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
                              title: "การผสมพันธุ์ \n (Breeding)",
                              height: screenHeight * 0.3,
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
                        title: "การฉีดวัคซีน \n (Vaccine)",
                        height: screenHeight * 0.3,
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

class RecordCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;

  const RecordCard({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 200, // ค่า default ถ้าไม่ส่งมา
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
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
    );
  }
}
