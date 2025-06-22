import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FarmCard extends StatelessWidget {
  const FarmCard({
    required this.region,
    required this.farms,
    required this.screenWidth,
    required this.screenHeight,
    required this.onMorePressed,
    super.key,
  });
  final String region;
  final List<String> farms;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onMorePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white.withAlpha((0.6 * 255).round()),
        child: SizedBox(
          width: screenWidth / 2.4,
          height: screenHeight * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      region,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 10,
                      maxFontSize: 18,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.15,
                child: ListView.builder(
                  itemCount: farms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('${index + 1} ${farms[index]}'),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: onMorePressed,
                      child: const Text('เพิ่มเติม (More) >>>'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
