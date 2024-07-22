import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:buffalo_thai/view/farm_owner/main_farm_owner.dart';
import 'package:flutter/material.dart';

class RegisterFarmOwner extends StatefulWidget {
  const RegisterFarmOwner({super.key});

  @override
  State<RegisterFarmOwner> createState() => _RegisterFarmOwnerState();
}

class _RegisterFarmOwnerState extends State<RegisterFarmOwner> {
  final List<String> buffaloNames = [
    'Buffalo 1',
    'Buffalo 2',
    'Buffalo 3',
    'Buffalo 4',
    'Buffalo 5',
    'Buffalo 6',
  ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailFarmView(),
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_back)),
                ),
                SizedBox(
                  width: 45,
                ),
                Text(
                  'ลงทะเบียนสมาชิก',
                  style: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 24),
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Container(
                  width: screenWidth / 2,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'คอก/ฟาร์ม',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.yellow,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'จังหวัดฟาร์ม',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.yellow,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                            ),
                            color: Colors.white),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 30,
                            ),
                            Text('เพิ่มรูปภาพ')
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'ชื่อ',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'นามสกุล',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'ชื่อเล่น',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'สถานะ',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'เบอร์โทร',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Line ID',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'ลงทะเบียน',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
