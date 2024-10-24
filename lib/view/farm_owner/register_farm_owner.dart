import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/view/farm/list_farm_view.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:buffalo_thai/services/register_farm_ower_services.dart';

class RegisterFarmOwner extends StatefulWidget {
  const RegisterFarmOwner({super.key});

  @override
  State<RegisterFarmOwner> createState() => _RegisterFarmOwnerState();
}

class _RegisterFarmOwnerState extends State<RegisterFarmOwner> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _lineIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _selectedImage;
  String? _selectedStatus;

  final List<String> _statusOptions = ['เจ้าของฟาร์ม', 'ผู้จัดการ', 'สมาชิก'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedFarm = Provider.of<SelectedFarm>(context);
    _farmIdController.text = selectedFarm.farmId;
    _farmNameController.text =
        selectedFarm.farmNames; // Assuming farmNames is a string
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

  Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // ป้องกันไม่ให้ปิด Dialog จากการคลิกนอกกรอบ
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text('กำลังโหลด...',
                  style: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 16))),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                                          fontSize:
                                              ScreenUtils.calculateFontSize(
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
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          AutoSizeText(
                                            maxLines: 1,
                                            'ลงทะเบียนสมาชิกสำหรับฟาร์ม',
                                            style: TextStyle(
                                                fontSize: ScreenUtils
                                                    .calculateFontSize(
                                                        context, 8)),
                                          ),
                                          AutoSizeText(
                                            maxLines: 1,
                                            _farmNameController.text,
                                            style: TextStyle(
                                                fontSize: ScreenUtils
                                                    .calculateFontSize(
                                                        context, 24)),
                                          ),
                                        ],
                                      )),
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
                                    // child: CustomTextFormField(
                                    //   controller: _phoneNumberController,
                                    //   labelText: 'เบอร์โทร',
                                    //   validator: (value) {
                                    //     if (value == null || value.isEmpty) {
                                    //       return 'กรุณากรอกข้อมูล';
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final imageFile = _selectedImage;
                                        if (imageFile != null) {
                                          try {
                                            showLoadingDialog(context);
                                            // แสดง dialog เพื่อกรอกรหัส 6 หลัก
                                            await _showCodeDialog();

                                            if (_passwordController.text !=
                                                null) {
                                              // ส่งข้อมูลไปยัง API หลังจากกรอกรหัสถูกต้องแล้ว
                                              final userId =
                                                  await registerFarmOwner(
                                                firstName:
                                                    _firstNameController.text,
                                                lastName:
                                                    _lastNameController.text,
                                                nickname:
                                                    _nicknameController.text,
                                                position: _selectedStatus ?? '',
                                                phoneNumber:
                                                    _phoneNumberController.text,
                                                farmId: _farmIdController.text,
                                                lineId: _lineIdController.text,
                                                imageFile: imageFile,
                                                password:
                                                    _passwordController.text,
                                                status: 'รอนุมัติ',
                                              );
                                              Navigator.pop(context);
                                              // ทำการ pop หน้าหลังจากเสร็จสิ้นการทำงาน
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailFarmView(),
                                                ),
                                              );

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'ลงทะเบียนสำเร็จ'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          } catch (e) {
                                            print('Error: $e');
                                            Navigator.of(context).pop();
                                            // แสดง dialog แจ้งข้อผิดพลาด
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        } else {
                                          // ถ้าไม่ได้เลือกภาพให้แสดงข้อความแจ้งเตือน
                                          print('Please select an image');
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Image Required'),
                                                content: const Text(
                                                    'Please select an image.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
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

// ส่วนของ Dropdown
class StatusDropdown extends StatelessWidget {
  final String? selectedStatus;
  final List<String> statusOptions;
  final ValueChanged<String?> onChanged;

  const StatusDropdown({
    Key? key,
    required this.selectedStatus,
    required this.statusOptions,
    required this.onChanged,
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'สถานะ',
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
                children: [Icon(Icons.add, size: 30), Text('เพิ่มรูปภาพ')],
              )
            : Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}
