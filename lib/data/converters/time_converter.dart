import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class TimeOfDayConverter extends TypeConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromSql(String fromDb) {
    if (fromDb.isEmpty) return const TimeOfDay(hour: 0, minute: 0);
    final parts = fromDb.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toSql(TimeOfDay value) {
    return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
}
