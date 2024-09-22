import 'dart:io';

import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class UploadImageBuffaloView extends StatefulWidget {
  const UploadImageBuffaloView({super.key});

  @override
  State<UploadImageBuffaloView> createState() => _UploadImageBuffaloViewState();
}

class _UploadImageBuffaloViewState extends State<UploadImageBuffaloView> {
  File? _selectedImage;
  String? _selectedStatus;

  String _inputCode = "";

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _showCodeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ใส่รหัส 6 หลัก'),
          content: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _inputCode = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'กรุณาใส่รหัส 6 หลัก',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () async {
                // เช็ครหัส 6 หลัก
                if (_inputCode.length == 6) {
                  Navigator.of(context).pop(); // ปิด Dialog
                  await _uploadImage(context);
                  try {
                    print('hello');
                  } catch (e) {
                    print(e);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('กรุณาใส่รหัสให้ครบ 6 หลัก'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadImage(BuildContext context) async {
    final selectedBuffalo =
        Provider.of<SelectedBuffalo>(context, listen: false);
    final buffalo = selectedBuffalo.buffalo;
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);

    try {
      var msg = await uploadImageBuffalo(
        imageFile: _selectedImage,
        buffaloId: buffalo?.id ?? 0,
        password: _inputCode,
        farmId: selectedFarm.farmId,
      );

      if (msg == "Buffalo image inserted successfully") {
        // แสดง SnackBar ที่สำเร็จ
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('อัปโหลดรูปภาพสำเร็จ'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the farm detail view after success
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DetailFarmView(),
          ),
        );
      } else if (msg == "รหัสผ่านไม่ถูกต้อง") {
        // แสดง SnackBar สำหรับรหัสผิด
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('รหัสผ่านไม่ถูกต้อง'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // แสดง SnackBar สำหรับการอัปโหลดล้มเหลว
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('การอัปโหลดล้มเหลว: รหัสผ่านไม่ถูกต้อง'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFarm = Provider.of<SelectedFarm>(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                StrokeText(
                  text: 'เพิ่มรูปภาพ',
                  textStyle: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 24),
                    color: Colors.white,
                  ),
                  strokeColor: Colors.black,
                  strokeWidth: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: _selectedImage == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 30),
                                  Text('รูปโปรไฟล์')
                                ],
                              )
                            : Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _showCodeDialog(context);

                          // แสดง SnackBar เพื่อทดสอบว่าทำงานหรือไม่
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Test SnackBar'),
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'เพิ่มรูปภาพ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
