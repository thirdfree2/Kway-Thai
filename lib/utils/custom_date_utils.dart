class CustomDateUtils {
  /// ✅ แปลง string พ.ศ. (เช่น '2537-11-21') เป็น DateTime ค.ศ.
  static DateTime parseBuddhistIso(String input) {
    final parts = input.split('-');
    final buddhistYear = int.parse(parts[0]);
    final year = buddhistYear - 543;
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  /// ✅ แปลง DateTime เป็นรูปแบบภาษาไทย + พ.ศ. เช่น '21 พฤศจิกายน 2537'
  static String formatDateToBuddhist(DateTime date) {
    final thaiMonths = [
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม',
    ];

    final day = date.day;
    final month = thaiMonths[date.month - 1];
    final buddhistYear = date.year + 543;

    return '$day $month $buddhistYear';
  }

  /// ✅ คำนวณอายุจากวันเกิด (DateTime) เป็น: 1 ปี 7 เดือน / 5 เดือน / 2 สัปดาห์ ฯลฯ
  static String calculateAgeInDetail(DateTime birthDate) {
    final now = DateTime.now();

    // ✅ ถ้า birthDate.year > 2500 → ถือว่าเป็น พ.ศ. ต้องแปลงเป็น ค.ศ.
    if (birthDate.year > 2500) {
      birthDate =
          DateTime(birthDate.year - 543, birthDate.month, birthDate.day);
    }

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months--;
      final previousMonth = DateTime(now.year, now.month, 0);
      days += previousMonth.day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    int weeks = days ~/ 7;

    List<String> parts = [];

    if (years > 0) parts.add('$years ปี (Year)');
    if (months > 0) parts.add('$months เดือน (Month)');
    if (weeks > 0 && years == 0) parts.add('$weeks สัปดาห์ (Week)');

    if (parts.isEmpty) return 'น้อยกว่า 1 สัปดาห์ (Less than a week)';
    return parts.join(' ');
  }
}
