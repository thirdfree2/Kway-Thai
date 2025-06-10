import 'package:buffalo_thai/components/label_value_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoItem {
  final String label;
  final Object value;
  final LabelValueType type;

  InfoItem({
    required this.label,
    required this.value,
    this.type = LabelValueType.text,
  });
}

class InfoSection extends StatelessWidget {
  final String? title;
  final List<InfoItem> items;

  const InfoSection({
    super.key,
    this.title,
    required this.items,
  });

  String _formatThaiDate(DateTime date) {
    try {
      return DateFormat('dd MMM yyyy', 'th').format(
        DateTime(date.year + 543, date.month, date.day),
      );
    } catch (_) {
      return 'ไม่พบวันที่';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
          ],
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: RichText(
                text: TextSpan(
                  text: '${item.label}: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: item.type == LabelValueType.date
                          ? (item.value is DateTime
                              ? _formatThaiDate(item.value as DateTime)
                              : 'ไม่พบวันที่')
                          : item.value.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
