import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/model/association_model.dart';
import 'package:buffalo_thai/model/association_user_model.dart';
import 'package:buffalo_thai/providers/selected_association.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/association_services.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/association/association_user/association_user.dart';
import 'package:buffalo_thai/view/association/register_association_view.dart';
import 'package:buffalo_thai/view/farm/detail_farm_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationDetailView extends StatefulWidget {
  const AssociationDetailView({super.key});

  @override
  State<AssociationDetailView> createState() => _AssociationDetailViewState();
}

class _AssociationDetailViewState extends State<AssociationDetailView> {
  late Future<AssociationModel> futureAssociation;
  @override
  void initState() {
    super.initState();
    final selectAsso = Provider.of<SelectedAssociation>(context, listen: false);
    futureAssociation = futureAssociation = fetchAssociationById(
      id: selectAsso.association?.associationId.toString() ?? '0',
    );
  }

  void navigateToViewUser(AssociationUserModel user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AssociationUser(user: user)),
    );

    if (!mounted) return;

    if (result == true) {
      final buffalo = Provider.of<SelectedAssociation>(context, listen: false);
      setState(() {
        futureAssociation = futureAssociation = fetchAssociationById(
          id: buffalo.association?.associationId.toString() ?? '0',
        );
      });
    }
  }

  void navigateToAddPage() async {
    final buffalo = Provider.of<SelectedAssociation>(context, listen: false);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterAssociationView(
          assoName: buffalo.association?.associationName ?? '',
        ),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      setState(() {
        futureAssociation = futureAssociation = fetchAssociationById(
          id: buffalo.association?.associationId.toString() ?? '0',
        );
      });
    }
  }

  void showPasswordDialog(
    BuildContext context,
    void Function(String) onConfirm,
  ) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ยืนยันรหัสผ่าน'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('กรุณากรอกรหัสผ่านเพื่อดำเนินการต่อ'),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'รหัสผ่าน',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // ปิด dialog
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                final password = passwordController.text.trim();
                if (password.isNotEmpty) {
                  Navigator.pop(context); // ปิด dialog ก่อนส่งรหัสผ่าน
                  onConfirm(password); // ส่งกลับไปยังผู้เรียก
                }
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.3;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
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
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<AssociationModel>(
                      future: futureAssociation,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const Text('ไม่พบข้อมูลสมาคม');
                        } else {
                          final association = snapshot.data!;
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.zero, // เต็มจอ
                                  child: GestureDetector(
                                    onTap: () =>
                                        Navigator.pop(context), // แตะเพื่อปิด
                                    child: InteractiveViewer(
                                      // ✅ ซูม/เลื่อน ได้
                                      child: Center(
                                        child: Image.network(
                                          association.associationImage ??
                                              ApiUtils.imageError,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                            Icons.person,
                                            size: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    association.associationImage ??
                                        ApiUtils.imageError,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.person),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Center(
                        child: FutureBuilder<AssociationModel>(
                          future: futureAssociation,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                            } else if (!snapshot.hasData) {
                              return const Text('ไม่พบข้อมูลสมาคม');
                            } else {
                              final association = snapshot.data!;
                              return Text(
                                association.associationName,
                                // association.associationImage ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    20,
                                  ),
                                  color: Colors.black,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<AssociationModel>(
                  future: futureAssociation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('ไม่พบข้อมูลสมาคม'));
                    } else {
                      final association = snapshot.data!;
                      final users = association.associationUsers
                          .where((user) => user.status == 'อนุมัติ')
                          .toList();

                      if (users.isEmpty) {
                        return Column(
                          children: [
                            const Center(
                              child: Text(
                                'ไม่พบสมาชิกในสมาคมนี้ \n (Member Not fund)',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () => navigateToAddPage(),
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: AutoSizeText(
                                    'ลงทะเบียนสมาชิก \n(Register Member)',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'สมาชิก \n(Member) (${users.length})',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                      context,
                                      14,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => navigateToAddPage(),
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: AutoSizeText(
                                        'ลงทะเบียนสมาชิก \n(Register Member)',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 250,
                            child: GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                final imageUrl = user.image.isNotEmpty
                                    ? user.image
                                    : 'https://via.placeholder.com/150';

                                return InkWell(
                                  onTap: () => navigateToViewUser(user),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        user.nickname,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize:
                                              ScreenUtils.calculateFontSize(
                                            context,
                                            12,
                                          ),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<AssociationModel>(
                  future: futureAssociation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('ไม่พบข้อมูลสมาคม'));
                    } else {
                      final association = snapshot.data!;
                      final farm = association.farms;

                      if (farm.isEmpty) {
                        return const Center(
                          child: Text('ไม่พบสมาชิกในสมาคมนี้'),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'สมาชิก คอก/ฟาร์ม (Farm Member) (${farm.length})',
                                  style: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                      context,
                                      14,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 250,
                            child: GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              // scrollDirection: Axis.horizontal, // 👉 สำคัญมาก
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                childAspectRatio: 3.5, // ปรับความกว้างของการ์ด
                              ),
                              itemCount: farm.length,
                              itemBuilder: (context, index) {
                                final f = farm[index];
                                return InkWell(
                                  onTap: () {
                                    Provider.of<SelectedFarm>(
                                      context,
                                      listen: false,
                                    ).setSelectedFarm(
                                      f.region,
                                      f.farmName,
                                      f.farmId.toString(),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailFarmView(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: Colors.white,
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Center(
                                        child: Text(
                                          '00${index + 1} ${f.farmName}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
