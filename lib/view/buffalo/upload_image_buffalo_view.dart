import 'dart:io';

import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadImageBuffaloView extends StatefulWidget {
  const UploadImageBuffaloView({super.key});

  @override
  State<UploadImageBuffaloView> createState() => _UploadImageBuffaloViewState();
}

class _UploadImageBuffaloViewState extends State<UploadImageBuffaloView> {
  List<File> _selectedImages = []; // ลิสต์สำหรับเก็บไฟล์รูปภาพที่เลือก
  String _inputCode = "";
  bool isLoading = false; // สถานะการโหลด

  Future<void> _pickMultipleImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    setState(() {
      _selectedImages =
          pickedImages.map((pickedFile) => File(pickedFile.path)).toList();
    });
  }

  Future<String?> _showCodeDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ใส่รหัส 6 หลัก (Password)'),
          content: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _inputCode = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'กรุณาใส่รหัส 6 หลัก (Password)',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ยกเลิก \n(Close)',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pop(context, 'Close');
              },
            ),
            TextButton(
              child: const Text(
                'ยืนยัน \n(Confirm)',
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                if (_inputCode.length == 6) {
                  Navigator.pop(context, _inputCode);
                  await _uploadImages(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'กรุณาใส่รหัสให้ครบ 6 หลัก (Please Enter Password)',
                      ),
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

  Future<void> _uploadImages(BuildContext context) async {
    final selectedBuffalo =
        Provider.of<SelectedBuffalo>(context, listen: false);
    final buffalo = selectedBuffalo.buffalo;
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);

    setState(() {
      isLoading = true; // เริ่มการโหลด
    });

    try {
      // ใช้ Future.wait เพื่อรอการอัปโหลดทุกไฟล์
      List<Future> uploadFutures = _selectedImages.map((image) {
        return uploadImageBuffalo(
          imageFile: image,
          buffaloId: buffalo?.id ?? 0,
          password: _inputCode,
          farmId: selectedFarm.farmId,
        );
      }).toList();

      // รอให้ Future ทั้งหมดเสร็จสิ้น
      var results = await Future.wait(uploadFutures);

      if (!context.mounted) return;
      // ตรวจสอบผลลัพธ์การอัปโหลดทั้งหมด
      bool hasError = false;
      for (var msg in results) {
        if (msg == "Buffalo image inserted successfully") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'อัปโหลดรูปภาพสำเร็จ \n(Succes)',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (msg == "รหัสผ่านไม่ถูกต้อง") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('รหัสผ่านไม่ถูกต้อง (Wrong Password)'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          hasError = true;
          break;
        }
      }

      if (!hasError && mounted) {
        setState(() {
          _selectedImages = []; // รีเซ็ตลิสต์รูปภาพ
          _inputCode = ""; // ล้างรหัสผ่าน
          isLoading = false; // สิ้นสุดการโหลด
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'อัปโหลดรูปภาพทั้งหมดเสร็จสิ้นแล้ว (Upload Image Success)',
            ),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
          ),
        );

        // Delay navigation to allow the SnackBar to show up properly
        await Future.delayed(const Duration(seconds: 1));

        if (!context.mounted) {
          return;
        }
        // Navigate after snack bars are shown
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DetailFarmView(),
          ),
        );
      } else {
        setState(() {
          isLoading = false; // หยุดการโหลดหากมีข้อผิดพลาด
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // หยุดการโหลดในกรณีเกิดข้อผิดพลาด
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('การอัปโหลดล้มเหลว (Fail Upload)'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.8,
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
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'เพิ่มรูปภาพ \n(Add Image)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 24),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                isLoading // แสดง Loading เมื่อกำลังอัปโหลด
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: _pickMultipleImages,
                        child: Container(
                          height: 400,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            color: Colors.white.withAlpha((0.6 * 255).round()),
                          ),
                          child: _selectedImages.isEmpty
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add, size: 30),
                                    Text(
                                      'รูปโปรไฟล์ \n(Image)',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : GridView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: _selectedImages.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        2, // จำนวนคอลัมน์ที่ต้องการแสดงในกริด
                                    crossAxisSpacing:
                                        10.0, // ระยะห่างแนวนอนระหว่างรูป
                                    mainAxisSpacing:
                                        10.0, // ระยะห่างแนวตั้งระหว่างรูป
                                    childAspectRatio:
                                        1, // อัตราส่วนความสูงและความกว้างของแต่ละรูป
                                  ),
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _selectedImages[index],
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 150,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            final password = await _showCodeDialog(context);
                            if (password == 'Close') {
                              return;
                            }
                            if (!context.mounted) {
                              return;
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DetailFarmView(),
                              ),
                            );
                          } catch (e) {
                            return;
                          }
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
                              'เพิ่มรูปภาพ \n(Add Image)',
                              textAlign: TextAlign.center,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
