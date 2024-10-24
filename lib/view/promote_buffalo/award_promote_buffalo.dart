import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/register_award/main_register_award.dart';

class MainPromoteAwardsView extends StatefulWidget {
  const MainPromoteAwardsView({super.key});

  @override
  State<MainPromoteAwardsView> createState() => _MainPromoteAwardsViewState();
}

class _MainPromoteAwardsViewState extends State<MainPromoteAwardsView> {
  @override
  Widget build(BuildContext context) {
    final buffalo = Provider.of<SelectedBuffalo>(context).buffalo;
    final competitions = buffalo?.competitions ?? [];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green[200],
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              opacity: 0.7,
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: SizedBox(
            height: screenHeight,
            child: Column(
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
                Card(
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      Text(
                        "รางวัลงานประกวด",
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 26),
                            color: Colors.black),
                      ),

                      const SizedBox(height: 20),
                      // การแสดงชื่อควาย
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            buffalo?.name ?? "ชื่อควาย",
                            style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 24),
                                color: Colors.red),
                          ),
                          Column(
                            children: [
                              Text(
                                '${buffalo?.competitions.length ?? 0}',
                                style: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 28),
                                    color: Colors.black),
                              ),
                              Text(
                                '(รางวัล)',
                                style: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 20),
                                    color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      // แสดงข้อมูลการแข่งขันทั้งหมด
                      ...competitions.asMap().entries.map((entry) {
                        int index = entry.key; // ดึง index ของรายการ
                        var competition = entry.value; // ดึงค่าของการแข่งขัน
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  "(${index + 1})${competition.rank}: ${competition.name}, ${competition.province}, ${DateFormat('dd/MM/yyyy').format(competition.date!)}",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 18),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // แสดงรูปภาพเมื่อคลิก
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: screenWidth,
                                              height: screenHeight * 0.5,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15) // Adjust the radius as needed
                                                  ),
                                              child: Image.network(
                                                competition.imageBuffalo ?? '',
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("ปิด"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red[600],
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 50,
                                  height: 50,
                                  child: const Icon(Icons.camera_alt),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
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
