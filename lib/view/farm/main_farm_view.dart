import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
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

  List<FarmModel> filteredFarmsNorth = [];
  List<FarmModel> filteredFarmsNortheast = [];
  List<FarmModel> filteredFarmsCentral = [];
  List<FarmModel> filteredFarmsSouth = [];
  List<FarmModel> filteredFarmsWest = [];
  List<FarmModel> filteredFarmsEast = [];

  final TextEditingController _searchController = TextEditingController();
  bool search = false;

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

  void _filterFarms(
      List<FarmModel> farmsNorth,
      List<FarmModel> farmsNortheast,
      List<FarmModel> farmsCentral,
      List<FarmModel> farmsSouth,
      List<FarmModel> farmsWest,
      List<FarmModel> farmsEast) {
    final searchText = _searchController.text.toLowerCase();
    setState(() {
      search = true; // ตั้งค่า search เป็น true เมื่อทำการค้นหา
      filteredFarmsNorth = farmsNorth
          .where((farm) => farm.farmName.toLowerCase().contains(searchText))
          .toList();
      filteredFarmsNortheast = farmsNortheast
          .where((farm) => farm.farmName.toLowerCase().contains(searchText))
          .toList();
      filteredFarmsCentral = farmsCentral
          .where((farm) => farm.farmName.toLowerCase().contains(searchText))
          .toList();
      filteredFarmsSouth = farmsSouth
          .where((farm) => farm.farmName.toLowerCase().contains(searchText))
          .toList();
      filteredFarmsWest = farmsWest
          .where((farm) => farm.farmName.toLowerCase().contains(searchText))
          .toList();
      filteredFarmsEast = farmsEast
          .where((farm) => farm.farmName.toLowerCase().contains(searchText))
          .toList();
    });
  }

  void _clearSearch() {
    setState(() {
      search = false; // ตั้งค่า search กลับไปเป็น false
      _searchController.clear(); // ล้างค่าการค้นหาในช่องค้นหา
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
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
                      Text(
                        'คอก/ฟาร์ม',
                        style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 28),
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: SizedBox(
                          width: screenWidth * 0.4,
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  _filterFarms(
                                    filteredFarmsNorth,
                                    filteredFarmsNortheast,
                                    filteredFarmsCentral,
                                    filteredFarmsSouth,
                                    filteredFarmsWest,
                                    filteredFarmsEast,
                                  );
                                },
                              ),
                              suffixIcon: search
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: _clearSearch,
                                    )
                                  : null,
                              hintText: 'ค้นหา',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onFieldSubmitted: (_) {
                              _filterFarms(
                                filteredFarmsNorth,
                                filteredFarmsNortheast,
                                filteredFarmsCentral,
                                filteredFarmsSouth,
                                filteredFarmsWest,
                                filteredFarmsEast,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // UI ที่จะเปลี่ยนตามสถานะการค้นหา
                if (search) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: screenHeight - viewInsets - 350,
                        child: Card(
                          color: Colors.white.withOpacity(0.8),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "ผลลัพธ์การค้นหา",
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 18),
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: filteredFarmsNorth.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: SizedBox(
                                        height: 80,
                                        child: InkWell(
                                          onTap: () {
                                            Provider.of<SelectedFarm>(context,
                                                    listen: false)
                                                .setSelectedFarm(
                                              '',
                                              filteredFarmsNorth[index]
                                                  .farmName,
                                              filteredFarmsNorth[index]
                                                  .farmId
                                                  .toString(),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Text(
                                                    '00${index + 1} ${filteredFarmsNorth[index].farmName}'),
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
                  )
                ] else ...[
                  // กรณีที่ยังไม่มีการค้นหา ให้แสดง UI ปกติ
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.every((list) => list.isEmpty)) {
                          return const Center(
                              child: Text('No farms available'));
                        } else {
                          filteredFarmsNorth = snapshot.data![0];
                          filteredFarmsNortheast = snapshot.data![1];
                          filteredFarmsCentral = snapshot.data![2];
                          filteredFarmsSouth = snapshot.data![3];
                          filteredFarmsWest = snapshot.data![4];
                          filteredFarmsEast = snapshot.data![5];

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FarmCard(
                                      region:
                                          'ภาคเหนือ (${filteredFarmsNorth.length})',
                                      farms: filteredFarmsNorth
                                          .map((farm) => farm.farmName)
                                          .toList(),
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      onMorePressed: () {
                                        Provider.of<SelectedRegion>(context,
                                                listen: false)
                                            .setSelectedRegion(
                                                'ภาคเหนือ', filteredFarmsNorth);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListFarmView(),
                                          ),
                                        );
                                      },
                                    ),
                                    FarmCard(
                                      region:
                                          'ภาคอีสาน (${filteredFarmsNortheast.length})',
                                      farms: filteredFarmsNortheast
                                          .map((farm) => farm.farmName)
                                          .toList(),
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      onMorePressed: () {
                                        Provider.of<SelectedRegion>(context,
                                                listen: false)
                                            .setSelectedRegion('ภาคอีสาน',
                                                filteredFarmsNortheast);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListFarmView(),
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
                                      region:
                                          'ภาคกลาง (${filteredFarmsCentral.length})',
                                      farms: filteredFarmsCentral
                                          .map((farm) => farm.farmName)
                                          .toList(),
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      onMorePressed: () {
                                        Provider.of<SelectedRegion>(context,
                                                listen: false)
                                            .setSelectedRegion('ภาคกลาง',
                                                filteredFarmsCentral);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListFarmView(),
                                          ),
                                        );
                                      },
                                    ),
                                    FarmCard(
                                      region:
                                          'ภาคใต้ (${filteredFarmsSouth.length})',
                                      farms: filteredFarmsSouth
                                          .map((farm) => farm.farmName)
                                          .toList(),
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      onMorePressed: () {
                                        Provider.of<SelectedRegion>(context,
                                                listen: false)
                                            .setSelectedRegion(
                                                'ภาคใต้', filteredFarmsSouth);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListFarmView(),
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
                                      region:
                                          'ภาคตะวันตก (${filteredFarmsWest.length})',
                                      farms: filteredFarmsWest
                                          .map((farm) => farm.farmName)
                                          .toList(),
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      onMorePressed: () {
                                        Provider.of<SelectedRegion>(context,
                                                listen: false)
                                            .setSelectedRegion('ภาคตะวันตก',
                                                filteredFarmsWest);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListFarmView(),
                                          ),
                                        );
                                      },
                                    ),
                                    FarmCard(
                                      region:
                                          'ภาคตะวันออก (${filteredFarmsEast.length})',
                                      farms: filteredFarmsEast
                                          .map((farm) => farm.farmName)
                                          .toList(),
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      onMorePressed: () {
                                        Provider.of<SelectedRegion>(context,
                                                listen: false)
                                            .setSelectedRegion('ภาคตะวันออก',
                                                filteredFarmsEast);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListFarmView(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}


                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     FarmCard(
                            //       region:
                            //           'ภาคเหนือ (${filteredFarmsNorth.length})',
                            //       farms: filteredFarmsNorth
                            //           .map((farm) => farm.farmName)
                            //           .toList(),
                            //       screenWidth: screenWidth,
                            //       screenHeight: screenHeight,
                            //       onMorePressed: () {
                            //         Provider.of<SelectedRegion>(context,
                            //                 listen: false)
                            //             .setSelectedRegion(
                            //                 'ภาคเหนือ', filteredFarmsNorth);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => ListFarmView(),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //     FarmCard(
                            //       region:
                            //           'ภาคอีสาน (${filteredFarmsNortheast.length})',
                            //       farms: filteredFarmsNortheast
                            //           .map((farm) => farm.farmName)
                            //           .toList(),
                            //       screenWidth: screenWidth,
                            //       screenHeight: screenHeight,
                            //       onMorePressed: () {
                            //         Provider.of<SelectedRegion>(context,
                            //                 listen: false)
                            //             .setSelectedRegion('ภาคอีสาน',
                            //                 filteredFarmsNortheast);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => ListFarmView(),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     FarmCard(
                            //       region:
                            //           'ภาคกลาง (${filteredFarmsCentral.length})',
                            //       farms: filteredFarmsCentral
                            //           .map((farm) => farm.farmName)
                            //           .toList(),
                            //       screenWidth: screenWidth,
                            //       screenHeight: screenHeight,
                            //       onMorePressed: () {
                            //         Provider.of<SelectedRegion>(context,
                            //                 listen: false)
                            //             .setSelectedRegion(
                            //                 'ภาคกลาง', filteredFarmsCentral);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => ListFarmView(),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //     FarmCard(
                            //       region:
                            //           'ภาคใต้ (${filteredFarmsSouth.length})',
                            //       farms: filteredFarmsSouth
                            //           .map((farm) => farm.farmName)
                            //           .toList(),
                            //       screenWidth: screenWidth,
                            //       screenHeight: screenHeight,
                            //       onMorePressed: () {
                            //         Provider.of<SelectedRegion>(context,
                            //                 listen: false)
                            //             .setSelectedRegion(
                            //                 'ภาคใต้', filteredFarmsSouth);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => ListFarmView(),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     FarmCard(
                            //       region:
                            //           'ภาคตะวันตก (${filteredFarmsWest.length})',
                            //       farms: filteredFarmsWest
                            //           .map((farm) => farm.farmName)
                            //           .toList(),
                            //       screenWidth: screenWidth,
                            //       screenHeight: screenHeight,
                            //       onMorePressed: () {
                            //         Provider.of<SelectedRegion>(context,
                            //                 listen: false)
                            //             .setSelectedRegion(
                            //                 'ภาคตะวันตก', filteredFarmsWest);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => ListFarmView(),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //     FarmCard(
                            //       region:
                            //           'ภาคตะวันออก (${filteredFarmsEast.length})',
                            //       farms: filteredFarmsEast
                            //           .map((farm) => farm.farmName)
                            //           .toList(),
                            //       screenWidth: screenWidth,
                            //       screenHeight: screenHeight,
                            //       onMorePressed: () {
                            //         Provider.of<SelectedRegion>(context,
                            //                 listen: false)
                            //             .setSelectedRegion(
                            //                 'ภาคตะวันออก', filteredFarmsEast);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => ListFarmView(),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
//  Expanded(
//                 child: FutureBuilder<List<List<FarmModel>>>(
//                   future: Future.wait([
//                     futureFarmsNorth,
//                     futureFarmsNortheast,
//                     futureFarmsCentral,
//                     futureFarmsSouth,
//                     futureFarmsWest,
//                     futureFarmsEast
//                   ]),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else if (!snapshot.hasData ||
//                         snapshot.data!.every((list) => list.isEmpty)) {
//                       return const Center(child: Text('No farms available'));
//                     } else {
//                       // กำหนดค่าเริ่มต้นให้ filteredFarms ตามข้อมูลที่ได้จาก FutureBuilder
//                       filteredFarmsNorth = snapshot.data![0];
//                       filteredFarmsNortheast = snapshot.data![1];
//                       filteredFarmsCentral = snapshot.data![2];
//                       filteredFarmsSouth = snapshot.data![3];
//                       filteredFarmsWest = snapshot.data![4];
//                       filteredFarmsEast = snapshot.data![5];

//                       return SingleChildScrollView(


//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 FarmCard(
//                                   region:
//                                       'ภาคเหนือ (${filteredFarmsNorth.length})',
//                                   farms: filteredFarmsNorth
//                                       .map((farm) => farm.farmName)
//                                       .toList(),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   onMorePressed: () {
//                                     Provider.of<SelectedRegion>(context,
//                                             listen: false)
//                                         .setSelectedRegion(
//                                             'ภาคเหนือ', filteredFarmsNorth);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ListFarmView(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 FarmCard(
//                                   region:
//                                       'ภาคอีสาน (${filteredFarmsNortheast.length})',
//                                   farms: filteredFarmsNortheast
//                                       .map((farm) => farm.farmName)
//                                       .toList(),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   onMorePressed: () {
//                                     Provider.of<SelectedRegion>(context,
//                                             listen: false)
//                                         .setSelectedRegion('ภาคอีสาน',
//                                             filteredFarmsNortheast);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ListFarmView(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 FarmCard(
//                                   region:
//                                       'ภาคกลาง (${filteredFarmsCentral.length})',
//                                   farms: filteredFarmsCentral
//                                       .map((farm) => farm.farmName)
//                                       .toList(),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   onMorePressed: () {
//                                     Provider.of<SelectedRegion>(context,
//                                             listen: false)
//                                         .setSelectedRegion(
//                                             'ภาคกลาง', filteredFarmsCentral);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ListFarmView(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 FarmCard(
//                                   region:
//                                       'ภาคใต้ (${filteredFarmsSouth.length})',
//                                   farms: filteredFarmsSouth
//                                       .map((farm) => farm.farmName)
//                                       .toList(),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   onMorePressed: () {
//                                     Provider.of<SelectedRegion>(context,
//                                             listen: false)
//                                         .setSelectedRegion(
//                                             'ภาคใต้', filteredFarmsSouth);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ListFarmView(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 FarmCard(
//                                   region:
//                                       'ภาคตะวันตก (${filteredFarmsWest.length})',
//                                   farms: filteredFarmsWest
//                                       .map((farm) => farm.farmName)
//                                       .toList(),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   onMorePressed: () {
//                                     Provider.of<SelectedRegion>(context,
//                                             listen: false)
//                                         .setSelectedRegion(
//                                             'ภาคตะวันตก', filteredFarmsWest);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ListFarmView(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 FarmCard(
//                                   region:
//                                       'ภาคตะวันออก (${filteredFarmsEast.length})',
//                                   farms: filteredFarmsEast
//                                       .map((farm) => farm.farmName)
//                                       .toList(),
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   onMorePressed: () {
//                                     Provider.of<SelectedRegion>(context,
//                                             listen: false)
//                                         .setSelectedRegion(
//                                             'ภาคตะวันออก', filteredFarmsEast);
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ListFarmView(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),