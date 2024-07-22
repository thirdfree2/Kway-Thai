import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';

class RegisterBuffalo extends StatefulWidget {
  const RegisterBuffalo({super.key});

  @override
  State<RegisterBuffalo> createState() => _RegisterBuffaloState();
}

class _RegisterBuffaloState extends State<RegisterBuffalo> {
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
                const SizedBox(
                  width: 45,
                ),
                Text(
                  'ลงทะเบียนควาย',
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
                            height: 30,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                            height: 30,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                            height: 30,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'วันเกิด',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 30,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: ScreenUtils.calculateFontSize(context, 8)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.yellow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'เกิดที่ (คอกฟาร์ม)',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 30,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: ScreenUtils.calculateFontSize(context, 8)),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'วิธีการผสมพันธุ์',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 230,
                      height: 30,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 8)),
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
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'รูปถ่ายการผสมพันธุ์',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 8)),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'พ่อพันธุ์ชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'พ่อพันธุ์ชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ปู่ชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ตาชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ย่าชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ยายชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ปู่ทวดชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ตาทวดชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ย่ายทวดชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ยายทวดชื่อ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.calculateFontSize(context, 8)),
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'สังกัดปัจจุบัน',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 250,
                  height: 30,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: ScreenUtils.calculateFontSize(context, 8)),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
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
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 60,
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
              ],
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
