import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum LabelValueType { text, date }

class LabelValueText extends StatelessWidget {
  const LabelValueText({
    super.key,
    required this.label,
    required this.value,
    this.type = LabelValueType.text,
  });
  final String label;
  final Object value;
  final LabelValueType type;

  String _formatThaiDate(DateTime dateStr) {
    try {
      return DateFormat('dd MMM yyyy', 'th').format(
        DateTime(dateStr.year + 543, dateStr.month, dateStr.day),
      );
    } catch (_) {
      return "ไม่พบวันที่";
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = switch (type) {
      LabelValueType.text => value.toString(),
      LabelValueType.date =>
        value is DateTime ? _formatThaiDate(value as DateTime) : "ไม่พบวันที่"
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: displayValue,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
