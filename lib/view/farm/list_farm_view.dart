import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_region.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFarmView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedFarm = Provider.of<SelectedRegion>(context);
    final region = selectedFarm.region;
    final farmNames = selectedFarm.farmNames;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'คอก/ฟาร์ม',
                    style: TextStyle(
                        fontSize: ScreenUtils.calculateFontSize(context, 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: SizedBox(
                      width: screenWidth * 0.45,
                      child: const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ค้นหา',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    region,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtils.calculateFontSize(context, 18),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                color: Colors.white.withOpacity(0.8),
                child: SizedBox(
                  height: 300, // Define a specific height for the Card
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: farmNames.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: SizedBox(
                                height: 80,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<SelectedFarm>(context,
                                            listen: false)
                                        .setSelectedFarm(
                                      'ภาคเหนือ',
                                      farmNames[index],
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailFarmView(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                      child: Center(
                                          child: Text(farmNames[index]))),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                              onTap: () {}, child: Text('เพิ่มเติม >>>')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(label: 'ภาคเหนือ', onPressed: () {}),
                CustomButton(label: 'ภาคอีสาน', onPressed: () {}),
                CustomButton(label: 'ภาคตะวันออก', onPressed: () {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(label: 'ภาคตะวันตก', onPressed: () {}),
                CustomButton(label: 'ภาคใต้', onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
