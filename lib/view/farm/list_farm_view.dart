import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/model/farm_model.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/services/farm_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_region.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:stroke_text/stroke_text.dart';

class ListFarmView extends StatefulWidget {
  @override
  State<ListFarmView> createState() => _ListFarmViewState();
}

class _ListFarmViewState extends State<ListFarmView> {
  late Future<List<BuffaloModel>> futureBuffaloes;
  String search = ''; // เพิ่มตัวแปร search

  @override
  void initState() {
    super.initState();
    futureBuffaloes = fetchBuffaloes();
  }

  @override
  Widget build(BuildContext context) {
    final selectedRegion = Provider.of<SelectedRegion>(context);
    final region = selectedRegion.region;
    final farms = selectedRegion.farms;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

double cardHeight = search.isEmpty
    ? screenHeight - viewInsets - 400 // ความสูงเมื่อไม่มีการค้นหา
    : screenHeight - viewInsets - 300; 

    // กรองรายการฟาร์มตามค่าการค้นหา
    final filteredFarms = search.isEmpty
        ? farms
        : farms.where((farm) => farm.farmName.contains(search)).toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StrokeText(
                    text: "คอก/ฟาร์ม",
                    textStyle: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 28),
                      color: Colors.red,
                    ),
                    strokeColor: Colors.white,
                    strokeWidth: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: SizedBox(
                      width: screenWidth * 0.4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'ค้นหา',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            search = value; // เปลี่ยนค่าการค้นหา
                          });
                        },
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
                    'ภาค$region (${filteredFarms.length})',
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
                  height: cardHeight, // Define a specific height for the Card
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredFarms.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: SizedBox(
                                height: 80,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<SelectedFarm>(context,
                                            listen: false)
                                        .setSelectedFarm(
                                      region,
                                      filteredFarms[index].farmName,
                                      filteredFarms[index].farmId.toString(),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailFarmView(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                            '00${index + 1} ${filteredFarms[index].farmName}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (search.isEmpty)
            Column(
              children: [
                if (search.isEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (region != 'เหนือ')
                      Flexible(
                        child: CustomButton(
                          label: 'ภาคเหนือ',
                          onPressed: () {
                            loadRegionData(context, fetchFarmsNorth);
                          },
                        ),
                      ),
                    if (region != 'อีสาน')
                      Flexible(
                        child: CustomButton(
                          label: 'ภาคอีสาน',
                          onPressed: () {
                            loadRegionData(context, fetchFarmsNortheast);
                          },
                        ),
                      ),
                    if (region != 'ตะวันออก')
                      Flexible(
                        child: CustomButton(
                          label: 'ภาคตะวันออก',
                          onPressed: () {
                            loadRegionData(context, fetchFarmsEast);
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (search.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (region != 'ตะวันตก')
                  Flexible(
                    child: CustomButton(
                      label: 'ภาคตะวันตก',
                      onPressed: () {
                        loadRegionData(context, fetchFarmsWest);
                      },
                    ),
                  ),
                if (region != 'ใต้')
                  Flexible(
                    child: CustomButton(
                      label: 'ภาคใต้',
                      onPressed: () {
                        loadRegionData(context, fetchFarmsSouth);
                      },
                    ),
                  ),
                if (region != 'กลาง')
                  Flexible(
                    child: CustomButton(
                      label: 'ภาคกลาง',
                      onPressed: () {
                        loadRegionData(context, fetchFarmsCentral);
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void loadRegionData(BuildContext context,
      Future<List<FarmModel>> Function() fetchFarms) async {
    try {
      List<FarmModel> farms = await fetchFarms();
      Provider.of<SelectedRegion>(context, listen: false)
          .setSelectedRegion(farms.isNotEmpty ? farms.first.region : '', farms);
    } catch (e) {
      print('Failed to load farms: $e');
    }
  }
}


  void loadRegionData(BuildContext context,
      Future<List<FarmModel>> Function() fetchFarms) async {
    try {
      List<FarmModel> farms = await fetchFarms();
      Provider.of<SelectedRegion>(context, listen: false)
          .setSelectedRegion(farms.isNotEmpty ? farms.first.region : '', farms);
    } catch (e) {
      print('Failed to load farms: $e');
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: onPressed,
        child: Center(
          child: AutoSizeText(
            label,
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
