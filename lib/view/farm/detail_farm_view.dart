import 'package:auto_size_text/auto_size_text.dart';
import 'package:buffalo_thai/model/buffalo_image_model.dart';
import 'package:buffalo_thai/model/user_model.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';
import 'package:buffalo_thai/services/user_services.dart';
import 'package:buffalo_thai/utils/api_utils.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_wrapper.dart';
import 'package:buffalo_thai/view/farm_owner/main_farm_owner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:buffalo_thai/model/buffalo_model.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/services/buffalo_services.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/farm_owner/register_buffalo.dart';
import 'package:buffalo_thai/view/farm_owner/register_farm_owner.dart';

class DetailFarmView extends StatefulWidget {
  const DetailFarmView({super.key});

  @override
  State<DetailFarmView> createState() => _DetailFarmViewState();
}

class _DetailFarmViewState extends State<DetailFarmView> {
  late Future<List<BuffaloModel>> futureBuffaloes;
  late Future<List<UserModel>> futureUser;

  @override
  void initState() {
    super.initState();
    final selectedFarm = Provider.of<SelectedFarm>(context, listen: false);
    futureBuffaloes = fetchBuffaloesByFarmId(selectedFarm.farmId);
    futureUser = fetchUserByFarmId(selectedFarm.farmId);
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
            StrokeText(
              text: farmNames,
              textStyle: TextStyle(
                fontSize: ScreenUtils.calculateFontSize(context, 20),
                color: Colors.red,
              ),
              strokeColor: Colors.white,
              strokeWidth: 6,
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
                      return const Center(child: Text('No buffaloes found.'));
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
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                      text: user.firstName,
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
                      return const Center(child: Text('No buffaloes found.'));
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
