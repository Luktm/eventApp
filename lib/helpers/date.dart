import 'package:intl/intl.dart';

class Date {
  final double tableRowSizedBoxHeight = 30;

  static final DateTime now = DateTime.now();
  static final String formattedDate = DateFormat('dd MMM yyyy').format(now);


  static final int weekdayInt = now.weekday;

  static String weekday() {
    switch (weekdayInt) {
      case 1:
        return 'Mon';
        break;
      case 2:
        return 'Tue';
        break;
      case 3:
        return 'Wed';
        break;
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
        break;
      default:
        return 'No Day';
    }
  }

  
}
