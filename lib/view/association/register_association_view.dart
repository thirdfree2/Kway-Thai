import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/providers/selected_association.dart';
import 'package:buffalo_thai/services/association_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart'
    hide CustomTextFormField;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterAssociationView extends StatefulWidget {
  const RegisterAssociationView({super.key, required this.assoName});
  final String assoName;

  @override
  State<RegisterAssociationView> createState() =>
      _RegisterAssociationViewState();
}

class _RegisterAssociationViewState extends State<RegisterAssociationView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _lineIdController = TextEditingController();

  final List<String> _statusOptions = [
    'นายกสมาคม',
    'รองนายกสมาคม',
    'เลขา',
    'เหรัญญิก',
    'กรรมการ',
  ];
  File? _selectedImage;
  String? _selectedStatus;

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
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.7,
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white.withAlpha((0.6 * 255).round()),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
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
                                      horizontal: 10,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.arrow_back),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'ลงทะเบียนสมาชิกสมาคม',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          24,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        AutoSizeText(
                                          maxLines: 1,
                                          'ลงทะเบียนสมาชิกสำหรับฟาร์ม',
                                          style: TextStyle(
                                            fontSize:
                                                ScreenUtils.calculateFontSize(
                                              context,
                                              8,
                                            ),
                                          ),
                                        ),
                                        AutoSizeText(
                                          maxLines: 1,
                                          widget.assoName,
                                          style: TextStyle(
                                            fontSize:
                                                ScreenUtils.calculateFontSize(
                                              context,
                                              24,
                                            ),
                                          ),
                                        ),
                                      ],
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _phoneNumberController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'เบอร์โทร',
                                      ),
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
                              const SizedBox(height: 80),
                              Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // ตรวจสอบว่ามีการเลือกรูปภาพแล้วหรือยัง
                                        if (_selectedImage == null) {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialog(
                                              title: Text('โปรดเลือกภาพ'),
                                              content: Text(
                                                'กรุณาเลือกรูปภาพก่อนลงทะเบียน',
                                              ),
                                            ),
                                          );
                                          return;
                                        }
                                        _save();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    void showPasswordDialog() {
      final passwordController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("ยืนยันรหัสผ่าน (Password Required)"),
            content: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "รหัสผ่าน (Password)",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // ยกเลิก
                child: const Text("ยกเลิก (Cancel)"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final password = passwordController.text;
                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("กรุณากรอกรหัสผ่าน")),
                    );
                  } else {
                    try {
                      final selectAsso = Provider.of<SelectedAssociation>(
                        context,
                        listen: false,
                      );

                      if (_selectedImage == null) {
                        return;
                      }
                      await registerAssociationUser(
                        associationId:
                            selectAsso.association?.associationId ?? 0,
                        password: password,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        nickname: _nicknameController.text,
                        lineId: _lineIdController.text,
                        phoneNumber: _phoneNumberController.text,
                        position: _selectedStatus ?? '',
                        profileImage:
                            _selectedImage!, // อย่าลืมตรวจ null ก่อนหน้า
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("ลงทะเบียนสำเร็จ")),
                      );

                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
                child: const Text(
                  "ยืนยัน \n (Confirm)",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      );
    }

    if (_formKey.currentState?.validate() ?? false) {
      showPasswordDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบทุกช่อง")),
      );
    }
  }
}

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    this.selectedImage,
    required this.onPickImage,
  });
  final File? selectedImage;
  final VoidCallback onPickImage;

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
          color: Colors.white.withAlpha((0.6 * 255).round()),
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
