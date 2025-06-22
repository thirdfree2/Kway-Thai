import 'package:buffalo_thai/components/label_member_text.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/edit_farm_owner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainFarmOwner extends StatefulWidget {
  const MainFarmOwner({super.key});

  @override
  State<MainFarmOwner> createState() => _MainFarmOwnerState();
}

class _MainFarmOwnerState extends State<MainFarmOwner> {
  @override
  Widget build(BuildContext context) {
    final selectedFarm = Provider.of<SelectedFarm>(context);
    final selectFarmOwener = Provider.of<SelectedFarmOwner>(context);
    final farmerName = selectFarmOwener.farmOwner;

    final nickname = selectFarmOwener.nickname;
    final imgUrl = selectFarmOwener.urlImg;
    final lastName = selectFarmOwener.lastName;
    final position = selectFarmOwener.position;
    final phone = selectFarmOwener.phone;
    final lineId = selectFarmOwener.lineId;
    final farmName = selectedFarm.farmNames;
    final assoCard = selectFarmOwener.assoCard;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.8,
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    farmName,
                    style: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 26),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white.withAlpha((0.6 * 255).round()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EditFarmOwnerScreen(), // Corrected syntax here
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ), // Adjust the radius as needed
                                          ),
                                          child: Image.network(
                                            imgUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (assoCard != '')
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Center(
                                                      child: Text(
                                                        'บัตรสมาชิกสมาคม \n(Member Card)',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.network(
                                                          assoCard, // ✅ แสดงรูปบัตรจาก URL
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                          context,
                                                        ).pop(),
                                                        child: const Text(
                                                          'ปิด (Close)',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.red.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    'บัตรสมาชิกสมาคม \n(Member Card)',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        // Container(
                                        //   width: 120,
                                        //   height: 120,
                                        //   clipBehavior: Clip.antiAlias,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(
                                        //       15,
                                        //     ), // Adjust the radius as needed
                                        //   ),
                                        //   child: Image.network(
                                        //     assoCard,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (nickname != '')
                                      LabeledTextRow(
                                        labelTh: 'ชื่อเล่น',
                                        labelEn: 'Nickname',
                                        value: nickname,
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (lastName != '')
                                      LabeledTextRow(
                                        labelTh: 'นามสกุล',
                                        labelEn: 'Lastname',
                                        value: lastName,
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (position != '')
                                      LabeledTextRow(
                                        labelTh: 'ตำแหน่ง',
                                        labelEn: 'Position',
                                        value: position,
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (farmerName != '')
                                      LabeledTextRow(
                                        labelTh: 'ชื่อ',
                                        labelEn: 'Name',
                                        value: '$farmerName $lastName',
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (phone != '')
                                      LabeledTextRow(
                                        labelTh: 'เบอร์โทร',
                                        labelEn: 'Phone',
                                        value: phone,
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (lineId != '')
                                      LabeledTextRow(
                                        labelTh: 'ไลน์',
                                        labelEn: 'ID line',
                                        value: lineId,
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 80,
                        width: 100,
                        child: GestureDetector(
                          child: Center(
                            child: Text(
                              'ย้อนกลับ \n(Back)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 18),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          },
                        ),
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
