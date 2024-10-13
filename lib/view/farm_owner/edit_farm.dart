import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/user_services.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';

class EditFarm extends StatefulWidget {
  const EditFarm({super.key});

  @override
  _EditFarmState createState() => _EditFarmState();
}

class _EditFarmState extends State<EditFarm> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  late TextEditingController _positionController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _lineIdController = TextEditingController();
  late TextEditingController _nickNameController = TextEditingController();
  // late TextEditingController _urlImgController = TextEditingController();

  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmIdController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  String? _selectedStatus;
  final List<String> _statusOptions = ['เจ้าของฟาร์ม', 'ผู้จัดการ', 'สมาชิก'];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final farmOwner = Provider.of<SelectedFarmOwner>(context, listen: false);
    final selectedFarm = Provider.of<SelectedFarm>(context);
    _farmIdController.text = selectedFarm.farmId;
    _farmNameController.text = selectedFarm.farmNames;
    _userIdController.text = farmOwner.userId;
  }

  @override
  void initState() {
    super.initState();
    final farmOwner = Provider.of<SelectedFarmOwner>(context, listen: false);
    _nameController = TextEditingController(text: farmOwner.farmOwner);
    _lastNameController = TextEditingController(text: farmOwner.lastName);
    _positionController = TextEditingController(text: farmOwner.position);
    _phoneController = TextEditingController(text: farmOwner.phone);
    _lineIdController = TextEditingController(text: farmOwner.lineId);
    _selectedStatus = farmOwner.position;
    // _urlImgController = TextEditingController(text: farmOwner.urlImg);
    _nickNameController = TextEditingController(text: farmOwner.nickname);
  }

  File? _selectedImage;

  Future<void> _showCodeDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('กรุณากรอกรหัส 6 หลัก'),
          content: TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'รหัส 6 หลัก',
            ),
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                if (_passwordController.text.length == 6) {
                  Navigator.of(context).pop(_passwordController
                      .text); // ส่งรหัส 6 หลักกลับเป็น string
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('กรุณากรอกรหัสให้ครบ 6 หลัก')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
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
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: TextButton(
                              onPressed: () async {
                                try {
                                  await _showCodeDialog();

                                  if (_passwordController.text != null) {
                                    // await updateUser(
                                    //     firstName: _nameController.text,
                                    //     userId: _userIdController.text,
                                    //     lastName: _lastNameController.text,
                                    //     nickname: _nickNameController.text,
                                    //     position: _selectedStatus ?? '',
                                    //     phoneNumber: _phoneController.text,
                                    //     farmId: _farmIdController.text,
                                    //     lineId: _lineIdController.text,
                                    //     password: _passwordController.text);
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailFarmView(),
                                      ),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('ลงทะเบียนสำเร็จ'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  print('$e');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
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
