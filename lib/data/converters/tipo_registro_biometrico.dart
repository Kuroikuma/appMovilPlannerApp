import 'package:drift/drift.dart';

enum TipoRegistroBiometrico { face, huella, otro }

class TipoRegistroBiometricoConverter
    extends TypeConverter<TipoRegistroBiometrico, String> {
  const TipoRegistroBiometricoConverter();

  @override
  TipoRegistroBiometrico fromSql(String fromDb) {
    switch (fromDb) {
      case 'face':
        return TipoRegistroBiometrico.face;
      case 'huella':
        return TipoRegistroBiometrico.huella;
      default:
        return TipoRegistroBiometrico.otro;
    }
  }

  @override
  String toSql(TipoRegistroBiometrico value) {
    return value.toString().split('.').last;
  }
}
