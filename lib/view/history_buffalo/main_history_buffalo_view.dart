import 'dart:convert';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';

class MainHistoryBuffaloView extends StatefulWidget {
  const MainHistoryBuffaloView({super.key});

  @override
  State<MainHistoryBuffaloView> createState() => _MainHistoryBuffaloViewState();
}

class _MainHistoryBuffaloViewState extends State<MainHistoryBuffaloView> {
  late Future<List<BuffaloModel>> futureBuffaloes;

  @override
  void initState() {
    super.initState();
    futureBuffaloes = fetchBuffaloes();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, size: 35),
                ),
              ],
            ),
            const SizedBox(height: 40),
            StrokeText(
              text: "ประวัติควายไทย",
              textStyle: TextStyle(
                  fontSize: ScreenUtils.calculateFontSize(context, 30),
                  color: Colors.red),
              strokeColor: Colors.white,
              strokeWidth: 6,
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: screenWidth / 1.5,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red,
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.white,
                    hintText: 'ค้นหา',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
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
                      return const Center(child: Text('No buffaloes found.'));
                    }

                    final buffaloes = snapshot.data!;

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: buffaloes.length,
                      itemBuilder: (context, index) {
                        final buffalo = buffaloes[index];
                        return InkWell(
                          onTap: () {
                            Provider.of<SelectedBuffalo>(context, listen: false)
                                .setSelectedBuffalo(buffalo.name); // Assuming 'name' is a property in BuffaloModel
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
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.asset(
                                    'assets/images/banner-1.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              StrokeText(
                                text: buffalo.name, // Assuming 'name' is a property in BuffaloModel
                                textStyle: TextStyle(
                                  fontSize: ScreenUtils.calculateFontSize(context, 12),
                                  color: Colors.white,
                                ),
                                strokeColor: Colors.black,
                                strokeWidth: 3,
                              ),
                            ],
                          ),
                        );
                      },
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
