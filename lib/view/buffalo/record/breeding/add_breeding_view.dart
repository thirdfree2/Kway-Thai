import 'dart:io';

import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBreedingView extends StatefulWidget {
  const AddBreedingView({super.key});

  @override
  State<AddBreedingView> createState() => _AddBreedingViewState();
}

class _AddBreedingViewState extends State<AddBreedingView> {
  final formKey = GlobalKey<FormState>();

  final maleNameController = TextEditingController();
  final breedingCountController = TextEditingController();
  final breedingDateController = TextEditingController();
  final recheckDateController = TextEditingController();
  final expectedBirthDateController = TextEditingController();

  String? breedingMethod;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Center(
                    child: Text(
                      'จดบันทึกผสมพันธุ์ \n (Add Breeding)',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildTextField(
                            maleNameController,
                            'ชื่อพ่อพันธุ์ (Stud)',
                          ),
                          _buildDropdownMethod(),
                          _buildTextField(
                            breedingCountController,
                            'จำนวนครั้งที่ผสม (Count)',
                            type: TextInputType.number,
                          ),
                          _buildDatePickerField(
                            breedingDateController,
                            'วันที่ผสม (Breeding date)',
                          ),
                          _buildDatePickerField(
                            recheckDateController,
                            'วันที่เช็คกลับสัด (Recheck Date)',
                          ),
                          _buildDatePickerField(
                            expectedBirthDateController,
                            'กำหนดคลอด (Expected Birth Date)',
                          ),
                          _buildImagePicker(),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: _save,
                            child: const Text("บันทึก (Save)"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
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

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: _validateRequired,
      ),
    );
  }

  Widget _buildDatePickerField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomDatePickerTextFormField(
        controller: controller,
        labelText: label,
        validator: _validateRequired,
      ),
    );
  }

  Widget _buildDropdownMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: breedingMethod,
        items: const [
          DropdownMenuItem(
            value: 'ผสมเทียม',
            child: Text('ผสมเทียม (Artificial)'),
          ),
          DropdownMenuItem(
            value: 'ผสมจริง',
            child: Text('ผสมจริง (Natural)'),
          ),
        ],
        onChanged: (value) => setState(() => breedingMethod = value),
        decoration: const InputDecoration(
          labelText: 'วิธีผสม (Breeding Method)',
          border: OutlineInputBorder(),
        ),
        validator: (value) => value == null
            ? 'กรุณาเลือกวิธีผสม \n(Please Select Breeding Method)'
            : null,
      ),
    );
  }

  Widget _buildImagePicker() {
    Future<void> pickImage() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          image = File(pickedImage.path); // ✅ เก็บในตัวแปร image ที่เป็น state
        });
      }
    }

    return ImagePickerWidget(
      width: 150,
      height: 150,
      selectedImage: image,
      onPickImage: () async {
        await pickImage();
      },
      labelName: 'เพิ่มรูปภาพ \n (Add Photo)',
    );
  }

  void _save() {
    void showPasswordDialog() {
      final passwordController = TextEditingController();
      bool isLoading = false;

      showDialog(
        barrierDismissible: false,
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
                onPressed: isLoading
                    ? null
                    : () async {
                        final password = passwordController.text;
                        if (password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("กรุณากรอกรหัสผ่าน")),
                          );
                        } else {
                          setState(() => isLoading = true);

                          try {
                            String convertThaiDateToIso(String thaiDate) {
                              try {
                                final thDate = DateFormat('dd/MM/yyyy', 'th')
                                    .parse(thaiDate);
                                final christianDate = DateTime(
                                  thDate.year - 543,
                                  thDate.month,
                                  thDate.day,
                                );
                                return DateFormat('yyyy-MM-dd')
                                    .format(christianDate);
                              } catch (_) {
                                return "";
                              }
                            }

                            final buffalo = Provider.of<SelectedBuffalo>(
                              context,
                              listen: false,
                            ).buffalo;

                            Response res = await createBreeding(
                              farmId: buffalo?.farmId.toString() ?? '1',
                              password: password,
                              buffaloId: buffalo?.id.toString() ?? '0',
                              maleName: maleNameController.text,
                              breedingDate: convertThaiDateToIso(
                                breedingDateController.text,
                              ),
                              breedingMethod: breedingMethod!,
                              breedingCount:
                                  int.parse(breedingCountController.text),
                              recheckDate: convertThaiDateToIso(
                                recheckDateController.text,
                              ),
                              expectedBirthDate: convertThaiDateToIso(
                                expectedBirthDateController.text,
                              ),
                              isNatural:
                                  breedingMethod == 'ผสมจริง' ? '1' : '0',
                              imageFile: image!,
                            );

                            if (!context.mounted) return;
                            setState(() => isLoading = false);

                            if (res.statusCode == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("บันทึกสำเร็จ (Save Success)"),
                                ),
                              );
                              Navigator.pop(context); // ปิด dialog
                              Navigator.pop(
                                context,
                                true,
                              ); // ปิดหน้า AddBreedingView
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "รหัสผ่านไม่ถูกต้อง (Wrong Password)",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            setState(() => isLoading = false);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "รหัสผ่านไม่ถูกต้อง (Wrong Password)",
                                ),
                              ),
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

    if (formKey.currentState?.validate() ?? false) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("บันทึกสำเร็จ")),
      // );
      showPasswordDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบทุกช่อง")),
      );
    }
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'กรุณากรอกข้อมูล (Please Enter)';
    }
    return null;
  }
}
