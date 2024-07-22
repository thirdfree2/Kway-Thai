import 'package:flutter/material.dart';

class ScreenUtils {
  static double calculateFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return baseSize * (screenWidth / (isLandscape ? 720 : 360));
  }
}