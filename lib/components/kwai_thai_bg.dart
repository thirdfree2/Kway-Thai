import 'package:flutter/material.dart';

class KwaiThaiBg extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final PreferredSizeWidget? appBar;
  final bool? customeBg;

  const KwaiThaiBg({
    super.key,
    required this.child,
    this.showAppBar = false,
    this.appBar,
    this.customeBg,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: showAppBar ? appBar : null,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              opacity: 0.8,
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}
