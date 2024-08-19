import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/utils/cache_manager.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

class PhotoBuffaloView extends StatefulWidget {
  const PhotoBuffaloView({super.key});

  @override
  State<PhotoBuffaloView> createState() => _PhotoBuffaloViewState();
}

class _PhotoBuffaloViewState extends State<PhotoBuffaloView> {
  @override
  Widget build(BuildContext context) {
    final selectedBuffalo = Provider.of<SelectedBuffalo>(context);
    final buffaloNames = selectedBuffalo.buffalo;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: StrokeText(
                    text: 'buffaloNames',
                    textStyle: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 14),
                      color: Colors.black,
                    ),
                    strokeColor: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GalleryImage(
                    numOfShowImages: 12,
                    imageUrls: const [
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
                      "https://static.trueplookpanya.com/tppy/member/m_910000_912500/912272/cms/images/1_%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A2.jpg",
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
