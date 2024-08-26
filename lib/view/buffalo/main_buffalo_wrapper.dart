import 'package:buffalo_thai/view/awards_announcement/main_awards_view.dart';
import 'package:buffalo_thai/view/buffalo/main_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/photo_buffalo_view.dart';
import 'package:buffalo_thai/view/buffalo/video_buffalo_view.dart';
import 'package:flutter/material.dart';

class Buffalo extends StatefulWidget {
  const Buffalo({super.key});

  @override
  State<Buffalo> createState() => _BuffaloState();
}

class _BuffaloState extends State<Buffalo> {
  int _selectedIndex = 0;
  

  static const List<Widget> _widgetOptions = <Widget>[
    MainBuffaloView(),
    Text('Genetics',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    PhotoBuffaloView(),
    VideoBuffaloView(),
    MainAwardsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _customIcon(Icons.home, 'หน้าแรก'),
              label: '',
              backgroundColor: Colors.green[900]),
          BottomNavigationBarItem(
              icon: _customIcon(Icons.share, 'พันธุกรรม'),
              label: '',
              backgroundColor: Colors.green[900]),
          BottomNavigationBarItem(
              icon: _customIcon(Icons.photo, 'รูปภาพที่เกี่ยวข้อง'),
              label: '',
              backgroundColor: Colors.green[900]),
          BottomNavigationBarItem(
              icon: _customIcon(Icons.video_collection, 'วิดีโอที่เกี่ยวข้อง'),
              label: '',
              backgroundColor: Colors.green[900]),
          BottomNavigationBarItem(
              icon: _customIcon(Icons.star, 'รางวัลประกวด'),
              label: '',
              backgroundColor: Colors.green[900]),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[900],
        onTap: _onItemTapped,
        elevation: 0,
      ),
    );
  }

  Widget _customIcon(IconData iconData, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            iconData,
            size: 24,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5,),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ],
    );
  }
}
