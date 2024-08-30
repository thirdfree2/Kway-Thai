import 'dart:io';

import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stroke_text/stroke_text.dart';

class UploadVideoBuffalo extends StatefulWidget {
  const UploadVideoBuffalo({super.key});

  @override
  State<UploadVideoBuffalo> createState() => _UploadVideoBuffaloState();
}

class _UploadVideoBuffaloState extends State<UploadVideoBuffalo> {
  File? _selectedImage;
  String? _selectedStatus;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _videoNameControler = TextEditingController();

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
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
                        text: 'เพิ่มคลิปวิดีโอ',
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
                          ImagePickerWidget(
                            selectedImage: _selectedImage,
                            onPickImage: _pickImage,
                            width: 200,
                            height: 200, name: 'เพิ่มปกคลิป',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _videoUrlController,
                              labelText: 'แนบลิ้งค์',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _videoNameControler,
                              labelText: 'ชื่อคลิปวิดีโอ',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
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
          ),
        ),
      ),
    );
  }
  
}

class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickImage;
  final double width;
  final double height;
  final String name;

  const ImagePickerWidget({
    Key? key,
    this.selectedImage,
    required this.onPickImage,
    required this.width,
    required this.height,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: Colors.white.withOpacity(0.8),
        ),
        child: selectedImage == null
            ?  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Icon(Icons.add, size: 30), Text(name)],
              )
            : Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}