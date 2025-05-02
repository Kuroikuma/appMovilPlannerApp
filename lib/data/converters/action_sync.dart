import 'package:drift/drift.dart';

enum TipoAccionesSync { create, update, delete }

class TipoAccionesSyncConverter
    extends TypeConverter<TipoAccionesSync, String> {
  const TipoAccionesSyncConverter();

  @override
  TipoAccionesSync fromSql(String fromDb) {
    switch (fromDb) {
      case 'create':
        return TipoAccionesSync.create;
      case 'update':
        return TipoAccionesSync.update;
      case 'delete':
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
