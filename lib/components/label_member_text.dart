import 'package:flutter/material.dart';

class LabeledTextRow extends StatelessWidget {
  const LabeledTextRow({
    super.key,
    required this.labelTh,
    required this.labelEn,
    required this.value,
    this.fontSize = 18,
  });
  final String labelTh;
  final String labelEn;
  final String value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelTh,
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              labelEn,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            ': $value',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
