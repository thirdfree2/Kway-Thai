import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/view/buffalo/record/record_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/update_buffalo_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';

class MainBuffaloView extends StatefulWidget {
  const MainBuffaloView({super.key});

  @override
  State<MainBuffaloView> createState() => _MainBuffaloViewState();
}

class _MainBuffaloViewState extends State<MainBuffaloView> {
  String _formatDateToBuddhist(DateTime date) {
    final thaiDate = DateTime(date.year, date.month, date.day);
    return DateFormat('dd MMMM yyyy', 'th_TH').format(thaiDate);
  }

  @override
  Widget build(BuildContext context) {
    final buffalo = Provider.of<SelectedBuffalo>(context).buffalo;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final profileImage = buffalo?.buffaloImages.firstWhere(
      (image) => image.isProfileImage,
      orElse: () => BuffaloImageModel(
        imageId: 0,
        imagePath: ApiUtils.imageError,
        isProfileImage: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        buffaloId: buffalo.id,
        isMicrochipImage: false,
      ),
    );

    final mircrochipImage = buffalo?.buffaloImages.firstWhere(
      (image) => image.isMicrochipImage,
      orElse: () => BuffaloImageModel(
        imageId: 0,
        imagePath: ApiUtils.imageError,
        isProfileImage: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        buffaloId: buffalo.id,
        isMicrochipImage: false,
      ),
    );

    final imageUrl =
        profileImage != null ? profileImage.imagePath : ApiUtils.imageError;

    final microChip = mircrochipImage != null
        ? mircrochipImage.imagePath
        : ApiUtils.imageError;

    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                opacity: 0.8,
                image: AssetImage("assets/images/background-2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdateBuffaloView(),
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeView(),
                                ),
                              ),
                              child: const Icon(
                                Icons.home,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth / 5),
                    child: Container(
                      height: screenHeight * 0.65,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(65),
                          bottomLeft: Radius.circular(65),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 80,
                                ), // เว้นด้านซ้ายไว้ให้เท่ากับปุ่มด้านขวา
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "ประวัติ \n(History)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ScreenUtils.calculateFontSize(
                                          context,
                                          14,
                                        ),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RecordBuffaloView(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'บันทึก \n (Record)',
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
                            Center(
                              child: Text(
                                buffalo?.name ?? '',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    24,
                                  ),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.27,
                              child: ListView(
                                // เปลี่ยนจาก SingleChildScrollView เป็น ListView
                                children: [
                                  const SizedBox(height: 10),
                                  if (buffalo?.gender != '')
                                    _buildInfoRow(
                                      'ควายไทย เพศ ',
                                      'Buffalo Gender',
                                      buffalo?.gender ?? '',
                                      Colors.blue[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.color != '')
                                    _buildInfoRow(
                                      'สี ',
                                      'Color',
                                      buffalo?.color ?? '',
                                      Colors.black,
                                    ),
                                  if (buffalo?.breedName != '')
                                    _buildInfoRow(
                                      'สายพันธุ์ ',
                                      'Breed ',
                                      buffalo?.breedName ?? '',
                                      Colors.red[800],
                                    ),
                                  const SizedBox(height: 5),
                                  // ignore: unrelated_type_equality_checks
                                  if (buffalo?.birthDate != '')
                                    _buildInfoRow(
                                      'เกิด ',
                                      'Born',
                                      // ignore: unrelated_type_equality_checks
                                      buffalo?.birthDate != ''
                                          ? _formatDateToBuddhist(
                                              buffalo!.birthDate!,
                                            ) // เรียกฟังก์ชันสำหรับแปลงวันที่
                                          : '',
                                      Colors.red[900],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.bornAt != '')
                                    _buildInfoRow(
                                      'เกิดที่ คอก/ฟาร์ม ',
                                      'Born At',
                                      buffalo?.bornAt ?? '',
                                      Colors.green[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.birthMethod != null)
                                    _buildInfoRow(
                                      'โดยวิธีการ ',
                                      'Breeding Method',
                                      buffalo?.birthMethod ?? '',
                                      Colors.red[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.fatherName != '')
                                    _buildInfoRow(
                                      'พ่อพันธุ์ คือ',
                                      'Father Bleed',
                                      buffalo?.fatherName ?? '',
                                      Colors.red[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.motherName != '')
                                    _buildInfoRow(
                                      'แม่พันธุ์ คือ ',
                                      'Mother Bleed',
                                      buffalo?.motherName ?? '',
                                      Colors.red[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.fatherGrandfatherName != '')
                                    _buildInfoRow(
                                      'สายเลือดทางปู่',
                                      'Paternal Grandfather Bleed',
                                      buffalo?.fatherGrandfatherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.fatherGrandmotherName != '')
                                    _buildInfoRow(
                                      'สายเลือดทางย่า',
                                      'Paternal Grandmother Bleed',
                                      buffalo?.fatherGrandmotherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.motherGrandfatherName != '')
                                    _buildInfoRow(
                                      'สายเลือดทางตา',
                                      'Maternal Grandfather Bleed',
                                      buffalo?.motherGrandfatherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.motherGrandmotherName != '')
                                    _buildInfoRow(
                                      'สายเลือดทางยาย',
                                      'Maternal Grandmother Bleed',
                                      buffalo?.motherGrandmotherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.fatherGreatGrandfatherName != '')
                                    _buildInfoRow(
                                      'สืบสายเลือดปู่ทวด',
                                      'Paternal Great-Grandfather Bleed',
                                      buffalo?.fatherGreatGrandfatherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.motherGreatGrandfatherName != '')
                                    _buildInfoRow(
                                      'สืบสายเลือดตาทวด',
                                      'Maternal Great-Grandfather Bleed',
                                      buffalo?.motherGreatGrandfatherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.fatherGreatGrandmotherName != '')
                                    _buildInfoRow(
                                      'สืบสายเลือดย่าทวด',
                                      'Paternal Great-Grandmother Bleed',
                                      buffalo?.fatherGreatGrandmotherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 5),
                                  if (buffalo?.motherGreatGrandmotherName != '')
                                    _buildInfoRow(
                                      'สืบสายเลือดยายทวด',
                                      'Maternal Great-Grandmother Bleed',
                                      buffalo?.motherGreatGrandmotherName ?? '',
                                      Colors.pink[800],
                                    ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: screenWidth * 0.05,
            bottom: screenHeight * 0.095,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    if (microChip != '')
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Center(
                                  child: Text(
                                    'หมายเลขไมโครชิฟ \n(Microchip No.)',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        buffalo?.microchipNO ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (microChip != '')
                                      Image.network(
                                        microChip, // ✅ แสดงรูปบัตรจาก URL
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Text(
                                            'ไม่พบรูปภาพ \n(Image Not Found)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.red),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(
                                      context,
                                    ).pop(),
                                    child: const Text('ปิด'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'หมายเลขไมโครชิฟ \n(Microchip No.)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    // SizedBox(
                    //   width: 150,
                    //   child: Card(
                    //     color: Colors.green[500],
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         textAlign: TextAlign.center,
                    //         buffalo?.farm?.farmName ?? 'Not Found 404',
                    //         style: const TextStyle(color: Colors.white),
                    //         maxLines: 2, // กำหนดจำนวนบรรทัดสูงสุดของข้อความ
                    //         overflow: TextOverflow
                    //             .ellipsis, // ทำให้ข้อความที่ยาวเกินไปแสดง ... (ellipsis)
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'สังกัดปัจจุบัน \n(Current Under)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 100, 7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 150,
                      child: Card(
                        color: Colors.green[500],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            buffalo?.farm?.farmName ?? 'Not Found 404',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 2, // กำหนดจำนวนบรรทัดสูงสุดของข้อความ
                            overflow: TextOverflow
                                .ellipsis, // ทำให้ข้อความที่ยาวเกินไปแสดง ... (ellipsis)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.025,
            left: 20,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the popup
                          },
                          child: const Text(
                            "ปิด \n(Close)",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.29,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String labelEn,
    String value,
    Color? color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                '$label ',
                maxFontSize: 13,
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtils.calculateFontSize(context, 13),
                ),
              ),
              AutoSizeText(
                '$labelEn ',
                maxFontSize: 13,
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtils.calculateFontSize(context, 13),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: AutoSizeText(
            value,
            maxFontSize: 13,
            maxLines: 2,
            style: TextStyle(
              color: color,
              fontSize: ScreenUtils.calculateFontSize(context, 13),
              decoration: TextDecoration.underline,
              decorationColor: color,
              decorationThickness: 2,
            ),
          ),
        ),
      ],
    );
  }
}
