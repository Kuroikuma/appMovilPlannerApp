import 'package:drift/drift.dart';

enum TipoAccionesSync { post, update, delete }

class TipoAccionesSyncConverter
    extends TypeConverter<TipoAccionesSync, String> {
  const TipoAccionesSyncConverter();

  @override
  TipoAccionesSync fromSql(String fromDb) {
    switch (fromDb) {
      case 'post':
        return TipoAccionesSync.post;
      case 'update':
        return TipoAccionesSync.update;
      case 'delete':
        return TipoAccionesSync.delete;
      default:
        return TipoAccionesSync.post;
    }
  }

  @override
  String toSql(TipoAccionesSync value) {
    return value.toString().split('.').last;
  }
}
