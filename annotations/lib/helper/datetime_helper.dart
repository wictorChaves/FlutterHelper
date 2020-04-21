import 'package:intl/intl.dart';

class DatetimeHelper {
  DateTime _datetime;

  DatetimeHelper(this._datetime);

  String ToString(String pattern) {
    var formatter = DateFormat(pattern);
    return formatter.format(_datetime);
  }

  String ToBRDateString() {
    return ToString("dd/MM/yyyy");
  }

}
