import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

class DateConverter extends TypeConverter<DateTime, String> {
  const DateConverter();

  static final DateFormat _format = DateFormat('M/d/yyyy h:mm:ss a');

  DateTime fromSqlFormat(String dateStr) {
    return _format.parse(dateStr);
  }

  @override
  DateTime fromSql(String fromDb) {
    return DateTime.parse(fromDb);
  }

  @override
  String toSql(DateTime value) {
    return value.toIso8601String().substring(0, 10);
  }
}
