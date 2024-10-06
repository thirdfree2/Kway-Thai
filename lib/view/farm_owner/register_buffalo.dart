import 'dart:io';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';

class RegisterBuffalo extends StatefulWidget {
  const RegisterBuffalo({super.key});

  @override
  State<RegisterBuffalo> createState() => _RegisterBuffaloState();
}

class _RegisterBuffaloState extends State<RegisterBuffalo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmIdController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _fatherGrandfatherNameController =
      TextEditingController();
  final TextEditingController _fatherGrandmotherNameController =
      TextEditingController();
  final TextEditingController _motherGrandfatherNameController =
      TextEditingController();
  final TextEditingController _motherGrandmotherNameController =
      TextEditingController();
  final TextEditingController _fatherGreatGrandfatherNameController =
      TextEditingController();
  final TextEditingController _fatherGreatGrandmotherNameController =
      TextEditingController();
  final TextEditingController _motherGreatGrandfatherNameController =
      TextEditingController();
  final TextEditingController _motherGreatGrandmotherNameController =
      TextEditingController();

  final TextEditingController _fatherFarmNameController =
      TextEditingController();
  final TextEditingController _motherFarmNameController =
      TextEditingController();
  final TextEditingController _fatherGrandfatherFarmNameController =
      TextEditingController();
  final TextEditingController _fatherGrandmotherFarmNameController =
      TextEditingController();
  final TextEditingController _motherGrandfatherFarmNameController =
      TextEditingController();
  final TextEditingController _motherGrandmotherFarmNameController =
      TextEditingController();
  final TextEditingController _fatherGreatGrandfatherFarmNameController =
      TextEditingController();
  final TextEditingController _fatherGreatGrandmotherFarmNameController =
      TextEditingController();
  final TextEditingController _motherGreatGrandfatherFarmNameController =
      TextEditingController();
  final TextEditingController _motherGreatGrandmotherFarmNameController =
      TextEditingController();

  final TextEditingController _currentFarmController = TextEditingController();
  File? _selectedImage;

  String? _selectedGender;
  String? _selectedBirthMethod;

  final List<String> _genderOptions = ['ผู้', 'เมีย'];
  final List<String> _birthMethodOptions = ['ผสมเทียม', 'ผสมจริง'];

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background-1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white.withOpacity(0.8),
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
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'ลงทะเบียนควาย',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 24),
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
                                    'ลงทะเบียนควายสำหรับฟาร์ม',
                                    style: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 8)),
                                  ),
                                  AutoSizeText(
                                    maxLines: 1,
                                    _farmNameController.text,
                                    style: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 24)),
                                  ),
                                ],
                              )),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: ImagePickerWidget(
                              width: 150,
                              height: 150,
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
                              labelText: 'ชื่อควาย',
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
                            child: CustomDatePickerTextFormField(
                              controller: _birthDateController,
                              labelText: 'วันเกิด', // Label for birth date
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
                        controller: _colorController,
                        labelText: 'สี',
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
                            child: Row(
                              children: [
                                Flexible(
                                  child: DropdownBuffalo(
                                    selectedStatus: _selectedBirthMethod,
                                    statusOptions: _birthMethodOptions,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedBirthMethod = newValue;
                                      });
                                    },
                                    name: 'วิธีการผสมพันธุ์',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
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
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _fatherNameController,
                        buffaloNameText: 'พ่อชื่อ',
                        farmController: _fatherFarmNameController,
                        buffaloHeadText: 'ข้อมูลพ่อ',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _motherNameController,
                        buffaloNameText: 'แม่ชื่อ',
                        farmController: _motherFarmNameController,
                        buffaloHeadText: 'ข้อมูลแม่',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _fatherGrandfatherNameController,
                        buffaloNameText: 'ปู่ชื่อ',
                        farmController: _fatherGrandfatherFarmNameController,
                        buffaloHeadText: 'ข้อมูลปู่',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _fatherGrandmotherNameController,
                        buffaloNameText: 'ย่าชื่อ',
                        farmController: _fatherGrandmotherFarmNameController,
                        buffaloHeadText: 'ข้อมูลย่า',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _motherGrandfatherNameController,
                        buffaloNameText: 'ตาชื่อ',
                        farmController: _motherGrandfatherFarmNameController,
                        buffaloHeadText: 'ข้อมูลตา',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _motherGrandmotherNameController,
                        buffaloNameText: 'ยายชื่อ',
                        farmController: _motherGrandmotherFarmNameController,
                        buffaloHeadText: 'ข้อมูลยาย',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _motherGreatGrandfatherNameController,
                        buffaloNameText: 'ตาทวดชื่อ',
                        farmController:
                            _motherGreatGrandfatherFarmNameController,
                        buffaloHeadText: 'ข้อมูลตาทวด',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _motherGreatGrandmotherNameController,
                        buffaloNameText: 'ยายทวดชื่อ',
                        farmController:
                            _motherGreatGrandmotherFarmNameController,
                        buffaloHeadText: 'ข้อมูลยายทวด',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _fatherGreatGrandfatherNameController,
                        buffaloNameText: 'ปู่ทวดชื่อ',
                        farmController:
                            _fatherGreatGrandfatherFarmNameController,
                        buffaloHeadText: 'ข้อมูลปู่ทวด',
                      ),
                      const SizedBox(height: 15),
                      FamilyForm(
                        nameController: _fatherGreatGrandmotherNameController,
                        buffaloNameText: 'ย่าทวดชื่อ',
                        farmController:
                            _fatherGreatGrandmotherFarmNameController,
                        buffaloHeadText: 'ข้อมูลย่าทวด',
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
                              if (_selectedImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('กรุณาเลือกรูปโปรไฟล์'),
                                  ),
                                );
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('ลงทะเบียนสำเร็จ'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text('โปรดกรอกรหัสของฟาร์ม'),
                                          TextField(
                                            controller: _controller,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              hintText: 'กรอกรหัส 6 หลัก',
                                            ),
                                            maxLength: 6,
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('ตกลง'),
                                          onPressed: () async {
                                            String farmCode = _controller.text;
                                            if (farmCode.length == 6) {
                                              try {
                                                showLoadingDialog(context);

                                                String result =
                                                    await registerBuffalo(
                                                  name:
                                                      _nicknameController.text,
                                                  birthDate:
                                                      _birthDateController.text,
                                                  farmId:
                                                      _farmIdController.text,
                                                  birthMethod:
                                                      _selectedBirthMethod ??
                                                          'ไม่ได้ระบุ',
                                                  fatherName:
                                                      _fatherNameController
                                                          .text,
                                                  motherName:
                                                      _motherNameController
                                                          .text,
                                                  fatherGrandfatherName:
                                                      _fatherGrandfatherNameController
                                                          .text,
                                                  fatherGrandmotherName:
                                                      _fatherGrandmotherNameController
                                                          .text,
                                                  motherGrandfatherName:
                                                      _motherGrandfatherNameController
                                                          .text,
                                                  motherGrandmotherName:
                                                      _motherGrandmotherNameController
                                                          .text,
                                                  fatherGreatGrandfatherName:
                                                      _fatherGreatGrandfatherNameController
                                                          .text,
                                                  fatherGreatGrandmotherName:
                                                      _fatherGreatGrandmotherNameController
                                                          .text,
                                                  motherGreatGrandfatherName:
                                                      _motherGreatGrandfatherNameController
                                                          .text,
                                                  motherGreatGrandmotherName:
                                                      _motherGreatGrandmotherNameController
                                                          .text,
                                                  gender: _selectedGender ??
                                                      'ไม่ได้ระบุ',
                                                  color: _colorController.text,
                                                  imageFile: _selectedImage,
                                                  password: farmCode,
                                                  fatherFarmName:
                                                      _fatherFarmNameController
                                                          .text,
                                                  motherFarmName:
                                                      _motherFarmNameController
                                                          .text,
                                                  fatherGrandfatherFarmName:
                                                      _fatherGrandfatherFarmNameController
                                                          .text,
                                                  fatherGrandmotherFarmName:
                                                      _fatherGrandmotherFarmNameController
                                                          .text,
                                                  motherGrandfatherFarmName:
                                                      _motherGrandfatherFarmNameController
                                                          .text,
                                                  motherGrandmotherFarmName:
                                                      _motherGrandmotherFarmNameController
                                                          .text,
                                                  fatherGreatGrandfatherFarmName:
                                                      _fatherGreatGrandfatherFarmNameController
                                                          .text,
                                                  fatherGreatGrandmotherFarmName:
                                                      _fatherGreatGrandmotherFarmNameController
                                                          .text,
                                                  motherGreatGrandfatherFarmName:
                                                      _motherGreatGrandfatherFarmNameController
                                                          .text,
                                                  motherGreatGrandmotherFarmName:
                                                      _motherGreatGrandmotherFarmNameController
                                                          .text,
                                                  bornAt: _birthPlaceController
                                                      .text,
                                                );
                                                Navigator.of(context).pop();
                                                print(
                                                    'ลงทะเบียนฟาร์มสำเร็จ: $result');
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'ลงทะเบียนสำเร็จ'),
                                                      content: const Text(
                                                          'ข้อมูลฟาร์มถูกลงทะเบียนเรียบร้อยแล้ว'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'ตกลง'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailFarmView(),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } catch (e) {
                                                print(e);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'เกิดข้อผิดพลาด: รหัสผ่านไม่ถูกต้อง'),
                                                  ),
                                                );
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'กรุณากรอกรหัสฟาร์มให้ครบ 6 หลัก'),
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
      validator: validator,
    );
  }
}

class CustomDatePickerTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;

  const CustomDatePickerTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showRoundedDatePicker(
      locale: const Locale("th", "TH"),
      context: context,
      era: EraMode.BUDDHIST_YEAR,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final buddhistYear = pickedDate.year + 543;
      controller.text = DateFormat('dd/MM/yyyy').format(
        DateTime(buddhistYear, pickedDate.month, pickedDate.day),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      readOnly: true, // ป้องกันไม่ให้ผู้ใช้พิมพ์เอง
      onTap: () {
        _selectDate(context); // เรียก date picker เมื่อคลิกที่ TextFormField
      },
      validator: validator,
    );
  }
}

class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickImage;
  final double width;
  final double height;

  const ImagePickerWidget({
    Key? key,
    this.selectedImage,
    required this.onPickImage,
    required this.width,
    required this.height,
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
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add, size: 30), Text('รูปโปรไฟล์')],
              )
            : Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}

class DropdownBuffalo extends StatelessWidget {
  final String? selectedStatus;
  final List<String> statusOptions;
  final ValueChanged<String?> onChanged;
  final String name;

  const DropdownBuffalo({
    Key? key,
    required this.name,
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
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: name,
      ),
      validator: (value) => value == null ? 'กรุณาเลือกสถานะ' : null,
    );
  }
}

class FamilyForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController farmController;
  final String buffaloHeadText;
  final String buffaloNameText;
  const FamilyForm({
    Key? key,
    required this.nameController,
    required this.farmController,
    required this.buffaloHeadText,
    required this.buffaloNameText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(buffaloHeadText),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: nameController,
          labelText: buffaloNameText,
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: farmController,
          labelText: 'สังกัด',
        ),
      ],
    );
  }
}
