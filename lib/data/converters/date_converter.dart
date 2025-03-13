import 'package:drift/drift.dart';

class DateConverter extends TypeConverter<DateTime, String> {
  const DateConverter();

  @override
  DateTime fromSql(String fromDb) {
    return DateTime.parse(fromDb);
  }

  @override
  String toSql(DateTime value) {
    return value.toIso8601String().substring(0, 10);
  }
}
