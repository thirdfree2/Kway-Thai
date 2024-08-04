import 'dart:io';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/register_farm_ower_services.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _lineIdController = TextEditingController();
  File? _selectedImage;

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

  Future<void> _uploadImage(File image, String userId) async {
    String apiUrl = "${ApiUtils.baseUrl}/api/user/$userId";
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');

    final imageUploadRequest = http.MultipartRequest('PUT', Uri.parse(apiUrl));
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
    );

    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        print("Upload success: ${response.body}");
      } else {
        print("Upload error: ${response.body}");
      }
    } catch (e) {
      print("Upload error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailFarmView(),
                              ),
                            );
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(width: 45),
                      Text(
                        'ลงทะเบียนสมาชิก',
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 24),
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text('คอก/ฟาร์ม',
                                      style: TextStyle(color: Colors.red)),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      controller: _farmNameController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.yellow,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text('จังหวัดฟาร์ม',
                                      style: TextStyle(color: Colors.red)),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 80,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.yellow,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white),
                                  child: _selectedImage == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add, size: 30),
                                            Text('เพิ่มรูปภาพ')
                                          ],
                                        )
                                      : Image.file(_selectedImage!,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text('ชื่อ', style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text('นามสกุล',
                            style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text('ชื่อเล่น',
                            style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _nicknameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text('สถานะ',
                            style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _statusController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text('เบอร์โทร',
                            style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text('Line ID',
                            style: TextStyle(color: Colors.red)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _lineIdController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.yellow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final userId = await registerFarmOwner(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    nickname: _nicknameController.text,
                                    position: _statusController.text,
                                    phoneNumber: _phoneNumberController.text,
                                    farmId: _farmIdController.text,
                                  );
                                  if (_selectedImage != null) {
                                    await _uploadImage(_selectedImage!, userId);
                                  }
                                } catch (e) {
                                  print('Error: $e');
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
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
