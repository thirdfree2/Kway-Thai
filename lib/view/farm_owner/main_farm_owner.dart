import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

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

    final lastName = selectFarmOwener.lastName;
    final position = selectFarmOwener.position;
    final phone = selectFarmOwener.phone;
    final lineId = selectFarmOwener.lineId;
    final farmName = selectedFarm.farmNames;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: StrokeText(
                  text: farmName,
                  textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 26),
                    color: Colors.red,
                  ),
                  strokeColor: Colors.white,
                  strokeWidth: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15) // Adjust the radius as needed
                              ),
                          child: Image.asset(
                            'assets/images/banner-1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StrokeText(
                          text: farmerName,
                          textStyle: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 22),
                            color: Colors.black,
                          ),
                          strokeColor: Colors.white,
                          strokeWidth: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StrokeText(
                          text: 'ตำแหน่ง : $position',
                          textStyle: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 22),
                            color: Colors.black,
                          ),
                          strokeColor: Colors.white,
                          strokeWidth: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StrokeText(
                          text: 'ชื่อ : $farmerName $lastName',
                          textStyle: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                            color: Colors.black,
                          ),
                          strokeColor: Colors.white,
                          strokeWidth: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StrokeText(
                          text: 'เบอร์โทร : $phone',
                          textStyle: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                            color: Colors.black,
                          ),
                          strokeColor: Colors.white,
                          strokeWidth: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StrokeText(
                          text: 'ID line : $lineId',
                          textStyle: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                            color: Colors.black,
                          ),
                          strokeColor: Colors.white,
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 100,
                child: GestureDetector(
                  child: Center(
                      child: Text(
                    'ย้อนกลับ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtils.calculateFontSize(context, 18)),
                  )),
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
