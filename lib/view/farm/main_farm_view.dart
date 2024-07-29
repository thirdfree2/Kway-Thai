import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:buffalo_thai/model/farm_model.dart';
import 'package:buffalo_thai/services/farm_services.dart';
import 'package:buffalo_thai/view/farm/components/card_farm.dart';
import 'package:provider/provider.dart';
import 'package:buffalo_thai/providers/selected_region.dart';
import 'package:buffalo_thai/view/farm/list_farm_view.dart';
import 'package:stroke_text/stroke_text.dart';

class FarmView extends StatefulWidget {
  const FarmView({super.key});

  @override
  State<FarmView> createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  late Future<List<FarmModel>> futureFarmsNorth;
  late Future<List<FarmModel>> futureFarmsNortheast;
  late Future<List<FarmModel>> futureFarmsCentral;
  late Future<List<FarmModel>> futureFarmsSouth;
  late Future<List<FarmModel>> futureFarmsWest;
  late Future<List<FarmModel>> futureFarmsEast;

  @override
  void initState() {
    super.initState();
    futureFarmsNorth = fetchFarmsNorth();
    futureFarmsNortheast = fetchFarmsNortheast();
    futureFarmsCentral = fetchFarmsCentral();
    futureFarmsSouth = fetchFarmsSouth();
    futureFarmsWest = fetchFarmsWest();
    futureFarmsEast = fetchFarmsEast();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: SizedBox(
                        width: screenWidth * 0.4,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'ค้นหา',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<List<FarmModel>>>(
                  future: Future.wait([
                    futureFarmsNorth,
                    futureFarmsNortheast,
                    futureFarmsCentral,
                    futureFarmsSouth,
                    futureFarmsWest,
                    futureFarmsEast
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.every((list) => list.isEmpty)) {
                      return Center(child: Text('No farms available'));
                    } else {
                      final farmsNorth = snapshot.data![0];
                      final farmsNortheast = snapshot.data![1];
                      final farmsCentral = snapshot.data![2];
                      final farmsSouth = snapshot.data![3];
                      final farmsWest = snapshot.data![4];
                      final farmsEast = snapshot.data![5];

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FarmCard(
                                  region: 'ภาคเหนือ',
                                  farms: farmsNorth.map((farm) => '${farm.farmName}').toList(),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onMorePressed: () {
                                    Provider.of<SelectedRegion>(context, listen: false)
                                        .setSelectedRegion('ภาคเหนือ', farmsNorth);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListFarmView(),
                                      ),
                                    );
                                  },
                                ),
                                FarmCard(
                                  region: 'ภาคอีสาน',
                                  farms: farmsNortheast.map((farm) => '${farm.farmName}').toList(),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onMorePressed: () {
                                    Provider.of<SelectedRegion>(context, listen: false)
                                        .setSelectedRegion('ภาคอีสาน', farmsNortheast);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListFarmView(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FarmCard(
                                  region: 'ภาคกลาง',
                                  farms: farmsCentral.map((farm) => '${farm.farmName}').toList(),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onMorePressed: () {
                                    Provider.of<SelectedRegion>(context, listen: false)
                                        .setSelectedRegion('ภาคกลาง', farmsCentral);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListFarmView(),
                                      ),
                                    );
                                  },
                                ),
                                FarmCard(
                                  region: 'ภาคใต้',
                                  farms: farmsSouth.map((farm) => '${farm.farmName}').toList(),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onMorePressed: () {
                                    Provider.of<SelectedRegion>(context, listen: false)
                                        .setSelectedRegion('ภาคใต้', farmsSouth);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListFarmView(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FarmCard(
                                  region: 'ภาคตะวันตก',
                                  farms: farmsWest.map((farm) => '${farm.farmName}').toList(),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onMorePressed: () {
                                    Provider.of<SelectedRegion>(context, listen: false)
                                        .setSelectedRegion('ภาคตะวันตก', farmsWest);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListFarmView(),
                                      ),
                                    );
                                  },
                                ),
                                FarmCard(
                                  region: 'ภาคตะวันออก',
                                  farms: farmsEast.map((farm) => '${farm.farmName}').toList(),
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onMorePressed: () {
                                    Provider.of<SelectedRegion>(context, listen: false)
                                        .setSelectedRegion('ภาคตะวันออก', farmsEast);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListFarmView(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
