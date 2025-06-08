import 'package:buffalo_thai/model/association_model.dart';
import 'package:buffalo_thai/providers/selected_association.dart';
import 'package:buffalo_thai/services/association_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/association/association_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationListView extends StatefulWidget {
  const AssociationListView({super.key});

  @override
  State<AssociationListView> createState() => _AssociationListViewState();
}

class _AssociationListViewState extends State<AssociationListView> {
  late Future<List<AssociationModel>> futureAssociation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAssociation = fetchAssociation();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-1.jpg"),
              fit: BoxFit.cover),
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
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'สมาคม \n(Association)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenUtils.calculateFontSize(context, 28),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: screenHeight / 1.5,
                  child: Card(
                    color: Colors.white.withOpacity(0.6),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: FutureBuilder<List<AssociationModel>>(
                              future: futureAssociation,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          'เกิดข้อผิดพลาด: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('ไม่พบข้อมูลสมาคม'));
                                } else {
                                  final associations = snapshot.data!;
                                  return ListView.builder(
                                    itemCount: associations.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: SizedBox(
                                          height: 80,
                                          child: InkWell(
                                            onTap: () {
                                              Provider.of<SelectedAssociation>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedAssociation(
                                                      associations[index]);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AssociationDetailView(),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Text(
                                                    'A0${index + 1} ${associations[index].associationName} ',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
