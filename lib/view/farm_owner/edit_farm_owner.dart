import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';

class EditFarmOwnerScreen extends StatefulWidget {
  const EditFarmOwnerScreen({super.key});

  @override
  _EditFarmOwnerScreenState createState() => _EditFarmOwnerScreenState();
}

class _EditFarmOwnerScreenState extends State<EditFarmOwnerScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _positionController;
  late TextEditingController _phoneController;
  late TextEditingController _lineIdController;
  late TextEditingController _nickNameController;
  late TextEditingController _urlImgController;

  @override
  void initState() {
    super.initState();
    final farmOwner = Provider.of<SelectedFarmOwner>(context, listen: false);
    _nameController = TextEditingController(text: farmOwner.farmOwner);
    _lastNameController = TextEditingController(text: farmOwner.lastName);
    _positionController = TextEditingController(text: farmOwner.position);
    _phoneController = TextEditingController(text: farmOwner.phone);
    _lineIdController = TextEditingController(text: farmOwner.lineId);
    _urlImgController = TextEditingController(text: farmOwner.urlImg);
    _nickNameController = TextEditingController(text: 'Test');
  }

  File? _selectedImage;

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
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const AutoSizeText(
                    'แก้ไขสมาชิก',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFormField(
                          controller: _nameController,
                          labelText: 'ชื่อ',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: _lastNameController,
                          labelText: 'นามสกุล',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: _nickNameController,
                          labelText: 'ชื่อเล่น',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: _positionController,
                          labelText: 'ตำแหน่ง',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: _phoneController,
                          labelText: 'เบอร์โทร',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: _lineIdController,
                          labelText: 'Line ID',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImagePickerWidget(
                              width: 120,
                              height: 80,
                              selectedImage: _selectedImage,
                              onPickImage: _pickImage,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: TextButton(
                              onPressed: () async {},
                              child: const Text(
                                'ยืนยันการแก้ไข',
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
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;

  const CustomTextFormField({
    required this.controller,
    required this.labelText,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}
