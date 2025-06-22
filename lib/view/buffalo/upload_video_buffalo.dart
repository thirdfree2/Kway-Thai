import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/view/buffalo/update_buffalo_view.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadVideoBuffalo extends StatefulWidget {
  const UploadVideoBuffalo({super.key});

  @override
  State<UploadVideoBuffalo> createState() => _UploadVideoBuffaloState();
}

class _UploadVideoBuffaloState extends State<UploadVideoBuffalo> {
  File? _selectedImage;
  File? _selectedVideo;
  File? _selectedImagelink;
  String _inputCode = "";
  final TextEditingController _linkController = TextEditingController();

  bool linkVideoStage = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImageLink() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImagelink = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        _selectedVideo = File(pickedVideo.path);
      });
    }
  }

  Future<void> _showCodeDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('กรุณาใส่รหัสผ่าน 6 หลัก (Please Enter Password)'),
          content: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _inputCode = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'ใส่รหัสผ่าน (Password)',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ยกเลิก \n(Close)',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
            ),
            TextButton(
              child: const Text(
                'ยืนยัน \n(Confirm)',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                if (_inputCode.length == 6) {
                  Navigator.of(context).pop(); // ปิด Dialog
                  _uploadVideoAndImage(); // เรียกฟังก์ชันอัปโหลดเมื่อใส่รหัสผ่านถูกต้อง
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'กรุณากรอกรหัสผ่านให้ครบ 6 หลัก (Please Enter Password)',
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

  Future<void> _uploadVideoAndImage() async {
    final selectedBuffalo =
        Provider.of<SelectedBuffalo>(context, listen: false);
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);

    if (!linkVideoStage) {
      if (_formKey.currentState!.validate() &&
          _selectedImage != null &&
          _selectedVideo != null) {
        try {
          // เรียกฟังก์ชันอัปโหลดด้วยพารามิเตอร์รูปภาพและวิดีโอ
          String msg = await uploadVideoBuffalo(
            buffaloId: selectedBuffalo.buffalo?.id ?? 0,
            imageFile: _selectedImage,
            videoFile: _selectedVideo,
            password: _inputCode,
            farmId: selectedFarm.farmId,
          );

          if (!mounted) {
            return;
          }

          if (msg == 'อัพโหลดคลิปวิดีโอและรูปภาพสำเร็จ') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('อัปโหลดสำเร็จ (Success)'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            // Navigate to the farm detail view after success
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DetailFarmView(),
              ),
            );
          }
        } catch (e) {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'การอัปโหลดล้มเหลว: รหัสผ่านไม่ถูกต้อง (Wrong Password)',
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'กรุณาเลือกรูปภาพและวิดีโอให้ครบถ้วน (Please Check Video Upload)',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (_selectedImagelink != null) {
        try {
          String msg = await uploadVideoBuffaloWithLink(
            buffaloId: selectedBuffalo.buffalo?.id ?? 0,
            imageFile: _selectedImagelink,
            password: _inputCode,
            farmId: selectedFarm.farmId,
            videoUrl: _linkController.text,
            title: '',
          );

          if (msg == 'Buffalo clip created successfully') {
            if (!mounted) {
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('อัปโหลดสำเร็จ (Upload Success)'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            if (!mounted) {
              return;
            }

            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DetailFarmView(),
              ),
            );
          }
        } catch (e) {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('การอัปโหลดล้มเหลว: รหัสผ่านไม่ถูก (Wrong Password)'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'กรุณาเลือกรูปภาพและวิดีโอให้ครบถ้วน  (Please Check Video Upload)',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withAlpha((0.6 * 255).round()),
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
                        const Text(
                          'เพิ่มคลิปวิดีโอและรูปภาพ \n(Add Video and Video Image)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  linkVideoStage = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: linkVideoStage
                                    ? Colors.red
                                    : Colors.red[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  'อัปโหลดคลิป \n(Upload File Video)',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  minFontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  linkVideoStage = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !linkVideoStage
                                    ? Colors.red
                                    : Colors.red[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  'แนบลิงค์วิดีโอ \n(Upload Link Video)',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  minFontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        !linkVideoStage
                            ? Column(
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
                                        color: Colors.white
                                            .withAlpha((0.6 * 255).round()),
                                      ),
                                      child: _selectedImage == null
                                          ? const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add, size: 30),
                                                Text(
                                                  'เพิ่มปกคลิป \n(Video Image)',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          : Image.file(
                                              _selectedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: _pickVideo,
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white
                                            .withAlpha((0.6 * 255).round()),
                                      ),
                                      child: _selectedVideo == null
                                          ? const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add, size: 30),
                                                Text(
                                                  'เพิ่มคลิปวิดีโอ \n(Add Video)',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          : const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.video_camera_back,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                                Text(
                                                  'อัพโหลดสำเร็จ \n(Upload Success)',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: _pickImageLink,
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white
                                            .withAlpha((0.6 * 255).round()),
                                      ),
                                      child: _selectedImagelink == null
                                          ? const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add, size: 30),
                                                Text(
                                                  'เพิ่มปกคลิป \n(Add Video Image)',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey
                                                      .shade300, // สีพื้นหลัง
                                                ),
                                                child: Image.file(
                                                  _selectedImagelink!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextFormField(
                                    controller: _linkController,
                                    labelText: 'แนบลิ้งค์วิดีโอ (Link Video)',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูล (Please Enter)';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                        const SizedBox(height: 10),
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
                                'อัปโหลด \n(Upload)',
                                textAlign: TextAlign.center,
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
