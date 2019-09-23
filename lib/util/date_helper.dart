import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  String myDate(int timestamp) {
    const locale = "fr_FR";
    initializeDateFormatting();

    DateTime now = DateTime.now();
    DateTime timePost = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;

    if (now.difference(timePost).inDays > 0) {
      format = new DateFormat.yMMMd(locale);
    } else {
      format = new DateFormat.Hm(locale);
    }

    return format.format(timePost).toString();
  }
}
