import 'package:buffalo_thai/components/label_value_text.dart';
import 'package:buffalo_thai/model/buffalo_vaccine_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/record/vaccine/add_vaccine_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VaccineBuffaloView extends StatefulWidget {
  const VaccineBuffaloView({super.key});

  @override
  State<VaccineBuffaloView> createState() => _VaccineBuffaloViewState();
}

class _VaccineBuffaloViewState extends State<VaccineBuffaloView> {
  late Future<List<BuffaloVaccineModel>> futureVaccine;
  bool isInit = true;

  @override
  void initState() {
    super.initState();
    final buffalo =
        Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
    futureVaccine = fetchVaccineBuffaloes(
      buffalo?.id.toString() ?? '',
    ); // กำหนดค่าให้เรียบร้อย
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      final buffalo =
          Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
      futureVaccine = fetchVaccineBuffaloes(buffalo?.id.toString() ?? '');
      isInit = false;
    }
  }

  void navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddVaccineView()),
    );

    if (result == true) {
      if (!mounted) return;

      final buffalo =
          Provider.of<SelectedBuffalo>(context, listen: false).buffalo;
      setState(() {
        futureVaccine = fetchVaccineBuffaloes(buffalo?.id.toString() ?? '');
      });
    }
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
                              "ฉีดวัคซีน (Vaccine)",
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
                        FutureBuilder<List<BuffaloVaccineModel>>(
                          future: futureVaccine,
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
                                  'ไม่พบข้อมูลฉีดวัคซีนของควาย \n (Not Found Record)',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            } else {
                              // final vaccineList = snapshot.data!;
                              final vaccineList =
                                  snapshot.data!.reversed.toList();
                              // ..sort((a, b) {
                              //   return b.createdAt.compareTo(a.createdAt);
                              // });
                              return SizedBox(
                                height: screenHeight / 1.70,
                                child: ListView.builder(
                                  shrinkWrap:
                                      true, // สำคัญ: ให้แสดงใน SingleChildScrollView ได้
                                  itemCount: vaccineList.length,
                                  itemBuilder: (context, index) {
                                    return ExpandableVaccineCard(
                                      vaccine: vaccineList[index],
                                      index: vaccineList.length - index,
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
                              'เพิ่มฉีดวัคซีน \n (Add Vaccine)',
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

class ExpandableVaccineCard extends StatefulWidget {
  const ExpandableVaccineCard({
    super.key,
    required this.vaccine,
    required this.index,
  });
  final BuffaloVaccineModel vaccine;
  final int index;

  @override
  State<ExpandableVaccineCard> createState() => _ExpandableVaccineCardState();
}

class _ExpandableVaccineCardState extends State<ExpandableVaccineCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ครั้งที่ (Vaccination Round): ${widget.index + 1}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(
                  height: 10,
                ),
                if (widget.vaccine.buffaloVaccineRecords.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("ไม่พบการฉีดวัคซีน (Not Found)"),
                    ),
                  )
                else
                  ...widget.vaccine.buffaloVaccineRecords.map((record) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelValueText(
                            label: "วัคซีน (Vaccine)",
                            value: record.vaccineName ?? "",
                          ),
                          LabelValueText(
                            label: "เข็มที่ (Dose Number)",
                            value: record.doseNumber ?? "",
                          ),
                          LabelValueText(
                            label: "ปริมาณ (Volume)",
                            value: "${record.volume} มิลลิลิตร (ml)",
                          ),
                          LabelValueText(
                            label: "วันที่ฉีด (Injection Date)",
                            value: record.injectionDate,
                            type: LabelValueType.date,
                          ),
                          LabelValueText(
                            label: "วันที่เข็มถัดไป (Next Injection)",
                            value: record.nextInjectionDate,
                            type: LabelValueType.date,
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
