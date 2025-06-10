import 'package:buffalo_thai/components/detail_section.dart';
import 'package:buffalo_thai/components/kwai_thai_bg.dart';
import 'package:buffalo_thai/components/label_value_text.dart';
import 'package:buffalo_thai/model/buffalo_breeding_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/record/breeding/add_breeding_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BreedingBuffaloView extends StatefulWidget {
  const BreedingBuffaloView({super.key});

  @override
  State<BreedingBuffaloView> createState() => _BreedingBuffaloViewState();
}

class _BreedingBuffaloViewState extends State<BreedingBuffaloView> {
  @override
  late Future<List<BuffaloBreedingModel>> futureBreeding;
  bool isInit = true;

  @override
  void initState() {
    super.initState();
    final buffalo =
        Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
    futureBreeding = fetchBuffaloeBreeding(
      buffalo?.id.toString() ?? '',
    ); // กำหนดค่าให้เรียบร้อย
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      final buffalo =
          Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
      futureBreeding = fetchBuffaloeBreeding(buffalo?.id.toString() ?? '');
      isInit = false;
    }
  }

  void navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddBreedingView()),
    );

    if (result == true) {
      final buffalo =
          Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
      setState(() {
        futureBreeding = fetchBuffaloeBreeding(buffalo?.id.toString() ?? '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return KwaiThaiBg(
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
          Center(
            child: Column(
              children: [
                Text(
                  "การผสมพันธุ์ \n (Breeding)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtils.calculateFontSize(context, 24),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.white.withAlpha((0.6 * 255).round()),
            child: FutureBuilder<List<BuffaloBreedingModel>>(
              future: futureBreeding,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('เกิดข้อผิดพลาด (Error): ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'ไม่พบข้อมูลการผสมพันธุ์ของควาย \n (Not Found Record)',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  // final vaccineList = snapshot.data!;
                  final breedingList = snapshot.data!
                    ..sort((a, b) {
                      return b.createdAt.compareTo(a.createdAt);
                    });
                  return SizedBox(
                    height: screenHeight / 1.70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap:
                            true, // สำคัญ: ให้แสดงใน SingleChildScrollView ได้
                        itemCount: breedingList.length,
                        itemBuilder: (context, index) {
                          final breeding = breedingList[index];
                          return buildBreedingCard(breeding);
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                      child: Text(
                        'เพิ่มการผสมพันธุ์ \n (Add Breeding)',
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
    );
  }

  String _formatThaiDate(DateTime dateStr) {
    try {
      return DateFormat('dd MMM yyyy', 'th').format(
        DateTime(dateStr.year + 543, dateStr.month, dateStr.day),
      );
    } catch (_) {
      return "ไม่พบวันที่";
    }
  }

  Widget buildBreedingCard(BuffaloBreedingModel breeding) {
    final imageWidget = buildBreedingImage(breeding);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageWidget,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ชื่อพ่อพันธุ์ (Stud): ${breeding.maleName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                LabelValueText(
                  label: "วิธีผสม (Method)",
                  value: breeding.breedingMethod,
                ),
                LabelValueText(
                  label: "จำนวนครั้งที่ผสม (Count)",
                  value: breeding.breedingCount.toString(),
                ),
                LabelValueText(
                  label: "วันที่ผสม (Breeding date)",
                  value: breeding.breedingDate,
                  type: LabelValueType.date,
                ),
                LabelValueText(
                  label: "กำหนดคลอด (Expected Birth)",
                  value: breeding.breedingDate,
                  type: LabelValueType.date,
                ),
                LabelValueText(
                  label: "วันที่บันทึก (Created At)",
                  value: breeding.breedingDate,
                  type: LabelValueType.date,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBreedingImage(BuffaloBreedingModel breeding) {
    if (breeding.buffaloBreedingImages.isEmpty) {
      return const Icon(Icons.image_not_supported);
    }
    final imageUrl = breeding.buffaloBreedingImages[0].imageUrl;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('ไม่สามารถโหลดรูปภาพได้');
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("ปิด"),
                ),
              ],
            );
          },
        );
      },
      child: Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
      ),
    );
  }
}
