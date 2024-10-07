import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/services/farm_services.dart';
import 'package:buffalo_thai/services/register_farm_ower_services.dart';

class MainFarmRegister extends StatefulWidget {
  const MainFarmRegister({super.key});

  @override
  State<MainFarmRegister> createState() => _MainFarmRegisterState();
}

class _MainFarmRegisterState extends State<MainFarmRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _lineIdController = TextEditingController();
  final TextEditingController _digitController = TextEditingController();
  File? _selectedImage;
  String? _selectedStatus;
  String? _selectedRegion;

  final List<String> _statusOptions = ['เจ้าของฟาร์ม', 'ผู้จัดการ', 'สมาชิก'];
  final List<String> _regionOptions = [
    'เหนือ',
    'กลาง',
    'ใต้',
    'ตะวันตก',
    'ตะวันออก',
    'อีสาน'
  ];

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

// ฟังก์ชัน validate ข้อมูลก่อน submit
  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      final imageFile = _selectedImage;
      if (imageFile == null) {
        _showSnackBar(context, 'กรุณาเลือกภาพ');
        return;
      }

      if (_selectedRegion == null) {
        _showSnackBar(context, 'กรุณาเลือกภาค');
        return;
      }

      if (_selectedStatus == null) {
        _showSnackBar(context, 'กรุณาเลือกสถานะ');
        return;
      }

      if (_digitController.text.length != 6) {
        _showSnackBar(context, 'กรุณากรอกรหัส 6 หลัก');
        return;
      }

      try {
        final region = _selectedRegion ?? '';
        final farmId = await registerFarm(
          farmName: _farmNameController.text,
          lineId: _lineIdController.text,
          region: region,
          phoneNumber: _phoneNumberController.text,
          password: _digitController.text,
        );

        await registerFarmOwner(
          status: 'รอนุมัติ',
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          nickname: _nicknameController.text,
          position: _selectedStatus ?? '',
          phoneNumber: _phoneNumberController.text,
          farmId: farmId.toString(),
          lineId: _lineIdController.text,
          imageFile: _selectedImage,
          password: _digitController.text,
        );

        _showDialog(context, 'ลงทะเบียนสำเร็จ',
            'ข้อมูลฟาร์มและเจ้าของถูกลงทะเบียนเรียบร้อยแล้ว');
      } catch (e) {
        _showSnackBar(context, 'เกิดข้อผิดพลาด: พบชื่อฟาร์มนี้แล้ว');
      }
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                                    child: const Icon(Icons.arrow_back),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'ลงทะเบียนสมาชิก',
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextFormField(
                                        controller: _farmNameController,
                                        labelText: 'คอก/ฟาร์ม',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรุณากรอกข้อมูล';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      StatusDropdown(
                                        labelName: 'ภาค',
                                        selectedStatus: _selectedRegion,
                                        statusOptions: _regionOptions,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedRegion = newValue;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ImagePickerWidget(
                                      selectedImage: _selectedImage,
                                      onPickImage: _pickImage,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _firstNameController,
                                    labelText: 'ชื่อ',
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
                                    controller: _lastNameController,
                                    labelText: 'นามสกุล',
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
                                Flexible(
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
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  child: StatusDropdown(
                                    labelName: 'สถานะ',
                                    selectedStatus: _selectedStatus,
                                    statusOptions: _statusOptions,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedStatus = newValue;
                                      });
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
                                    controller: _phoneNumberController,
                                    labelText: 'เบอร์โทร',
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
                                    controller: _lineIdController,
                                    labelText: 'Line ID',
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _digitController,
                                    keyboardType: TextInputType
                                        .number, // ยังคงเป็นประเภทตัวเลข
                                    obscureText: true, // ซ่อนข้อความที่พิมพ์
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'กรอกรหัส 6 หลัก',
                                    ),
                                    maxLength: 6, // จำกัดความยาวที่ 6 หลัก
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 80),
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextButton(
                                  onPressed:
                                      _validateAndSubmit, // เรียกใช้ validateAndSubmit
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

// ส่วนของ Dropdown
class StatusDropdown extends StatelessWidget {
  final String? selectedStatus;
  final List<String> statusOptions;
  final ValueChanged<String?> onChanged;
  final String labelName;

  const StatusDropdown({
    Key? key,
    required this.selectedStatus,
    required this.statusOptions,
    required this.onChanged,
    required this.labelName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedStatus,
      items: statusOptions.map((String status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(status),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelName,
      ),
      validator: (value) => value == null ? 'กรุณาเลือกสถานะ' : null,
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
                children: [Icon(Icons.add, size: 30), Text('เพิ่มรูปภาพ', style: TextStyle(fontSize: 10),)],
              )
            : Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}
