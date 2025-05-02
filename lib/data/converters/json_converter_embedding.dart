import 'package:drift/drift.dart';
import 'dart:convert';

class JsonConverterEmbedding extends TypeConverter<List<double>, String> {
  const JsonConverterEmbedding();

  @override
  List<double> fromSql(String fromDb) {
    return (json.decode(fromDb) as List<dynamic>).cast<double>().toList();
  }

  @override
  String toSql(List<double> value) {
    return json.encode(value);
  }
}
