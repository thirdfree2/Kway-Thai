import 'dart:io';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/award_services.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainRegisterAward extends StatefulWidget {
  const MainRegisterAward({super.key});

  @override
  State<MainRegisterAward> createState() => _MainRegisterAwardState();
}

class _MainRegisterAwardState extends State<MainRegisterAward> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _awardController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  final TextEditingController _generationController = TextEditingController();
  final TextEditingController _dateAwardController = TextEditingController();
  final TextEditingController _awardNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  File? _selectedImage;

  String? _selectedGender;
  final List<String> _genderOptions = ['ผู้', 'เมีย'];

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
      barrierDismissible: false,
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
                  Navigator.of(context).pop(_passwordController.text);
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedFarm = Provider.of<SelectedFarm>(context);
    final selectedBuffalo = Provider.of<SelectedBuffalo>(context);
    final buffalo = selectedBuffalo.buffalo;
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            height: screenHeight * 0.9,
            child: SingleChildScrollView(
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
                                  const Expanded(
                                    child: Text(
                                      'รางวัลงานประกวด',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 24,
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
                                      controller: _rankController,
                                      labelText: 'อันดับ',
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
                                    flex: 2,
                                    child: CustomTextFormField(
                                      controller: _generationController,
                                      labelText: 'ประเภท/รุ่น',
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
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: DropdownBuffalo(
                                            selectedStatus: _selectedGender,
                                            statusOptions: _genderOptions,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedGender = newValue;
                                              });
                                            },
                                            name: 'เพศ',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _colorController,
                                      labelText: 'สี',
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
                                      controller: _awardNameController,
                                      labelText: 'งานประกวด',
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
                                      controller: _provinceController,
                                      labelText: 'จังหวัด',
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
                                    child: CustomDatePickerTextFormField(
                                      controller: _dateAwardController,
                                      labelText:
                                          'วันที่ประกวด', // Label for birth date
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
                                    flex: 1,
                                    child: ImagePickerWidget(
                                      selectedImage: _selectedImage,
                                      onPickImage: _pickImage,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                            // แสดง dialog เพื่อกรอกรหัส 6 หลัก
                                            await _showCodeDialog();

                                            if (_passwordController.text !=
                                                null) {
                                              await addBuffaloAward(
                                                  buffaloId: buffalo?.id ?? 0,
                                                  password:
                                                      _passwordController.text,
                                                  farmId: selectedFarm.farmId,
                                                  province:
                                                      _provinceController.text,
                                                  gender: _selectedGender
                                                      .toString(),
                                                  type: _generationController
                                                      .text,
                                                  name:
                                                      _awardNameController.text,
                                                  rank: _rankController.text,
                                                  date:
                                                      _dateAwardController.text,
                                                  image: imageFile,
                                                  color: _colorController.text);

                                              // ทำการ pop หน้าหลังจากเสร็จสิ้นการทำงาน
                                              Navigator.pop(context);
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
                                      'ยืนยันการเพิ่มรางวัลประกวด',
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

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
      ),
      onPressed: () {},
      child: const Text(
        'ตกลง >>>',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickImage;

  const ImagePickerWidget({
    super.key,
    this.selectedImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        height: 120,
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
