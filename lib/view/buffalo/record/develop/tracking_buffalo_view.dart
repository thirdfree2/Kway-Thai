import 'dart:io';

import 'package:buffalo_thai/components/label_value_text.dart';
import 'package:buffalo_thai/model/buffalo_tracking_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TrackingBuffaloView extends StatefulWidget {
  const TrackingBuffaloView({super.key});

  @override
  State<TrackingBuffaloView> createState() => _TrackingBuffaloViewState();
}

class _TrackingBuffaloViewState extends State<TrackingBuffaloView> {
  late Future<List<BuffaloTrackingModel>> futureTracking;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      final buffalo =
          Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
      futureTracking = fetchTrackingBuffaloes(buffalo?.id.toString() ?? '');
      isInit = false;
    }
  }

  void refreshTracking() {
    final buffalo =
        Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
    setState(() {
      futureTracking = fetchTrackingBuffaloes(buffalo?.id.toString() ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.8,
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: screenHeight,
            child: ListView(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Card(
                  // ignore: deprecated_member_use
                  color: Colors.white.withAlpha((0.6 * 255).round()),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "พัฒนาการ (Development)",
                              style: TextStyle(
                                fontSize: ScreenUtils.calculateFontSize(
                                  context,
                                  19,
                                ),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        FutureBuilder<List<BuffaloTrackingModel>>(
                          future: futureTracking,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'เกิดข้อผิดพลาด (Error): ${snapshot.error}',
                                ),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  'ไม่พบข้อมูลพัฒนาของควาย \n (Not Found Record)',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            } else {
                              final trackingList = snapshot.data!;
                              return SizedBox(
                                height: screenHeight / 1.70,
                                child: ListView.builder(
                                  shrinkWrap:
                                      true, // สำคัญ: ให้แสดงใน SingleChildScrollView ได้
                                  itemCount: trackingList.length,
                                  itemBuilder: (context, index) {
                                    final track = trackingList[index];
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16,
                                      ),
                                      child: ListTile(
                                        leading: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Image.network(
                                                    track
                                                        .imagePath, // ใช้ URL ของรูปภาพจาก AnnouceModel
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return const Text(
                                                        'ไม่สามารถโหลดรูปภาพได้',
                                                      );
                                                    },
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // ปิด Popup
                                                      },
                                                      child: const Text("ปิด"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Image.network(
                                            track.imagePath,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(
                                              Icons.image_not_supported,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "ช่วงอายุ (Age Period): ${track.agePeriod}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        // title: Text(
                                        //   "ช่วงอายุ (Age Period): ${track.agePeriod}",
                                        //   style: const TextStyle(fontSize: 15),
                                        // ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LabelValueText(
                                              label: "ส่วนสูง (Height)",
                                              value:
                                                  "${track.buffaloHeight} ซม.",
                                            ),
                                            LabelValueText(
                                              label: "น้ำหนัก (Weight)",
                                              value:
                                                  "${track.buffaloWeight} กก.",
                                            ),
                                            if (track.createdAt != null)
                                              LabelValueText(
                                                label: "วันที่บันทึก (Date)",
                                                value: track.createdAt ?? "",
                                                type: LabelValueType.date,
                                              )
                                            else
                                              const LabelValueText(
                                                label: "วันที่บันทึก (Date)",
                                                value:
                                                    "ไม่พบวันที่บันทึก (Not Found)",
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () =>
                            showAddTrackingDialog(context, refreshTracking),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'เพิ่มพัฒนาการ \n (Add Develop)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAddTrackingDialog(
  BuildContext context,
  VoidCallback onSubmitSuccess,
) {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final datePickerController = TextEditingController();

  bool useCustomDate = false;

  String? selectAgePeriod;

  final List<String> agePeriodOptions = [
    'แรกเกิด',
    '1 สัปดาห์',
    '1 เดือน',
    '3 เดือน',
    '6 เดือน',
    '12 เดือน',
    '18 เดือน',
    '24 เดือน',
    '36 เดือน',
    '48 เดือน',
  ];

  final scaffoldContext = context;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final buffalo = Provider.of<SelectedBuffalo>(context).buffalo;
      File? selectedImage;
      String? imageErrorText;

      return StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;

          Future<void> pickImage() async {
            final pickedImage =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              setState(() {
                selectedImage = File(pickedImage.path);
              });
            }
          }

          return Dialog(
            insetPadding: const EdgeInsets.all(30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("เพิ่มพัฒนาการ \n (Development)"),
                      leading: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CheckboxListTile(
                              title: const Text(
                                "ระบุวันที่เอง \n(Specify Date)",
                                textAlign: TextAlign.center,
                              ),
                              value: useCustomDate,
                              onChanged: (value) {
                                setState(() {
                                  useCustomDate = value ?? false;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (useCustomDate)
                              CustomDatePickerTextFormField(
                                controller: datePickerController,
                                labelText: 'ระบุวันที่เอง (Specify Date)',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'กรุณาระบุวันที่ (Please enter Date)';
                                  }
                                  return null;
                                },
                              ),
                            if (!useCustomDate)
                              DropdownBuffalo(
                                validateName:
                                    "กรุณาระบุอายุปัจจุบัน (Please enter current age)",
                                selectedStatus: selectAgePeriod,
                                statusOptions: agePeriodOptions,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectAgePeriod = newValue;
                                  });
                                },
                                name: 'อายุปัจจุบัน (Current Age)',
                              ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: weightController,
                              labelText: 'น้ำหนัก กก. (Weight kg.)',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(
                                    r'^\d*\.?\d{0,2}',
                                  ),
                                ), // รองรับทศนิยม 2 ตำแหน่ง
                              ],
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'กรุณาระบุน้ำหนัก (Please enter weight)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: heightController,
                              labelText: 'ส่วนสูง ซม. (Height cm.)',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(
                                    r'^\d*\.?\d{0,2}',
                                  ),
                                ), // รองรับทศนิยม 2 ตำแหน่ง
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'กรุณาระบุส่วนสูง (Please enter height)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ImagePickerWidget(
                              width: 150,
                              height: 150,
                              selectedImage: selectedImage,
                              onPickImage: () async {
                                await pickImage();
                                setState(() {
                                  imageErrorText =
                                      null; // clear error เมื่อเลือกรูป
                                });
                              },
                              labelName: 'เพิ่มรูปภาพ \n (Add Photo)',
                            ),
                            if (imageErrorText != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  imageErrorText!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              "ยกเลิก \n (Cancel)",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    final isFormValid =
                                        formKey.currentState!.validate();
                                    final isImageValid = selectedImage != null;

                                    if (!isImageValid) {
                                      setState(() {
                                        imageErrorText =
                                            'กรุณาเลือกรูปภาพ (Please enter photo)';
                                      });
                                    }

                                    if (isFormValid && isImageValid) {
                                      String convertBuddhistToGregorian(
                                        String input,
                                      ) {
                                        try {
                                          final parts = input.split('/');
                                          if (parts.length == 3) {
                                            final day =
                                                parts[0].padLeft(2, '0');
                                            final month =
                                                parts[1].padLeft(2, '0');
                                            final year = int.parse(parts[2]) -
                                                543; // แปลง พ.ศ. → ค.ศ.
                                            return '$day-$month-$year';
                                          }
                                        } catch (_) {}
                                        return input; // fallback ถ้าแปลงไม่ได้
                                      }

                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          final passwordController =
                                              TextEditingController();
                                          final passwordFormKey =
                                              GlobalKey<FormState>();

                                          return AlertDialog(
                                            title: const Text(
                                              "ยืนยันรหัสผ่าน (Confirm Password)",
                                            ),
                                            content: Form(
                                              key: passwordFormKey,
                                              child: TextFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      'รหัสผ่าน (Password)',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'กรุณากรอกรหัสผ่าน \n (Plase enter password)';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  "ยกเลิก \n (Cancel)",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (passwordFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    Navigator.of(context)
                                                        .pop(); // ปิด dialog

                                                    setState(() {
                                                      isLoading = true;
                                                    });

                                                    try {
                                                      await createTrackingBuffalo(
                                                        buffaloId: buffalo!.id,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        farmId: buffalo.farmId
                                                            .toString(),
                                                        imageFile:
                                                            selectedImage,
                                                        buffaloWeight:
                                                            int.parse(
                                                          weightController.text,
                                                        ),
                                                        buffaloHeight:
                                                            int.parse(
                                                          heightController.text,
                                                        ),
                                                        agePeriod: useCustomDate
                                                            ? convertBuddhistToGregorian(
                                                                datePickerController
                                                                    .text,
                                                              )
                                                            : selectAgePeriod!,
                                                      );

                                                      ScaffoldMessenger.of(
                                                        // ignore: use_build_context_synchronously
                                                        scaffoldContext,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "สำเร็จ: สร้างรายงานพัฒนาการสำเร็จ (Create Record success)",
                                                          ),
                                                        ),
                                                      );

                                                      Navigator.of(
                                                        // ignore: use_build_context_synchronously
                                                        scaffoldContext,
                                                      ).pop(); // ปิดฟอร์ม
                                                      onSubmitSuccess();
                                                    } catch (e) {
                                                      ScaffoldMessenger.of(
                                                        // ignore: use_build_context_synchronously
                                                        scaffoldContext,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "เกิดข้อผิดพลาด: ${e.toString()}",
                                                          ),
                                                        ),
                                                      );
                                                    } finally {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: const Text(
                                                  "ยืนยัน \n (Save)",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "บันทึก \n (Save)",
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
