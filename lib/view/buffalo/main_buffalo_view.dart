import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBuffaloView extends StatefulWidget {
  const MainBuffaloView({super.key});

  @override
  State<MainBuffaloView> createState() => _MainBuffaloViewState();
}

class _MainBuffaloViewState extends State<MainBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final selectedBuffalo = Provider.of<SelectedBuffalo>(context);
    final buffaloNames = selectedBuffalo.buffalo;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth / 3),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'ประวัติ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(child: Text(buffaloNames,)),
                    SizedBox(height: 10),
                    Text(
                      'ควายไทย เพศ ผู้ สี ดำ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('เกิด 16 มกราคม 2562'),
                    Text('เกิดที่ ลอก/ฟาร์ม บ้านคึกควายไทย'),
                    Text('โดยวิธีการ ผสมจริง'),
                    Text(
                        'ระหว่าง พ่อพันธุ์ ป๋ามัญจูถิ่น กับ แม่พันธุ์ แม่บุญมาก'),
                    Text('สายเลือดทางพ่อคือ เจ้าบาคาล'),
                    Text('nสายเลือดทางแม่คือ ความสายอยู่ถิ่น'),
                    Text('สายเลือดทางพ่อคือ เจ้าฟาแอ (ทำแทนปิด)'),
                    Text('สายเลือดทางยายคือ แม่บุญสูง'),
                    Text('สืบสายเลือดจากทางทวดคือ เจ้าหมื่นยักษ์ (ทำแทนปิด)'),
                    Text(
                      'สังกัดปัจจุบัน\nเหนือสวนฟาร์มควายไทย',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
