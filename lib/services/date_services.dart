import 'package:jiffy/jiffy.dart';

class DateServices {
  static String getDate() {
    return Jiffy.now().MMMEd;
  }

  static String getMorningOrEvening() {
    final hour = Jiffy.now().hour;
    return hour < 12
        ? 'Good Morning 👋🏿'
        : hour > 5
            ? 'Good Afternoon 👋🏿'
            : 'Good Evening 👋🏿';
  }
}
