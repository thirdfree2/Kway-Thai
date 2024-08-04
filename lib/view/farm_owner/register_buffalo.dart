import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/model/user_model.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/register_farm_ower_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:provider/provider.dart';

class RegisterBuffalo extends StatefulWidget {
  const RegisterBuffalo({super.key});

  @override
  State<RegisterBuffalo> createState() => _RegisterBuffaloState();
}

class _RegisterBuffaloState extends State<RegisterBuffalo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _lineIdController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _birthMethodController = TextEditingController();
  final TextEditingController _breedingImageController =
      TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _grandfatherNameController =
      TextEditingController();
  final TextEditingController _grandmotherNameController =
      TextEditingController();
  final TextEditingController _greatGrandfatherNameController =
      TextEditingController();
  final TextEditingController _greatGrandmotherNameController =
      TextEditingController();
  final TextEditingController _currentFarmController = TextEditingController();
  File? _selectedImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);
    if (selectedFarm != null) {
      _farmIdController.text = selectedFarm.farmId;
      _farmNameController.text = selectedFarm.farmNames ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                          child: Icon(Icons.arrow_back)),
                    ),
                    const SizedBox(width: 45),
                    Text(
                      'ลงทะเบียนควาย',
                      style: TextStyle(
                          fontSize: ScreenUtils.calculateFontSize(context, 24),
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Container(
                      width: screenWidth / 2,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'คอก/ฟาร์ม',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 110,
                                height: 30,
                                child: TextFormField(
                                  controller: _farmNameController,
                                  style: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                          context, 8)),
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'จังหวัดฟาร์ม',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                height: 30,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                          context, 8)),
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'จังหวัดฟาร์ม',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                height: 30,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: ScreenUtils.calculateFontSize(
                                          context, 8)),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: const Border(
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                  bottom: BorderSide(color: Colors.black),
                                ),
                                color: Colors.white),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                                Text('เพิ่มรูปภาพ')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'วันเกิด',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        controller: _birthDateController,
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 8)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.yellow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'เกิดที่ (คอกฟาร์ม)',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        controller: _birthPlaceController,
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 8)),
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
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'วิธีการผสมพันธุ์',
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 230,
                          height: 30,
                          child: TextFormField(
                            controller: _birthMethodController,
                            style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 8)),
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
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'รูปถ่ายการผสมพันธุ์',
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: TextFormField(
                            controller: _breedingImageController,
                            style: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 8)),
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
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'พ่อพันธุ์ชื่อ',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: TextFormField(
                              controller: _fatherNameController,
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'แม่พันธุ์ชื่อ',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: TextFormField(
                              controller: _motherNameController,
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ปู่ชื่อ',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: TextFormField(
                              controller: _grandfatherNameController,
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ย่าเชื่อ',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: TextFormField(
                              controller: _grandmotherNameController,
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ปู่ทวดชื่อ',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: TextFormField(
                              controller: _greatGrandfatherNameController,
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ตาทวดชื่อ',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: TextFormField(
                              controller: _greatGrandmotherNameController,
                              style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 8)),
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'สังกัดปัจจุบัน',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 250,
                      height: 30,
                      child: TextFormField(
                        controller: _currentFarmController,
                        style: TextStyle(
                            fontSize:
                                ScreenUtils.calculateFontSize(context, 8)),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                          ),
                          color: Colors.white),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          Text('เพิ่มรูปภาพ')
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      height: 60,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                          ),
                          color: Colors.white),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          Text('เพิ่มรูปภาพ')
                        ],
                      ),
                    ),
                  ],
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

                              await registerBuffaloOwner(
                                  farmId: _farmIdController.text,
                                  name: _nicknameController.text,
                                  birthMethod: _birthMethodController.text,
                                  birthDate: _birthDateController.text,
                                );
                              
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
    );
  }
}
