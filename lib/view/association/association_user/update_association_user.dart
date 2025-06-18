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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final associa = Provider.of<SelectedAssociation>(context, listen: false);
  }

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  late TextEditingController _positionController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _lineIdController = TextEditingController();
  late TextEditingController _nickNameController = TextEditingController();

  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmIdController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final selectAsso = Provider.of<SelectedAssociation>(context, listen: false);
    associa = selectAsso.association!;
    _nameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _positionController = TextEditingController(text: widget.user.position);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _lineIdController = TextEditingController(text: widget.user.lineId);
    _selectedStatus = widget.user.position;
    _nickNameController = TextEditingController(text: widget.user.nickname);
  }

  Future<void> _showCodeDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('กรุณากรอกรหัส'),
          content: TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยัน'),
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
                      const SizedBox(height: 10),
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
                              try {
                                await _showCodeDialog();
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
                              } catch (e) {
                                print("เกิดข้อผิดพลาด: $e");
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                        'รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่.',
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
                              'ยืนยันการแก้ไข',
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
