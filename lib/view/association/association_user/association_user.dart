import 'package:buffalo_thai/components/kwai_thai_bg.dart';
import 'package:buffalo_thai/model/association_model.dart';
import 'package:buffalo_thai/model/association_user_model.dart';
import 'package:buffalo_thai/providers/selected_association.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/association/association_user/update_association_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationUser extends StatefulWidget {
  const AssociationUser({super.key, required this.user});
  final AssociationUserModel user;

  @override
  State<AssociationUser> createState() => _AssociationUserState();
}

class _AssociationUserState extends State<AssociationUser> {
  late Future<dynamic> futureAssociation;
  late AssociationModel associa;

  @override
  void initState() {
    super.initState();
    final selectAsso = Provider.of<SelectedAssociation>(context, listen: false);
    associa = selectAsso.association!;
    // ❗ ต้องเลื่อนไปใช้ใน didChangeDependencies() แทน context ใน initState
  }

  @override
  Widget build(BuildContext context) {
    return KwaiThaiBg(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            associa.associationName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtils.calculateFontSize(context, 24),
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white.withAlpha((0.6 * 255).round()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateAssociationUser(
                                      user: widget.user,
                                    ), // Corrected syntax here
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.edit),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ), // Adjust the radius as needed
                                ),
                                child: Image.network(
                                  widget.user.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ชื่อเล่น : ${widget.user.nickname}',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    34,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'นามสกุล : ${widget.user.lastName}',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    22,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ตำแหน่ง : ${widget.user.position}',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    22,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ชื่อ : ${widget.user.firstName} ${widget.user.lastName}',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    18,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'เบอร์โทร : ${widget.user.phoneNumber}',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    18,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ID line : ${widget.user.lineId}',
                                style: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(
                                    context,
                                    18,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  width: 100,
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        'ย้อนกลับ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtils.calculateFontSize(context, 18),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('ชื่อผู้ใช้: ${widget.user.firstName} ${widget.user.lastName}'),
        ],
      ),
    );
  }
}
