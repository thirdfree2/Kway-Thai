import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:buffalo_thai/view/farm_owner/edit_farm_owner.dart';
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

    final imgUrl = selectFarmOwener.urlImg;
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
              const SizedBox(
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
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(children: [
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
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                            ),
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
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StrokeText(
                                  text: farmerName,
                                  textStyle: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 22),
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
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 22),
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
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 18),
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
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 18),
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
                                    fontSize: ScreenUtils.calculateFontSize(
                                        context, 18),
                                    color: Colors.black,
                                  ),
                                  strokeColor: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ],
                            ),
                          ]),
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
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 100,
                      child: GestureDetector(
                        child: Center(
                            child: Text(
                          'ย้อนกลับ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 18)),
                        )),
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
    );
  }
}
