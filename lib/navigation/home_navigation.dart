import 'package:buffalo_thai/view/farm/main_farm_view.dart';
import 'package:buffalo_thai/view/heredity_buffalo/main_heredity_buffalo_view.dart';
import 'package:buffalo_thai/view/history_buffalo/main_history_buffalo_view.dart';
import 'package:buffalo_thai/view/home/main_home_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      onGenerateRoute: (RouteSettings setting) {
        return MaterialPageRoute(
          settings: setting,
          builder: (BuildContext context) {
            if (setting.name == '/farm') {
              return FarmView();
            }
            if (setting.name == '/buffHistory') {
              return MainHistoryBuffaloView();
            }
            if (setting.name == '/buffHeredity') {
              return MainHeredityBuffaloView();
            }
            else {
              return HomeView();
            }
          },
        );
      },
    );
  }
}
