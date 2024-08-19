import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/register_farm_ower_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';

class RegisterBuffalo extends StatefulWidget {
  const RegisterBuffalo({super.key});

  @override
  State<RegisterBuffalo> createState() => _RegisterBuffaloState();
}

class _RegisterBuffaloState extends State<RegisterBuffalo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmIdController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _birthMethodController = TextEditingController();
  final TextEditingController _breedingImageController =
      TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _grandfatherNameController =
      TextEditingController();
  final TextEditingController _grandmotherNameController =
      TextEditingController();
  final TextEditingController _greatGrandfatherNameController =
      TextEditingController();
  final TextEditingController _greatGrandmotherNameController =
      TextEditingController();
  final TextEditingController _currentFarmController = TextEditingController();
  File? _selectedImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);
    if (selectedFarm != null) {
      _farmIdController.text = selectedFarm.farmId;
      _farmNameController.text = selectedFarm.farmNames ?? '';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background-1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.8),
                      margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'ลงทะเบียนควาย',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: ScreenUtils.calculateFontSize(
                                              context, 24),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CustomTextFormField(
                                      controller: _farmNameController,
                                      labelText: 'คอก/ฟาร์ม',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกข้อมูล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: ImagePickerWidget(
                                      selectedImage: _selectedImage,
                                      onPickImage: _pickImage,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _nicknameController,
                                      labelText: 'ชื่อเล่น',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกข้อมูล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _birthDateController,
                                      labelText: 'วันเกิด',
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
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: _birthPlaceController,
                                labelText: 'เกิดที่ (คอกฟาร์ม)',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: _birthMethodController,
                                labelText: 'วิธีการผสมพันธุ์',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: _breedingImageController,
                                labelText: 'รูปถ่ายการผสมพันธุ์',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _fatherNameController,
                                      labelText: 'พ่อพันธุ์ชื่อ',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกข้อมูล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _motherNameController,
                                      labelText: 'แม่พันธุ์ชื่อ',
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
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _grandfatherNameController,
                                      labelText: 'ปู่ชื่อ',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกข้อมูล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _grandmotherNameController,
                                      labelText: 'ย่าชื่อ',
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
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _greatGrandfatherNameController,
                                      labelText: 'ปู่ทวดชื่อ',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'กรุณากรอกข้อมูล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _greatGrandmotherNameController,
                                      labelText: 'ตาทวดชื่อ',
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
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: _currentFarmController,
                                labelText: 'สังกัดปัจจุบัน',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              Container(
                                height: 50,
                                width: screenWidth / 2,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await registerBuffaloOwner(
                                          farmId: _farmIdController.text,
                                          name: _nicknameController.text,
                                          birthMethod:
                                              _birthMethodController.text,
                                          birthDate: _birthDateController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'ลงทะเบียน',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
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

// ฟิลด์ป้อนข้อมูลทั่วไป
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}

// ส่วนของการเลือกภาพ
class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickImage;

  const ImagePickerWidget({
    Key? key,
    this.selectedImage,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: Colors.white.withOpacity(0.8),
        ),
        child: selectedImage == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add, size: 30), Text('เพิ่มรูปภาพ')],
              )
            : Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}
