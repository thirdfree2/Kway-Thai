import 'package:buffalo_thai/view/splash/main_splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buffalo_thai/providers/farm_data.dart';
import 'package:buffalo_thai/providers/selected_farm.dart';
import 'package:buffalo_thai/providers/selected_region.dart';
import 'package:buffalo_thai/providers/selected_buffalo.dart';
import 'package:buffalo_thai/providers/selected_farm_owner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedRegion()),
        ChangeNotifierProvider(create: (_) => SelectedFarm()),
        ChangeNotifierProvider(create: (_) => SelectedBuffalo()),
        ChangeNotifierProvider(create: (_) => SelectedFarmOwner()),
        ChangeNotifierProvider(create: (_) => FarmDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('th', 'TH'),
      ],
      title: 'Kway Thai',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.chonburiTextTheme(textTheme),
      ),
      home: const MainSplashView(),
    );
  }
}
