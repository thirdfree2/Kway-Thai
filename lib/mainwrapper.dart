import 'package:buffalo_thai/navigation/home_navigation.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.green[900],),
            icon: Icon(Icons.home_outlined, color: Colors.green[900],),
            label: 'หน้ารัก',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history, color: Colors.green[900]),
            icon: Icon(Icons.history, color: Colors.green[900]),
            label: 'ประวัติ',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.share, color: Colors.green[900]),
            icon: Icon(Icons.share, color: Colors.green[900]),
            label: 'แชร์',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings, color: Colors.green[900]),
            icon: Icon(Icons.settings, color: Colors.green[900]),
            label: 'ตั้งค่า',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings, color: Colors.green[900]),
            icon: Icon(Icons.settings, color: Colors.green[900]),
            label: 'ตั้งค่า',
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            Home(),
            Home(),
            Home(),
            Home(),
            Home()
          ],
        ),
      ),
    );
  }
}
