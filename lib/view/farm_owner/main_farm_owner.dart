import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
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
    final selectedBuffalo = Provider.of<SelectedBuffalo>(context);
    final farmerName = selectedBuffalo.buffalo;
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
              Center(
                  child: Text(
                'Farm Name',
                style: TextStyle(
                  fontSize: ScreenUtils.calculateFontSize(context, 26),
                ),
              )),
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
                        Text(
                          farmerName,
                          style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ตำแหน่ง :',
                          style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ชื่อ :',
                          style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'เบอร์โทร :',
                          style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ID line :',
                          style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 20),
                          ),
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
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtils.calculateFontSize(context, 18)),
                  )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailFarmView(),
                      ),
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
