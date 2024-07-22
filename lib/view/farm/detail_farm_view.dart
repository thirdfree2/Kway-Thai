import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_view.dart';
import 'package:buffalo_thai/view/farm_owner/main_farm_owner.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class DetailFarmView extends StatefulWidget {
  const DetailFarmView({super.key});

  @override
  State<DetailFarmView> createState() => _DetailFarmViewState();
}

class _DetailFarmViewState extends State<DetailFarmView> {
  @override
  Widget build(BuildContext context) {
    final selectedFarm = Provider.of<SelectedFarm>(context);
    final region = selectedFarm.region;
    final farmNames = selectedFarm.farmNames;
    final List<String> buffaloNames = [
      'Buffalo 1',
      'Buffalo 2',
      'Buffalo 3',
      'Buffalo 4',
      'Buffalo 5',
      'Buffalo 6',
    ];

    final List<String> farmerNames = [
      'John Doe 1',
      'John Doe 2',
      'John Doe 3',
      'John Doe 4',
      'John Doe 5',
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            StrokeText(
              text: farmNames,
              textStyle: TextStyle(
                fontSize: ScreenUtils.calculateFontSize(context, 20),
                color: Colors.red,
              ),
              strokeColor: Colors.white,
              strokeWidth: 6,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StrokeText(
                    text: 'สมาชิก (${farmerNames.length})',
                    textStyle: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 14),
                      color: Colors.white,
                    ),
                    strokeColor: Colors.black,
                    strokeWidth: 3,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterFarmOwner(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'เพิ่มโปรไฟล์',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: farmerNames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<SelectedBuffalo>(context, listen: false)
                            .setSelectedBuffalo(farmerNames[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainFarmOwner(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                'assets/images/banner-1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          StrokeText(
                            text: farmerNames[index],
                            textStyle: TextStyle(
                              fontSize: ScreenUtils.calculateFontSize(context, 12),
                              color: Colors.white,
                            ),
                            strokeColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StrokeText(
                    text: 'ควาย (${buffaloNames.length})',
                    textStyle: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 14),
                      color: Colors.white,
                    ),
                    strokeColor: Colors.black,
                    strokeWidth: 3,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterBuffalo(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'เพิ่มควาย',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: buffaloNames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<SelectedBuffalo>(context, listen: false)
                            .setSelectedBuffalo(buffaloNames[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainBuffaloView(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                'assets/images/banner-1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          StrokeText(
                            text: buffaloNames[index],
                            textStyle: TextStyle(
                              fontSize: ScreenUtils.calculateFontSize(context, 12),
                              color: Colors.white,
                            ),
                            strokeColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
