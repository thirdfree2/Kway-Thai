import 'package:buffalo_thai/model/farm_model.dart';
import 'package:buffalo_thai/providers/selected_region.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/list_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class FarmView extends StatefulWidget {
  const FarmView({super.key});

  @override
  State<FarmView> createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Farm> farmSouth = [
      Farm(id: 1, farmId: "001", farmName: "เหนือสยามฟาร์มควายไทย"),
      Farm(id: 2, farmId: "002", farmName: "วนอาสุวรรณฟาร์ม"),
      Farm(id: 3, farmId: "003", farmName: "กกเลฟาร์มควายไทย"),
    ];

    final List<String> farmsNorth = [
      '001 เหนือสยามฟาร์มควายไทย',
      '002 วนอาสุวรรณฟาร์ม',
      '003 กกเลฟาร์มควายไทย',
    ];

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
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
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
                          color: Colors.red),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: SizedBox(
                                width: screenWidth / 2.4,
                                height: screenHeight * 0.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'ภาคเหนือ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: farmsNorth.length - 2,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(farmsNorth[index]),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedRegion>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedRegion(
                                                      'ภาคเหนือ', farmsNorth);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListFarmView(),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่มเติม >>>')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: SizedBox(
                                width: screenWidth / 2.4,
                                height: screenHeight * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'ภาคเหนือ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeight * 0.05,
                                      child: ListView.builder(
                                        itemCount: farmsNorth.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(farmsNorth[index]),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedRegion>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedRegion(
                                                      'ภาคเหนือ', farmsNorth);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListFarmView(),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่มเติม >>>')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: SizedBox(
                                width: screenWidth / 2.4,
                                height: screenHeight * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'ภาคเหนือ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeight * 0.05,
                                      child: ListView.builder(
                                        itemCount: farmsNorth.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(farmsNorth[index]),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedRegion>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedRegion(
                                                      'ภาคเหนือ', farmsNorth);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListFarmView(),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่มเติม >>>')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: SizedBox(
                                width: screenWidth / 2.4,
                                height: screenHeight * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'ภาคเหนือ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeight * 0.2,
                                      child: ListView.builder(
                                        itemCount: farmsNorth.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(farmsNorth[index]),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedRegion>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedRegion(
                                                      'ภาคเหนือ', farmsNorth);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListFarmView(),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่มเติม >>>')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: SizedBox(
                                width: screenWidth / 2.4,
                                height: screenHeight * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'ภาคเหนือ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeight * 0.05,
                                      child: ListView.builder(
                                        itemCount: farmsNorth.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(farmsNorth[index]),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedRegion>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedRegion(
                                                      'ภาคเหนือ', farmsNorth);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListFarmView(),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่มเติม >>>')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white.withOpacity(0.8),
                              child: SizedBox(
                                width: screenWidth / 2.4,
                                height: screenHeight * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                          child: Text(
                                            'ภาคเหนือ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Container(
                                        height: screenHeight * 0.05,
                                        child: ListView.builder(
                                          itemCount: farmSouth.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      farmSouth[index].farmId,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child: FittedBox(
                                                            child: Text(
                                                      farmSouth[index].farmName,
                                                    ))),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedRegion>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedRegion(
                                                      'ภาคเหนือ', farmsNorth);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListFarmView(),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่มเติม >>>')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
