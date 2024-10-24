import 'package:buffalo_thai/view/awards_announcement/main_awards_view.dart';
import 'package:buffalo_thai/view/promote_buffalo/award_promote_buffalo.dart';
import 'package:buffalo_thai/view/promote_buffalo/main_promote_buffalo_view.dart';
import 'package:buffalo_thai/view/promote_buffalo/photo_promote_buffalo_view.dart';
import 'package:buffalo_thai/view/promote_buffalo/video_promote_buffalo_view.dart';
import 'package:flutter/material.dart';

class PromoteBuffalo extends StatefulWidget {
  const PromoteBuffalo({super.key});

  @override
  State<PromoteBuffalo> createState() => _PromoteBuffaloState();
}

class _PromoteBuffaloState extends State<PromoteBuffalo> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainPromoteBuffaloView(),
    Text('Genetics',
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
    PromotePhotoBuffaloView(),
    PromoteVideoBuffaloView(),
    MainPromoteAwardsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              opacity: 0.7,
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
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
        SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ],
    );
  }
}
