import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DatetimeHelper {
  DateTime _datetime;

  DatetimeHelper(this._datetime);

  String ToString(String pattern) {
    var formatter = DateFormat(pattern);
    return formatter.format(_datetime);
  }

  String ToDateString() {
    var formatter = DateFormat.yMd();
    return formatter.format(_datetime);
  }

  String ToBRDateString() {
    initializeDateFormatting('pt_BR', null);
    var formatter = DateFormat.yMd('pt_BR');
    return formatter.format(_datetime);
  }

}
