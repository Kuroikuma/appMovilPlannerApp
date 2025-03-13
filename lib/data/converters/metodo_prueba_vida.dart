import 'package:drift/drift.dart';

enum MetodoPruebaVida { face, huella, otro }

class MetodoPruebaVidaConverter
    extends TypeConverter<MetodoPruebaVida, String> {
  const MetodoPruebaVidaConverter();

  @override
  MetodoPruebaVida fromSql(String fromDb) {
    switch (fromDb) {
      case 'face':
        return MetodoPruebaVida.face;
      case 'huella':
        return MetodoPruebaVida.huella;
      default:
        return MetodoPruebaVida.otro;
    }
  }

  @override
  String toSql(MetodoPruebaVida value) {
    return value.toString().split('.').last;
  }
}
