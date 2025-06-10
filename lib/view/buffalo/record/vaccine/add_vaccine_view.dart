import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddVaccineView extends StatefulWidget {
  const AddVaccineView({super.key});

  @override
  State<AddVaccineView> createState() => _AddVaccineViewState();
}

class _AddVaccineViewState extends State<AddVaccineView> {
  final List<Map<String, dynamic>> vaccines = [
    {
      "vaccineName": TextEditingController(),
      "doseNumber": TextEditingController(),
      "volume": TextEditingController(),
      "injectionDate": TextEditingController(),
      "nextInjectionDate": TextEditingController(),
    }
  ];

  void addVaccine() {
    setState(() {
      vaccines.add({
        "vaccineName": TextEditingController(),
        "doseNumber": TextEditingController(),
        "volume": TextEditingController(),
        "injectionDate": TextEditingController(),
        "nextInjectionDate": TextEditingController(),
      });
    });
  }

  void removeVaccine(int index) {
    setState(() {
      vaccines.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    void showPasswordDialog() {
      final passwordController = TextEditingController();

      showDialog(
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
                onPressed: () async {
                  final password = passwordController.text;
                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("กรุณากรอกรหัสผ่าน")),
                    );
                  } else {
                    try {
                      String convertThaiDateToIso(String thaiDate) {
                        try {
                          // แปลงจาก "06 ก.ค. 2568" → DateTime
                          // ใช้ฟอร์แมต dd/MM/yyyy กับปี พ.ศ.
                          final thDate =
                              DateFormat('dd/MM/yyyy', 'th').parse(thaiDate);

                          // แปลงจาก พ.ศ. เป็น ค.ศ.
                          final christianDate = DateTime(
                            thDate.year - 543,
                            thDate.month,
                            thDate.day,
                          );

                          return DateFormat('yyyy-MM-dd').format(christianDate);
                        } catch (_) {
                          return ""; // หรือ throw Error
                        }
                      }

                      final buffalo =
                          Provider.of<SelectedBuffalo>(context, listen: false)
                              .buffalo;

                      await createVaccine(
                        farmId: buffalo?.farmId.toString() ?? '1',
                        password: password,
                        buffaloId: buffalo?.id.toString() ?? '0',
                        vaccines: vaccines
                            .map(
                              (item) => {
                                "vaccineName": item["vaccineName"].text,
                                "doseNumber":
                                    int.parse(item["doseNumber"].text),
                                "volume": double.parse(item["volume"].text),
                                "injectionDate": convertThaiDateToIso(
                                  item["injectionDate"].text,
                                ),
                                "nextInjectionDate": convertThaiDateToIso(
                                  item["nextInjectionDate"].text,
                                ),
                              },
                            )
                            .toList(),
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "บันทึกข้อมูลวัคซีนเรียบร้อย Record Success",
                          ),
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
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

    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white.withAlpha((0.6 * 255).round()),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'จดบันทึกการฉีดวัคซีน (Add Vaccine)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreenUtils.calculateFontSize(
                                      context,
                                      16,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: screenWidth / 1.5,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () => addVaccine(),
                                  child: const Text(
                                    'เพิ่มข้อมูล (Add Vaccine)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          ...List.generate(vaccines.length, (index) {
                            final item = vaccines[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Text(
                                      "อันดับ (No.) ${index + 1}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextFormField(
                                      controller: item["vaccineName"],
                                      labelText: 'ชื่อวัคซีน (Vaccine Name)',
                                      validator: _validateRequired,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextFormField(
                                      controller: item["doseNumber"],
                                      labelText: 'เข็มที่ (Dose)',
                                      keyboardType: TextInputType.number,
                                      validator: _validateRequired,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextFormField(
                                      controller: item["volume"],
                                      labelText: 'ปริมาณ (ml)',
                                      keyboardType: TextInputType.number,
                                      validator: _validateRequired,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomDatePickerTextFormField(
                                      controller: item["injectionDate"],
                                      labelText:
                                          'วันที่ฉีดวัคซีน (Inject Date)',
                                      validator: _validateRequired,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomDatePickerTextFormField(
                                      controller: item["nextInjectionDate"],
                                      labelText:
                                          'เข็มถัดไป (Next Injection Date)',
                                      validator: _validateRequired,
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => removeVaccine(index),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (vaccines.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "กรุณาเพิ่มข้อมูลวัคซีนอย่างน้อย 1 รายการ (Please add at least one vaccine)",
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (formKey.currentState?.validate() ?? false) {
                                showPasswordDialog();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("กรุณากรอกข้อมูลให้ครบทุกช่อง"),
                                  ),
                                );
                              }
                            },
                            child: const Text("บันทึกทั้งหมด (Save)"),
                          ),
                        ],
                      ),
                    ),
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

String? _validateRequired(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'กรุณากรอกข้อมูล (please enter)';
  }
  return null;
}
