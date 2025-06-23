class CustomDateUtils {
  static String calculateAgeInDetail(DateTime birthDate) {
    final now = DateTime.now();

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    // ปรับวันที่
    if (days < 0) {
      months--;
      final previousMonth = DateTime(now.year, now.month, 0);
      days += previousMonth.day;
    }

    // ปรับเดือน
    if (months < 0) {
      years--;
      months += 12;
    }

    int weeks = days ~/ 7;

    // ✅ แสดงเฉพาะหน่วยใหญ่ที่สุด
    if (years > 0) return '$years ปี (Year)';
    if (months > 0) return '$months เดือน (Mouth)';
    if (weeks > 0) return '$weeks สัปดาห์ (Week)';

    return 'น้อยกว่า 1 สัปดาห์ (Less than a week)';
  }
}
