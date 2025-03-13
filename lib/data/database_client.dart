import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'database.dart';

class DatabaseClient {
  static AppDatabase? _database;

  static Future<AppDatabase> get database async {
    if (_database != null) return _database!;

    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'database.sqlite');
    _database = AppDatabase(
      LazyDatabase(() async => NativeDatabase.createInBackground(File(dbPath))),
    );
    return _database!;
  }
}
