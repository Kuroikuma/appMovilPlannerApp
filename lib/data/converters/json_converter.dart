import 'package:drift/drift.dart';
import 'dart:convert';

class JsonConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    return json.decode(fromDb);
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return json.encode(value);
  }
}
