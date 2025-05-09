import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class FormatTime {
  static String formatTime(Timestamp? timestamp) {
    if (timestamp == null) return '';

    try {
      DateTime dateTime = timestamp.toDate();
      DateTime now = DateTime.now();
      Duration diff = now.difference(dateTime);

      final timeString = DateFormat('h:mm a', 'ar').format(dateTime);

      if (diff.inHours < 24 && now.day == dateTime.day) {
        return 'اليوم، $timeString';
      } else if (diff.inDays == 1) {
        return 'أمس، $timeString';
      } else if (diff.inDays < 7) {
        String day = DateFormat('EEEE', 'ar').format(dateTime);
        return '$day، $timeString';
      } else {
        String date = DateFormat('d/M/y').format(dateTime); // ← هنا التغيير
        return '$date، $timeString';
      }
    } catch (e) {
      print('Error formatting time: $e');
      return '';
    }
  }
}
