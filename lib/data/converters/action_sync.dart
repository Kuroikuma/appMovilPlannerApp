import 'package:drift/drift.dart';

enum TipoAccionesSync { create, update, delete }

class TipoAccionesSyncConverter
    extends TypeConverter<TipoAccionesSync, String> {
  const TipoAccionesSyncConverter();

  @override
  TipoAccionesSync fromSql(String fromDb) {
    switch (fromDb) {
      case 'CREATE':
        return TipoAccionesSync.create;
      case 'UPDATE':
        return TipoAccionesSync.update;
      case 'DELETE':
        return TipoAccionesSync.delete;
      default:
        return TipoAccionesSync.create;
    }
  }

  @override
  String toSql(TipoAccionesSync value) {
    return value.toString().split('.').last;
  }
}
