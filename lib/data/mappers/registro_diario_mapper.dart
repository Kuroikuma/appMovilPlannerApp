import 'package:flutter_application_1/data/database.dart';

import '../../domain/models/registro_diario.dart';

class RegistroDiarioMapper {
  static RegistrosDiario toDataModel(RegistroDiario entity) {
    return RegistrosDiario(
        id: entity.id!,
        equipoId: entity.equipoId,
        fechaIngreso: entity.fechaIngreso,
        horaIngreso: entity.horaIngreso,
        fechaSalida: entity.fechaSalida!,
        horaSalida: entity.horaSalida!,
        finLabores: entity.finLabores!,
        iniciaLabores: entity.iniciaLabores!,
        reconocimientoFacialId: entity.reconocimientoFacialId,
        registroId: entity.registroId,
        estado: entity.estado,
        nombreTrabajador: entity.nombreTrabajador!,
        fotoTrabajador: entity.fotoTrabajador!,
        cargoTrabajador: entity.cargoTrabajador!,
        horarioId: entity.horarioId,
      );
  }

}

// Crear mappers similares para cada entidad
