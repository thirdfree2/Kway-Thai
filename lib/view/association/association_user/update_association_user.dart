import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/components/kwai_thai_bg.dart';
import 'package:buffalo_thai/model/association_model.dart';
import 'package:buffalo_thai/model/association_user_model.dart';
import 'package:buffalo_thai/providers/selected_association.dart';
import 'package:buffalo_thai/services/association_services.dart';
import 'package:buffalo_thai/view/association/association_detail_view.dart';
import 'package:buffalo_thai/view/buffalo/update_buffalo_view.dart'
    hide ImagePickerWidget;
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart'
    hide CustomTextFormField;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateAssociationUser extends StatefulWidget {
  const UpdateAssociationUser({super.key, required this.user});
  final AssociationUserModel user;

  @override
  State<UpdateAssociationUser> createState() => _UpdateAssociationUserState();
}

class _UpdateAssociationUserState extends State<UpdateAssociationUser> {
  late AssociationModel associa;
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

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  // late TextEditingController _positionController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _lineIdController = TextEditingController();
  late TextEditingController _nickNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final selectAsso = Provider.of<SelectedAssociation>(context, listen: false);
    associa = selectAsso.association!;
    _nameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    // _positionController = TextEditingController(text: widget.user.position);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _lineIdController = TextEditingController(text: widget.user.lineId);
    _selectedStatus = widget.user.position;
    _nickNameController = TextEditingController(text: widget.user.nickname);
  }

  Future<String?> _showCodeDialog() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'กรุณากรอกรหัส \n(Please Enter Password)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          content: TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'รหัสผ่าน (Password)',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'ยกเลิก\n(Cancel)',
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              child: const Text(
                'ยืนยัน \n(Confirm)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(_passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KwaiThaiBg(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: AutoSizeText(
                    'แก้ไขสมาชิก \n(Edit Member)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white.withAlpha((0.6 * 255).round()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: ImagePickerWidget(
                          selectedImage: _selectedImage,
                          onPickImage: _pickImage,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _nameController,
                        labelText: 'ชื่อ (Firstname)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล (Please Enter)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _lastNameController,
                        labelText: 'นามสกุล (Lastname)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล (Please Enter)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _nickNameController,
                        labelText: 'ชื่อเล่น (Nickname)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล (Please Enter)';
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
                        labelText: 'เบอร์โทร (Phone)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล (Please Enter)';
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
                            return 'กรุณากรอกข้อมูล (Please Enter)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              try {
                                final password = await _showCodeDialog();

                                if (password == null || password.isEmpty) {
                                  return;
                                }
                                await updateAssociationUser(
                                  associationId: associa.associationId,
                                  password: _passwordController.text,
                                  firstName: _nameController.text,
                                  lastName: _lastNameController.text,
                                  nickname: _nickNameController.text,
                                  lineId: _lineIdController.text,
                                  phoneNumber: _phoneController.text,
                                  position: _selectedStatus ?? '',
                                  profileImage: _selectedImage,
                                  associationUserId: widget.user.associationId
                                      .toString(), // อย่าลืมตรวจ null ก่อนหน้า
                                );
                                if (!context.mounted) {
                                  return;
                                }

                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AssociationDetailView(),
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'แก้ไขสำเร็จ \n(Update Success)',
                                        textAlign: TextAlign.center,
                                      ),
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
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                        'รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่. \n(Wrong Password)',
                                        textAlign: TextAlign.center,
                                      ),
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
                              'ยืนยันการแก้ไข \n(Confirm Update)',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // InkWell(
                      //   onTap: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //           title: const Text('ยืนยันการลบสมาชิก'),
                      //           content: const Text(
                      //             'กรุณายืนยันเพือทำการลบสมาชิก',
                      //           ),
                      //           actions: <Widget>[
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 TextButton(
                      //                   child: const Text('ยกเลิก'),
                      //                   onPressed: () {
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 5,
                      //                 ),
                      //                 ElevatedButton(
                      //                   style: ButtonStyle(
                      //                     backgroundColor:
                      //                         WidgetStateProperty.all<Color>(
                      //                       Colors.red,
                      //                     ),
                      //                   ),
                      //                   onPressed: () {
                      //                     Navigator.of(context).pop();
                      //                     Navigator.of(context).pop();
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                   child: const Text(
                      //                     'ยืนยัน',
                      //                     style: TextStyle(
                      //                       color: Colors.white,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: const Text(
                      //     'ลบสมาชิก',
                      //     style: TextStyle(color: Colors.red),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
