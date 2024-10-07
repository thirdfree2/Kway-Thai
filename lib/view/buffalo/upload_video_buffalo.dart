import 'dart:io';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class UploadVideoBuffalo extends StatefulWidget {
  const UploadVideoBuffalo({super.key});

  @override
  State<UploadVideoBuffalo> createState() => _UploadVideoBuffaloState();
}

class _UploadVideoBuffaloState extends State<UploadVideoBuffalo> {
  File? _selectedImage;
  String _inputCode = ""; // ตัวแปรสำหรับเก็บรหัส 6 หลัก

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _videoNameController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _showCodeDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('กรุณาใส่รหัสผ่าน 6 หลัก'),
          content: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _inputCode = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'ใส่รหัสผ่าน',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
            ),
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                if (_inputCode.length == 6) {
                  Navigator.of(context).pop(); // ปิด Dialog
                  _uploadVideo(); // เรียกฟังก์ชันอัปโหลดเมื่อใส่รหัสผ่านถูกต้อง
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('กรุณากรอกรหัสผ่านให้ครบ 6 หลัก'),
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

  Future<void> _uploadVideo() async {
    final selectedBuffalo =
        Provider.of<SelectedBuffalo>(context, listen: false);
    final buffalo = selectedBuffalo.buffalo;
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      String videoUrl = _videoUrlController.text;
      String videoName = _videoNameController.text;

      try {
        print(videoUrl);
        String msg = await uploadVideoBuffalo(
          buffaloId: selectedBuffalo.buffalo?.id ?? 0,
          imageFile: _selectedImage,
          password: _inputCode,
          farmId: selectedFarm.farmId,
          title: videoName,
          url: videoUrl,
        );
        if (msg == 'Buffalo clip created successfully') {
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
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('การอัปโหลดล้มเหลว: รหัสผ่านไม่ถูกต้อง $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
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
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back, size: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'เพิ่มคลิปวิดีโอ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                child: _selectedImage == null
                                    ? const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, size: 30),
                                          Text('เพิ่มปกคลิป')
                                        ],
                                      )
                                    : Image.file(_selectedImage!,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _videoUrlController,
                          decoration:
                              const InputDecoration(labelText: 'แนบลิ้งค์'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกลิ้งค์วิดีโอ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _videoNameController,
                          decoration: const InputDecoration(
                              labelText: 'ชื่อคลิปวิดีโอ'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อคลิปวิดีโอ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap:
                              _showCodeDialog, // เรียกฟังก์ชันเพื่อเปิด dialog
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'เพิ่มคลิปวิดีโอ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
