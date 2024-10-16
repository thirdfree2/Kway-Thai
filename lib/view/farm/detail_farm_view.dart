import 'package:buffalo_thai/services/farm_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/model/user_model.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/services/user_services.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';
import 'package:buffalo_thai/view/farm_owner/main_farm_owner.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_wrapper.dart';
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart';

class DetailFarmView extends StatefulWidget {
  const DetailFarmView({super.key});

  @override
  State<DetailFarmView> createState() => _DetailFarmViewState();
}

class _DetailFarmViewState extends State<DetailFarmView> {
  late Future<List<BuffaloModel>> futureBuffaloes;
  late Future<List<UserModel>> futureUser;
   bool isLoading = false;

  bool isEditMode = false;
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);
    futureBuffaloes = fetchBuffaloesByFarmId(selectedFarm.farmId);
    futureUser = fetchUserByFarmId(selectedFarm.farmId);
    _farmNameController.text = selectedFarm.farmNames ?? '';
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);
    String _passwordController = ''; // ตัวแปรสำหรับเก็บรหัสผ่าน

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('ใส่รหัสผ่าน 6 หลัก'),
              content: isLoading // ตรวจสอบสถานะ isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(), // แสดง Loading ขณะกำลังอัปเดตข้อมูล
                    )
                  : TextField(
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _passwordController = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'กรุณาใส่รหัสผ่าน 6 หลัก',
                      ),
                    ),
              actions: <Widget>[
                TextButton(
                  child: const Text('ยกเลิก'),
                  onPressed: () {
                    if (!isLoading) {
                      Navigator.of(context)
                          .pop(); // ปิด Dialog หากไม่อยู่ในสถานะการโหลด
                    }
                  },
                ),
                TextButton(
                  child: const Text('ยืนยัน'),
                  onPressed: () async {
                    if (_passwordController.length == 6) {
                      setState(() {
                        isLoading = true; // เปิดการโหลด
                      });

                      try {
                        final response = await updateFarm(
                          farmName: _farmNameController.text,
                          farmId: selectedFarm.farmId.toString(),
                          password: _passwordController,
                        );

                        if (response == "Farm updated successfully") {
                          Navigator.of(context).pop(); // ปิด Dialog
                          setState(() {
                            isLoading = false; // ปิดการโหลด
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'อัปเดตข้อมูลฟาร์มสำเร็จ ชื่อคอก/ฟาร์มจะเปลี่ยนภายหลัง'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => DetailFarmView(),
                            ),
                          );
                        } else {
                          setState(() {
                            isLoading = false; // ปิดการโหลด
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('เกิดข้อผิดพลาด: รหัสผ่านไม่ถูกต้อง'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false; // ปิดการโหลดในกรณีเกิดข้อผิดพลาด
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('เกิดข้อผิดพลาด: รหัสผ่านไม่ถูกต้อง'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('กรุณาใส่รหัสให้ครบ 6 หลัก'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedFarm = Provider.of<SelectedFarm>(context);
    final region = selectedFarm.region;
    final farmId = selectedFarm.farmId;
    final farmNames = selectedFarm.farmNames;

    final List<String> farmerNames = [
      'John Doe 1',
      'John Doe 2',
      'John Doe 3',
      'John Doe 4',
      'John Doe 5',
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: isEditMode
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            controller: _farmNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ชื่อฟาร์ม',
                            ),
                            onFieldSubmitted: (newValue) {
                              setState(() {
                                isEditMode = false;
                              });
                            },
                          ),
                        )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Center(
                            child: StrokeText(
                              text: farmNames,
                              textStyle: TextStyle(
                                fontSize:
                                    ScreenUtils.calculateFontSize(context, 20),
                                color: Colors.red,
                              ),
                              strokeColor: Colors.white,
                              strokeWidth: 6,
                            ),
                          ),
                      ),
                ),
                IconButton(
                  icon: Icon(isEditMode
                      ? Icons.check
                      : Icons.edit), // แสดงไอคอนตามสถานะ
                  onPressed: () {
                    if (isEditMode) {
                      // เมื่อเป็นสถานะ check (isEditMode = true) ให้แสดง dialog
                      setState(() {
                        isEditMode = false;
                      });

                      // เรียก dialog หลังจาก setState เสร็จสมบูรณ์
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showPasswordDialog(context);
                      });
                    } else {
                      // เมื่อเป็นสถานะ edit (isEditMode = false) ให้เปลี่ยนเป็น edit mode
                      setState(() {
                        isEditMode = true;
                      });
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<List<UserModel>>(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const Text('ไม่พบสมาชิกในฟาร์มนี้'),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterFarmOwner()));
                              },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: AutoSizeText(
                                    'ลงสมาชิก',
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final users = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StrokeText(
                                text: 'สมาชิก (${users.length})',
                                textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 14),
                                  color: Colors.white,
                                ),
                                strokeColor: Colors.black,
                                strokeWidth: 3,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterFarmOwner(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'ลงทะเบียนสมาชิก',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              final imageUrl = user.userImages.isNotEmpty
                                  ? user.userImages[0].imageUrl
                                  : 'https://placeholder.com/150';
                              return InkWell(
                                onTap: () {
                                  Provider.of<SelectedFarmOwner>(context,
                                          listen: false)
                                      .setSelectedFarmOwner(
                                    user.userId.toString() ?? '',
                                    user.nickname ?? '',
                                    user.userImages[0].imageUrl,
                                    user.firstName,
                                    user.lastName,
                                    user.position,
                                    user.phoneNumber ?? '',
                                    user.lineId ?? '',
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainFarmOwner(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    StrokeText(
                                      text: user?.nickname ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      textStyle: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 12),
                                        color: Colors.white,
                                      ),
                                      strokeColor: Colors.black,
                                      strokeWidth: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<List<BuffaloModel>>(
                  future: futureBuffaloes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const Text('ไม่พบควายในฟาร์มนี้'),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterBuffalo()));
                              },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: AutoSizeText(
                                      'ลงทะเบียนควาย',
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final buffaloes = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StrokeText(
                                text: 'ควาย (${buffaloes.length})',
                                textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                      context, 14),
                                  color: Colors.white,
                                ),
                                strokeColor: Colors.black,
                                strokeWidth: 3,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterBuffalo(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: AutoSizeText(
                                      'ลงทะเบียนควาย',
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: buffaloes.length,
                            itemBuilder: (context, index) {
                              final buffalo = buffaloes[index];
                              final profileImage =
                                  buffalo.buffaloImages.firstWhere(
                                (image) => image.isProfileImage,
                                orElse: () => BuffaloImageModel(
                                  imageId: 0,
                                  imagePath: 'https://placeholder.com/150',
                                  isProfileImage: false,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  buffaloId: buffalo.id,
                                ),
                              );

                              final imageUrl = profileImage != null
                                  ? profileImage.imagePath
                                  : 'https://placeholder.com/150';

                              return InkWell(
                                onTap: () {
                                  Provider.of<SelectedBuffalo>(context,
                                          listen: false)
                                      .setSelectedBuffalo(buffalo);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Buffalo(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    StrokeText(
                                      text: buffalo.name,
                                      textStyle: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                            context, 12),
                                        color: Colors.white,
                                      ),
                                      strokeColor: Colors.black,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      strokeWidth: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
