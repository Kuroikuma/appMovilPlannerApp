// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TrabajadoresTable extends Trabajadores
    with TableInfo<$TrabajadoresTable, Trabajadore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajadoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primerApellidoMeta = const VerificationMeta(
    'primerApellido',
  );
  @override
  late final GeneratedColumn<String> primerApellido = GeneratedColumn<String>(
    'primer_apellido',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segundoApellidoMeta = const VerificationMeta(
    'segundoApellido',
  );
  @override
  late final GeneratedColumn<String> segundoApellido = GeneratedColumn<String>(
    'segundo_apellido',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipoIdMeta = const VerificationMeta(
    'equipoId',
  );
  @override
  late final GeneratedColumn<int> equipoId = GeneratedColumn<int>(
    'equipo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    primerApellido,
    segundoApellido,
    equipoId,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajadores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trabajadore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('primer_apellido')) {
      context.handle(
        _primerApellidoMeta,
        primerApellido.isAcceptableOrUnknown(
          data['primer_apellido']!,
          _primerApellidoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primerApellidoMeta);
    }
    if (data.containsKey('segundo_apellido')) {
      context.handle(
        _segundoApellidoMeta,
        segundoApellido.isAcceptableOrUnknown(
          data['segundo_apellido']!,
          _segundoApellidoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_segundoApellidoMeta);
    }
    if (data.containsKey('equipo_id')) {
      context.handle(
        _equipoIdMeta,
        equipoId.isAcceptableOrUnknown(data['equipo_id']!, _equipoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_equipoIdMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trabajadore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trabajadore(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nombre:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nombre'],
          )!,
      primerApellido:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}primer_apellido'],
          )!,
      segundoApellido:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}segundo_apellido'],
          )!,
      equipoId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}equipo_id'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $TrabajadoresTable createAlias(String alias) {
    return $TrabajadoresTable(attachedDatabase, alias);
  }
}

class Trabajadore extends DataClass implements Insertable<Trabajadore> {
  final int id;
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final int equipoId;
  final bool estado;
  const Trabajadore({
    required this.id,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.equipoId,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['primer_apellido'] = Variable<String>(primerApellido);
    map['segundo_apellido'] = Variable<String>(segundoApellido);
    map['equipo_id'] = Variable<int>(equipoId);
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  TrabajadoresCompanion toCompanion(bool nullToAbsent) {
    return TrabajadoresCompanion(
      id: Value(id),
      nombre: Value(nombre),
      primerApellido: Value(primerApellido),
      segundoApellido: Value(segundoApellido),
      equipoId: Value(equipoId),
      estado: Value(estado),
    );
  }

  factory Trabajadore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trabajadore(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      primerApellido: serializer.fromJson<String>(json['primerApellido']),
      segundoApellido: serializer.fromJson<String>(json['segundoApellido']),
      equipoId: serializer.fromJson<int>(json['equipoId']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'primerApellido': serializer.toJson<String>(primerApellido),
      'segundoApellido': serializer.toJson<String>(segundoApellido),
      'equipoId': serializer.toJson<int>(equipoId),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  Trabajadore copyWith({
    int? id,
    String? nombre,
    String? primerApellido,
    String? segundoApellido,
    int? equipoId,
    bool? estado,
  }) => Trabajadore(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    primerApellido: primerApellido ?? this.primerApellido,
    segundoApellido: segundoApellido ?? this.segundoApellido,
    equipoId: equipoId ?? this.equipoId,
    estado: estado ?? this.estado,
  );
  Trabajadore copyWithCompanion(TrabajadoresCompanion data) {
    return Trabajadore(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      primerApellido:
          data.primerApellido.present
              ? data.primerApellido.value
              : this.primerApellido,
      segundoApellido:
          data.segundoApellido.present
              ? data.segundoApellido.value
              : this.segundoApellido,
      equipoId: data.equipoId.present ? data.equipoId.value : this.equipoId,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajadore(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('primerApellido: $primerApellido, ')
          ..write('segundoApellido: $segundoApellido, ')
          ..write('equipoId: $equipoId, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    primerApellido,
    segundoApellido,
    equipoId,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajadore &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.primerApellido == this.primerApellido &&
          other.segundoApellido == this.segundoApellido &&
          other.equipoId == this.equipoId &&
          other.estado == this.estado);
}

class TrabajadoresCompanion extends UpdateCompanion<Trabajadore> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> primerApellido;
  final Value<String> segundoApellido;
  final Value<int> equipoId;
  final Value<bool> estado;
  const TrabajadoresCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.primerApellido = const Value.absent(),
    this.segundoApellido = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.estado = const Value.absent(),
  });
  TrabajadoresCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String primerApellido,
    required String segundoApellido,
    required int equipoId,
    this.estado = const Value.absent(),
  }) : nombre = Value(nombre),
       primerApellido = Value(primerApellido),
       segundoApellido = Value(segundoApellido),
       equipoId = Value(equipoId);
  static Insertable<Trabajadore> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? primerApellido,
    Expression<String>? segundoApellido,
    Expression<int>? equipoId,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (primerApellido != null) 'primer_apellido': primerApellido,
      if (segundoApellido != null) 'segundo_apellido': segundoApellido,
      if (equipoId != null) 'equipo_id': equipoId,
      if (estado != null) 'estado': estado,
    });
  }

  TrabajadoresCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? primerApellido,
    Value<String>? segundoApellido,
    Value<int>? equipoId,
    Value<bool>? estado,
  }) {
    return TrabajadoresCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      primerApellido: primerApellido ?? this.primerApellido,
      segundoApellido: segundoApellido ?? this.segundoApellido,
      equipoId: equipoId ?? this.equipoId,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (primerApellido.present) {
      map['primer_apellido'] = Variable<String>(primerApellido.value);
    }
    if (segundoApellido.present) {
      map['segundo_apellido'] = Variable<String>(segundoApellido.value);
    }
    if (equipoId.present) {
      map['equipo_id'] = Variable<int>(equipoId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajadoresCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('primerApellido: $primerApellido, ')
          ..write('segundoApellido: $segundoApellido, ')
          ..write('equipoId: $equipoId, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $GruposUbicacionesTable extends GruposUbicaciones
    with TableInfo<$GruposUbicacionesTable, GruposUbicacione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GruposUbicacionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, estado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grupos_ubicaciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<GruposUbicacione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GruposUbicacione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GruposUbicacione(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nombre:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nombre'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $GruposUbicacionesTable createAlias(String alias) {
    return $GruposUbicacionesTable(attachedDatabase, alias);
  }
}

class GruposUbicacione extends DataClass
    implements Insertable<GruposUbicacione> {
  final int id;
  final String nombre;
  final bool estado;
  const GruposUbicacione({
    required this.id,
    required this.nombre,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  GruposUbicacionesCompanion toCompanion(bool nullToAbsent) {
    return GruposUbicacionesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      estado: Value(estado),
    );
  }

  factory GruposUbicacione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GruposUbicacione(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  GruposUbicacione copyWith({int? id, String? nombre, bool? estado}) =>
      GruposUbicacione(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        estado: estado ?? this.estado,
      );
  GruposUbicacione copyWithCompanion(GruposUbicacionesCompanion data) {
    return GruposUbicacione(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GruposUbicacione(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GruposUbicacione &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.estado == this.estado);
}

class GruposUbicacionesCompanion extends UpdateCompanion<GruposUbicacione> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<bool> estado;
  const GruposUbicacionesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.estado = const Value.absent(),
  });
  GruposUbicacionesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.estado = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<GruposUbicacione> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (estado != null) 'estado': estado,
    });
  }

  GruposUbicacionesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<bool>? estado,
  }) {
    return GruposUbicacionesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GruposUbicacionesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $UbicacionesTable extends Ubicaciones
    with TableInfo<$UbicacionesTable, Ubicacione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UbicacionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ubicacionIdMeta = const VerificationMeta(
    'ubicacionId',
  );
  @override
  late final GeneratedColumn<int> ubicacionId = GeneratedColumn<int>(
    'ubicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, ubicacionId, estado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ubicaciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ubicacione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('ubicacion_id')) {
      context.handle(
        _ubicacionIdMeta,
        ubicacionId.isAcceptableOrUnknown(
          data['ubicacion_id']!,
          _ubicacionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ubicacionIdMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Ubicacione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ubicacione(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      nombre:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nombre'],
          )!,
      ubicacionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ubicacion_id'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $UbicacionesTable createAlias(String alias) {
    return $UbicacionesTable(attachedDatabase, alias);
  }
}

class Ubicacione extends DataClass implements Insertable<Ubicacione> {
  final String id;
  final String nombre;
  final int ubicacionId;
  final bool estado;
  const Ubicacione({
    required this.id,
    required this.nombre,
    required this.ubicacionId,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['ubicacion_id'] = Variable<int>(ubicacionId);
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  UbicacionesCompanion toCompanion(bool nullToAbsent) {
    return UbicacionesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      ubicacionId: Value(ubicacionId),
      estado: Value(estado),
    );
  }

  factory Ubicacione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ubicacione(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      ubicacionId: serializer.fromJson<int>(json['ubicacionId']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'ubicacionId': serializer.toJson<int>(ubicacionId),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  Ubicacione copyWith({
    String? id,
    String? nombre,
    int? ubicacionId,
    bool? estado,
  }) => Ubicacione(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    ubicacionId: ubicacionId ?? this.ubicacionId,
    estado: estado ?? this.estado,
  );
  Ubicacione copyWithCompanion(UbicacionesCompanion data) {
    return Ubicacione(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      ubicacionId:
          data.ubicacionId.present ? data.ubicacionId.value : this.ubicacionId,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ubicacione(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('ubicacionId: $ubicacionId, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, ubicacionId, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ubicacione &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.ubicacionId == this.ubicacionId &&
          other.estado == this.estado);
}

class UbicacionesCompanion extends UpdateCompanion<Ubicacione> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<int> ubicacionId;
  final Value<bool> estado;
  final Value<int> rowid;
  const UbicacionesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.ubicacionId = const Value.absent(),
    this.estado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UbicacionesCompanion.insert({
    required String id,
    required String nombre,
    required int ubicacionId,
    this.estado = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       ubicacionId = Value(ubicacionId);
  static Insertable<Ubicacione> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<int>? ubicacionId,
    Expression<bool>? estado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (ubicacionId != null) 'ubicacion_id': ubicacionId,
      if (estado != null) 'estado': estado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UbicacionesCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<int>? ubicacionId,
    Value<bool>? estado,
    Value<int>? rowid,
  }) {
    return UbicacionesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      ubicacionId: ubicacionId ?? this.ubicacionId,
      estado: estado ?? this.estado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (ubicacionId.present) {
      map['ubicacion_id'] = Variable<int>(ubicacionId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UbicacionesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('ubicacionId: $ubicacionId, ')
          ..write('estado: $estado, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HorariosTable extends Horarios with TableInfo<$HorariosTable, Horario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HorariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ubicacionIdMeta = const VerificationMeta(
    'ubicacionId',
  );
  @override
  late final GeneratedColumn<int> ubicacionId = GeneratedColumn<int>(
    'ubicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ubicaciones (ubicacion_id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> fechaInicio =
      GeneratedColumn<String>(
        'fecha_inicio',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($HorariosTable.$converterfechaInicio);
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> fechaFin =
      GeneratedColumn<String>(
        'fecha_fin',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($HorariosTable.$converterfechaFin);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> horaInicio =
      GeneratedColumn<String>(
        'hora_inicio',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($HorariosTable.$converterhoraInicio);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> horaFin =
      GeneratedColumn<String>(
        'hora_fin',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($HorariosTable.$converterhoraFin);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _pagaAlmuerzoMeta = const VerificationMeta(
    'pagaAlmuerzo',
  );
  @override
  late final GeneratedColumn<bool> pagaAlmuerzo = GeneratedColumn<bool>(
    'paga_almuerzo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("paga_almuerzo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String>
  inicioDescanso = GeneratedColumn<String>(
    'inicio_descanso',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<TimeOfDay>($HorariosTable.$converterinicioDescanso);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> finDescanso =
      GeneratedColumn<String>(
        'fin_descanso',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($HorariosTable.$converterfinDescanso);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ubicacionId,
    fechaInicio,
    fechaFin,
    horaInicio,
    horaFin,
    estado,
    pagaAlmuerzo,
    inicioDescanso,
    finDescanso,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'horarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Horario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ubicacion_id')) {
      context.handle(
        _ubicacionIdMeta,
        ubicacionId.isAcceptableOrUnknown(
          data['ubicacion_id']!,
          _ubicacionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ubicacionIdMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('paga_almuerzo')) {
      context.handle(
        _pagaAlmuerzoMeta,
        pagaAlmuerzo.isAcceptableOrUnknown(
          data['paga_almuerzo']!,
          _pagaAlmuerzoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Horario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Horario(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ubicacionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ubicacion_id'],
          )!,
      fechaInicio: $HorariosTable.$converterfechaInicio.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fecha_inicio'],
        )!,
      ),
      fechaFin: $HorariosTable.$converterfechaFin.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fecha_fin'],
        )!,
      ),
      horaInicio: $HorariosTable.$converterhoraInicio.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hora_inicio'],
        )!,
      ),
      horaFin: $HorariosTable.$converterhoraFin.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hora_fin'],
        )!,
      ),
      inicioDescanso: $HorariosTable.$converterinicioDescanso.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}inicio_descanso'],
        )!,
      ),
      finDescanso: $HorariosTable.$converterfinDescanso.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fin_descanso'],
        )!,
      ),
      pagaAlmuerzo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}paga_almuerzo'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $HorariosTable createAlias(String alias) {
    return $HorariosTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, String> $converterfechaInicio =
      const DateConverter();
  static TypeConverter<DateTime, String> $converterfechaFin =
      const DateConverter();
  static TypeConverter<TimeOfDay, String> $converterhoraInicio =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDay, String> $converterhoraFin =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDay, String> $converterinicioDescanso =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDay, String> $converterfinDescanso =
      const TimeOfDayConverter();
}

class HorariosCompanion extends UpdateCompanion<Horario> {
  final Value<int> id;
  final Value<int> ubicacionId;
  final Value<DateTime> fechaInicio;
  final Value<DateTime> fechaFin;
  final Value<TimeOfDay> horaInicio;
  final Value<TimeOfDay> horaFin;
  final Value<bool> estado;
  final Value<bool> pagaAlmuerzo;
  final Value<TimeOfDay> inicioDescanso;
  final Value<TimeOfDay> finDescanso;
  const HorariosCompanion({
    this.id = const Value.absent(),
    this.ubicacionId = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.fechaFin = const Value.absent(),
    this.horaInicio = const Value.absent(),
    this.horaFin = const Value.absent(),
    this.estado = const Value.absent(),
    this.pagaAlmuerzo = const Value.absent(),
    this.inicioDescanso = const Value.absent(),
    this.finDescanso = const Value.absent(),
  });
  HorariosCompanion.insert({
    this.id = const Value.absent(),
    required int ubicacionId,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    required TimeOfDay horaInicio,
    required TimeOfDay horaFin,
    this.estado = const Value.absent(),
    this.pagaAlmuerzo = const Value.absent(),
    required TimeOfDay inicioDescanso,
    required TimeOfDay finDescanso,
  }) : ubicacionId = Value(ubicacionId),
       fechaInicio = Value(fechaInicio),
       fechaFin = Value(fechaFin),
       horaInicio = Value(horaInicio),
       horaFin = Value(horaFin),
       inicioDescanso = Value(inicioDescanso),
       finDescanso = Value(finDescanso);
  static Insertable<Horario> custom({
    Expression<int>? id,
    Expression<int>? ubicacionId,
    Expression<String>? fechaInicio,
    Expression<String>? fechaFin,
    Expression<String>? horaInicio,
    Expression<String>? horaFin,
    Expression<bool>? estado,
    Expression<bool>? pagaAlmuerzo,
    Expression<String>? inicioDescanso,
    Expression<String>? finDescanso,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ubicacionId != null) 'ubicacion_id': ubicacionId,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (fechaFin != null) 'fecha_fin': fechaFin,
      if (horaInicio != null) 'hora_inicio': horaInicio,
      if (horaFin != null) 'hora_fin': horaFin,
      if (estado != null) 'estado': estado,
      if (pagaAlmuerzo != null) 'paga_almuerzo': pagaAlmuerzo,
      if (inicioDescanso != null) 'inicio_descanso': inicioDescanso,
      if (finDescanso != null) 'fin_descanso': finDescanso,
    });
  }

  HorariosCompanion copyWith({
    Value<int>? id,
    Value<int>? ubicacionId,
    Value<DateTime>? fechaInicio,
    Value<DateTime>? fechaFin,
    Value<TimeOfDay>? horaInicio,
    Value<TimeOfDay>? horaFin,
    Value<bool>? estado,
    Value<bool>? pagaAlmuerzo,
    Value<TimeOfDay>? inicioDescanso,
    Value<TimeOfDay>? finDescanso,
  }) {
    return HorariosCompanion(
      id: id ?? this.id,
      ubicacionId: ubicacionId ?? this.ubicacionId,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFin: horaFin ?? this.horaFin,
      estado: estado ?? this.estado,
      pagaAlmuerzo: pagaAlmuerzo ?? this.pagaAlmuerzo,
      inicioDescanso: inicioDescanso ?? this.inicioDescanso,
      finDescanso: finDescanso ?? this.finDescanso,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ubicacionId.present) {
      map['ubicacion_id'] = Variable<int>(ubicacionId.value);
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<String>(
        $HorariosTable.$converterfechaInicio.toSql(fechaInicio.value),
      );
    }
    if (fechaFin.present) {
      map['fecha_fin'] = Variable<String>(
        $HorariosTable.$converterfechaFin.toSql(fechaFin.value),
      );
    }
    if (horaInicio.present) {
      map['hora_inicio'] = Variable<String>(
        $HorariosTable.$converterhoraInicio.toSql(horaInicio.value),
      );
    }
    if (horaFin.present) {
      map['hora_fin'] = Variable<String>(
        $HorariosTable.$converterhoraFin.toSql(horaFin.value),
      );
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (pagaAlmuerzo.present) {
      map['paga_almuerzo'] = Variable<bool>(pagaAlmuerzo.value);
    }
    if (inicioDescanso.present) {
      map['inicio_descanso'] = Variable<String>(
        $HorariosTable.$converterinicioDescanso.toSql(inicioDescanso.value),
      );
    }
    if (finDescanso.present) {
      map['fin_descanso'] = Variable<String>(
        $HorariosTable.$converterfinDescanso.toSql(finDescanso.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HorariosCompanion(')
          ..write('id: $id, ')
          ..write('ubicacionId: $ubicacionId, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('horaInicio: $horaInicio, ')
          ..write('horaFin: $horaFin, ')
          ..write('estado: $estado, ')
          ..write('pagaAlmuerzo: $pagaAlmuerzo, ')
          ..write('inicioDescanso: $inicioDescanso, ')
          ..write('finDescanso: $finDescanso')
          ..write(')'))
        .toString();
  }
}

class $SyncsEntitysTable extends SyncsEntitys
    with TableInfo<$SyncsEntitysTable, SyncsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncsEntitysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTableNameToSyncMeta =
      const VerificationMeta('entityTableNameToSync');
  @override
  late final GeneratedColumn<String> entityTableNameToSync =
      GeneratedColumn<String>(
        'entity_table_name_to_sync',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registerIdMeta = const VerificationMeta(
    'registerId',
  );
  @override
  late final GeneratedColumn<String> registerId = GeneratedColumn<String>(
    'register_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>($SyncsEntitysTable.$converterdata);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityTableNameToSync,
    action,
    registerId,
    timestamp,
    isSynced,
    data,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'syncs_entitys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncsEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_table_name_to_sync')) {
      context.handle(
        _entityTableNameToSyncMeta,
        entityTableNameToSync.isAcceptableOrUnknown(
          data['entity_table_name_to_sync']!,
          _entityTableNameToSyncMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entityTableNameToSyncMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('register_id')) {
      context.handle(
        _registerIdMeta,
        registerId.isAcceptableOrUnknown(data['register_id']!, _registerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_registerIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncsEntity(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      entityTableNameToSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}entity_table_name_to_sync'],
          )!,
      action:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}action'],
          )!,
      registerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}register_id'],
          )!,
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}timestamp'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
      data: $SyncsEntitysTable.$converterdata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        )!,
      ),
    );
  }

  @override
  $SyncsEntitysTable createAlias(String alias) {
    return $SyncsEntitysTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterdata =
      const JsonConverter();
}

class SyncsEntity extends DataClass implements Insertable<SyncsEntity> {
  final int id;
  final String entityTableNameToSync;
  final String action;
  final String registerId;
  final DateTime timestamp;
  final bool isSynced;
  final Map<String, dynamic> data;
  const SyncsEntity({
    required this.id,
    required this.entityTableNameToSync,
    required this.action,
    required this.registerId,
    required this.timestamp,
    required this.isSynced,
    required this.data,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_table_name_to_sync'] = Variable<String>(entityTableNameToSync);
    map['action'] = Variable<String>(action);
    map['register_id'] = Variable<String>(registerId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['is_synced'] = Variable<bool>(isSynced);
    {
      map['data'] = Variable<String>(
        $SyncsEntitysTable.$converterdata.toSql(data),
      );
    }
    return map;
  }

  SyncsEntitysCompanion toCompanion(bool nullToAbsent) {
    return SyncsEntitysCompanion(
      id: Value(id),
      entityTableNameToSync: Value(entityTableNameToSync),
      action: Value(action),
      registerId: Value(registerId),
      timestamp: Value(timestamp),
      isSynced: Value(isSynced),
      data: Value(data),
    );
  }

  factory SyncsEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncsEntity(
      id: serializer.fromJson<int>(json['id']),
      entityTableNameToSync: serializer.fromJson<String>(
        json['entityTableNameToSync'],
      ),
      action: serializer.fromJson<String>(json['action']),
      registerId: serializer.fromJson<String>(json['registerId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      data: serializer.fromJson<Map<String, dynamic>>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityTableNameToSync': serializer.toJson<String>(entityTableNameToSync),
      'action': serializer.toJson<String>(action),
      'registerId': serializer.toJson<String>(registerId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'isSynced': serializer.toJson<bool>(isSynced),
      'data': serializer.toJson<Map<String, dynamic>>(data),
    };
  }

  SyncsEntity copyWith({
    int? id,
    String? entityTableNameToSync,
    String? action,
    String? registerId,
    DateTime? timestamp,
    bool? isSynced,
    Map<String, dynamic>? data,
  }) => SyncsEntity(
    id: id ?? this.id,
    entityTableNameToSync: entityTableNameToSync ?? this.entityTableNameToSync,
    action: action ?? this.action,
    registerId: registerId ?? this.registerId,
    timestamp: timestamp ?? this.timestamp,
    isSynced: isSynced ?? this.isSynced,
    data: data ?? this.data,
  );
  SyncsEntity copyWithCompanion(SyncsEntitysCompanion data) {
    return SyncsEntity(
      id: data.id.present ? data.id.value : this.id,
      entityTableNameToSync:
          data.entityTableNameToSync.present
              ? data.entityTableNameToSync.value
              : this.entityTableNameToSync,
      action: data.action.present ? data.action.value : this.action,
      registerId:
          data.registerId.present ? data.registerId.value : this.registerId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncsEntity(')
          ..write('id: $id, ')
          ..write('entityTableNameToSync: $entityTableNameToSync, ')
          ..write('action: $action, ')
          ..write('registerId: $registerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityTableNameToSync,
    action,
    registerId,
    timestamp,
    isSynced,
    data,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncsEntity &&
          other.id == this.id &&
          other.entityTableNameToSync == this.entityTableNameToSync &&
          other.action == this.action &&
          other.registerId == this.registerId &&
          other.timestamp == this.timestamp &&
          other.isSynced == this.isSynced &&
          other.data == this.data);
}

class SyncsEntitysCompanion extends UpdateCompanion<SyncsEntity> {
  final Value<int> id;
  final Value<String> entityTableNameToSync;
  final Value<String> action;
  final Value<String> registerId;
  final Value<DateTime> timestamp;
  final Value<bool> isSynced;
  final Value<Map<String, dynamic>> data;
  const SyncsEntitysCompanion({
    this.id = const Value.absent(),
    this.entityTableNameToSync = const Value.absent(),
    this.action = const Value.absent(),
    this.registerId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.data = const Value.absent(),
  });
  SyncsEntitysCompanion.insert({
    this.id = const Value.absent(),
    required String entityTableNameToSync,
    required String action,
    required String registerId,
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    required Map<String, dynamic> data,
  }) : entityTableNameToSync = Value(entityTableNameToSync),
       action = Value(action),
       registerId = Value(registerId),
       data = Value(data);
  static Insertable<SyncsEntity> custom({
    Expression<int>? id,
    Expression<String>? entityTableNameToSync,
    Expression<String>? action,
    Expression<String>? registerId,
    Expression<DateTime>? timestamp,
    Expression<bool>? isSynced,
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityTableNameToSync != null)
        'entity_table_name_to_sync': entityTableNameToSync,
      if (action != null) 'action': action,
      if (registerId != null) 'register_id': registerId,
      if (timestamp != null) 'timestamp': timestamp,
      if (isSynced != null) 'is_synced': isSynced,
      if (data != null) 'data': data,
    });
  }

  SyncsEntitysCompanion copyWith({
    Value<int>? id,
    Value<String>? entityTableNameToSync,
    Value<String>? action,
    Value<String>? registerId,
    Value<DateTime>? timestamp,
    Value<bool>? isSynced,
    Value<Map<String, dynamic>>? data,
  }) {
    return SyncsEntitysCompanion(
      id: id ?? this.id,
      entityTableNameToSync:
          entityTableNameToSync ?? this.entityTableNameToSync,
      action: action ?? this.action,
      registerId: registerId ?? this.registerId,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityTableNameToSync.present) {
      map['entity_table_name_to_sync'] = Variable<String>(
        entityTableNameToSync.value,
      );
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (registerId.present) {
      map['register_id'] = Variable<String>(registerId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $SyncsEntitysTable.$converterdata.toSql(data.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncsEntitysCompanion(')
          ..write('id: $id, ')
          ..write('entityTableNameToSync: $entityTableNameToSync, ')
          ..write('action: $action, ')
          ..write('registerId: $registerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TrabajadoresTable trabajadores = $TrabajadoresTable(this);
  late final $GruposUbicacionesTable gruposUbicaciones =
      $GruposUbicacionesTable(this);
  late final $UbicacionesTable ubicaciones = $UbicacionesTable(this);
  late final $HorariosTable horarios = $HorariosTable(this);
  late final $SyncsEntitysTable syncsEntitys = $SyncsEntitysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trabajadores,
    gruposUbicaciones,
    ubicaciones,
    horarios,
    syncsEntitys,
  ];
}

typedef $$TrabajadoresTableCreateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      required String nombre,
      required String primerApellido,
      required String segundoApellido,
      required int equipoId,
      Value<bool> estado,
    });
typedef $$TrabajadoresTableUpdateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> primerApellido,
      Value<String> segundoApellido,
      Value<int> equipoId,
      Value<bool> estado,
    });

class $$TrabajadoresTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajadoresTable> {
  $$TrabajadoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primerApellido => $composableBuilder(
    column: $table.primerApellido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segundoApellido => $composableBuilder(
    column: $table.segundoApellido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get equipoId => $composableBuilder(
    column: $table.equipoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrabajadoresTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajadoresTable> {
  $$TrabajadoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primerApellido => $composableBuilder(
    column: $table.primerApellido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segundoApellido => $composableBuilder(
    column: $table.segundoApellido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get equipoId => $composableBuilder(
    column: $table.equipoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrabajadoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajadoresTable> {
  $$TrabajadoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get primerApellido => $composableBuilder(
    column: $table.primerApellido,
    builder: (column) => column,
  );

  GeneratedColumn<String> get segundoApellido => $composableBuilder(
    column: $table.segundoApellido,
    builder: (column) => column,
  );

  GeneratedColumn<int> get equipoId =>
      $composableBuilder(column: $table.equipoId, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$TrabajadoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrabajadoresTable,
          Trabajadore,
          $$TrabajadoresTableFilterComposer,
          $$TrabajadoresTableOrderingComposer,
          $$TrabajadoresTableAnnotationComposer,
          $$TrabajadoresTableCreateCompanionBuilder,
          $$TrabajadoresTableUpdateCompanionBuilder,
          (
            Trabajadore,
            BaseReferences<_$AppDatabase, $TrabajadoresTable, Trabajadore>,
          ),
          Trabajadore,
          PrefetchHooks Function()
        > {
  $$TrabajadoresTableTableManager(_$AppDatabase db, $TrabajadoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TrabajadoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TrabajadoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$TrabajadoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> primerApellido = const Value.absent(),
                Value<String> segundoApellido = const Value.absent(),
                Value<int> equipoId = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => TrabajadoresCompanion(
                id: id,
                nombre: nombre,
                primerApellido: primerApellido,
                segundoApellido: segundoApellido,
                equipoId: equipoId,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String primerApellido,
                required String segundoApellido,
                required int equipoId,
                Value<bool> estado = const Value.absent(),
              }) => TrabajadoresCompanion.insert(
                id: id,
                nombre: nombre,
                primerApellido: primerApellido,
                segundoApellido: segundoApellido,
                equipoId: equipoId,
                estado: estado,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrabajadoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrabajadoresTable,
      Trabajadore,
      $$TrabajadoresTableFilterComposer,
      $$TrabajadoresTableOrderingComposer,
      $$TrabajadoresTableAnnotationComposer,
      $$TrabajadoresTableCreateCompanionBuilder,
      $$TrabajadoresTableUpdateCompanionBuilder,
      (
        Trabajadore,
        BaseReferences<_$AppDatabase, $TrabajadoresTable, Trabajadore>,
      ),
      Trabajadore,
      PrefetchHooks Function()
    >;
typedef $$GruposUbicacionesTableCreateCompanionBuilder =
    GruposUbicacionesCompanion Function({
      Value<int> id,
      required String nombre,
      Value<bool> estado,
    });
typedef $$GruposUbicacionesTableUpdateCompanionBuilder =
    GruposUbicacionesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<bool> estado,
    });

class $$GruposUbicacionesTableFilterComposer
    extends Composer<_$AppDatabase, $GruposUbicacionesTable> {
  $$GruposUbicacionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GruposUbicacionesTableOrderingComposer
    extends Composer<_$AppDatabase, $GruposUbicacionesTable> {
  $$GruposUbicacionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GruposUbicacionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GruposUbicacionesTable> {
  $$GruposUbicacionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$GruposUbicacionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GruposUbicacionesTable,
          GruposUbicacione,
          $$GruposUbicacionesTableFilterComposer,
          $$GruposUbicacionesTableOrderingComposer,
          $$GruposUbicacionesTableAnnotationComposer,
          $$GruposUbicacionesTableCreateCompanionBuilder,
          $$GruposUbicacionesTableUpdateCompanionBuilder,
          (
            GruposUbicacione,
            BaseReferences<
              _$AppDatabase,
              $GruposUbicacionesTable,
              GruposUbicacione
            >,
          ),
          GruposUbicacione,
          PrefetchHooks Function()
        > {
  $$GruposUbicacionesTableTableManager(
    _$AppDatabase db,
    $GruposUbicacionesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$GruposUbicacionesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$GruposUbicacionesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$GruposUbicacionesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => GruposUbicacionesCompanion(
                id: id,
                nombre: nombre,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<bool> estado = const Value.absent(),
              }) => GruposUbicacionesCompanion.insert(
                id: id,
                nombre: nombre,
                estado: estado,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GruposUbicacionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GruposUbicacionesTable,
      GruposUbicacione,
      $$GruposUbicacionesTableFilterComposer,
      $$GruposUbicacionesTableOrderingComposer,
      $$GruposUbicacionesTableAnnotationComposer,
      $$GruposUbicacionesTableCreateCompanionBuilder,
      $$GruposUbicacionesTableUpdateCompanionBuilder,
      (
        GruposUbicacione,
        BaseReferences<
          _$AppDatabase,
          $GruposUbicacionesTable,
          GruposUbicacione
        >,
      ),
      GruposUbicacione,
      PrefetchHooks Function()
    >;
typedef $$UbicacionesTableCreateCompanionBuilder =
    UbicacionesCompanion Function({
      required String id,
      required String nombre,
      required int ubicacionId,
      Value<bool> estado,
      Value<int> rowid,
    });
typedef $$UbicacionesTableUpdateCompanionBuilder =
    UbicacionesCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<int> ubicacionId,
      Value<bool> estado,
      Value<int> rowid,
    });

final class $$UbicacionesTableReferences
    extends BaseReferences<_$AppDatabase, $UbicacionesTable, Ubicacione> {
  $$UbicacionesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HorariosTable, List<Horario>> _horariosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.horarios,
    aliasName: $_aliasNameGenerator(
      db.ubicaciones.ubicacionId,
      db.horarios.ubicacionId,
    ),
  );

  $$HorariosTableProcessedTableManager get horariosRefs {
    final manager = $$HorariosTableTableManager($_db, $_db.horarios).filter(
      (f) => f.ubicacionId.ubicacionId.sqlEquals(
        $_itemColumn<int>('ubicacion_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_horariosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UbicacionesTableFilterComposer
    extends Composer<_$AppDatabase, $UbicacionesTable> {
  $$UbicacionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ubicacionId => $composableBuilder(
    column: $table.ubicacionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> horariosRefs(
    Expression<bool> Function($$HorariosTableFilterComposer f) f,
  ) {
    final $$HorariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ubicacionId,
      referencedTable: $db.horarios,
      getReferencedColumn: (t) => t.ubicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorariosTableFilterComposer(
            $db: $db,
            $table: $db.horarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UbicacionesTableOrderingComposer
    extends Composer<_$AppDatabase, $UbicacionesTable> {
  $$UbicacionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ubicacionId => $composableBuilder(
    column: $table.ubicacionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UbicacionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UbicacionesTable> {
  $$UbicacionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get ubicacionId => $composableBuilder(
    column: $table.ubicacionId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  Expression<T> horariosRefs<T extends Object>(
    Expression<T> Function($$HorariosTableAnnotationComposer a) f,
  ) {
    final $$HorariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ubicacionId,
      referencedTable: $db.horarios,
      getReferencedColumn: (t) => t.ubicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorariosTableAnnotationComposer(
            $db: $db,
            $table: $db.horarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UbicacionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UbicacionesTable,
          Ubicacione,
          $$UbicacionesTableFilterComposer,
          $$UbicacionesTableOrderingComposer,
          $$UbicacionesTableAnnotationComposer,
          $$UbicacionesTableCreateCompanionBuilder,
          $$UbicacionesTableUpdateCompanionBuilder,
          (Ubicacione, $$UbicacionesTableReferences),
          Ubicacione,
          PrefetchHooks Function({bool horariosRefs})
        > {
  $$UbicacionesTableTableManager(_$AppDatabase db, $UbicacionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UbicacionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UbicacionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$UbicacionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> ubicacionId = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UbicacionesCompanion(
                id: id,
                nombre: nombre,
                ubicacionId: ubicacionId,
                estado: estado,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required int ubicacionId,
                Value<bool> estado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UbicacionesCompanion.insert(
                id: id,
                nombre: nombre,
                ubicacionId: ubicacionId,
                estado: estado,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$UbicacionesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({horariosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (horariosRefs) db.horarios],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (horariosRefs)
                    await $_getPrefetchedData<
                      Ubicacione,
                      $UbicacionesTable,
                      Horario
                    >(
                      currentTable: table,
                      referencedTable: $$UbicacionesTableReferences
                          ._horariosRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UbicacionesTableReferences(
                                db,
                                table,
                                p0,
                              ).horariosRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.ubicacionId == item.ubicacionId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UbicacionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UbicacionesTable,
      Ubicacione,
      $$UbicacionesTableFilterComposer,
      $$UbicacionesTableOrderingComposer,
      $$UbicacionesTableAnnotationComposer,
      $$UbicacionesTableCreateCompanionBuilder,
      $$UbicacionesTableUpdateCompanionBuilder,
      (Ubicacione, $$UbicacionesTableReferences),
      Ubicacione,
      PrefetchHooks Function({bool horariosRefs})
    >;
typedef $$HorariosTableCreateCompanionBuilder =
    HorariosCompanion Function({
      Value<int> id,
      required int ubicacionId,
      required DateTime fechaInicio,
      required DateTime fechaFin,
      required TimeOfDay horaInicio,
      required TimeOfDay horaFin,
      Value<bool> estado,
      Value<bool> pagaAlmuerzo,
      required TimeOfDay inicioDescanso,
      required TimeOfDay finDescanso,
    });
typedef $$HorariosTableUpdateCompanionBuilder =
    HorariosCompanion Function({
      Value<int> id,
      Value<int> ubicacionId,
      Value<DateTime> fechaInicio,
      Value<DateTime> fechaFin,
      Value<TimeOfDay> horaInicio,
      Value<TimeOfDay> horaFin,
      Value<bool> estado,
      Value<bool> pagaAlmuerzo,
      Value<TimeOfDay> inicioDescanso,
      Value<TimeOfDay> finDescanso,
    });

final class $$HorariosTableReferences
    extends BaseReferences<_$AppDatabase, $HorariosTable, Horario> {
  $$HorariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UbicacionesTable _ubicacionIdTable(_$AppDatabase db) =>
      db.ubicaciones.createAlias(
        $_aliasNameGenerator(
          db.horarios.ubicacionId,
          db.ubicaciones.ubicacionId,
        ),
      );

  $$UbicacionesTableProcessedTableManager get ubicacionId {
    final $_column = $_itemColumn<int>('ubicacion_id')!;

    final manager = $$UbicacionesTableTableManager(
      $_db,
      $_db.ubicaciones,
    ).filter((f) => f.ubicacionId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ubicacionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HorariosTableFilterComposer
    extends Composer<_$AppDatabase, $HorariosTable> {
  $$HorariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, String> get fechaInicio =>
      $composableBuilder(
        column: $table.fechaInicio,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<DateTime, DateTime, String> get fechaFin =>
      $composableBuilder(
        column: $table.fechaFin,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, String> get horaInicio =>
      $composableBuilder(
        column: $table.horaInicio,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, String> get horaFin =>
      $composableBuilder(
        column: $table.horaFin,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pagaAlmuerzo => $composableBuilder(
    column: $table.pagaAlmuerzo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, String>
  get inicioDescanso => $composableBuilder(
    column: $table.inicioDescanso,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, String>
  get finDescanso => $composableBuilder(
    column: $table.finDescanso,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$UbicacionesTableFilterComposer get ubicacionId {
    final $$UbicacionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ubicacionId,
      referencedTable: $db.ubicaciones,
      getReferencedColumn: (t) => t.ubicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UbicacionesTableFilterComposer(
            $db: $db,
            $table: $db.ubicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorariosTableOrderingComposer
    extends Composer<_$AppDatabase, $HorariosTable> {
  $$HorariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaFin => $composableBuilder(
    column: $table.fechaFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaInicio => $composableBuilder(
    column: $table.horaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaFin => $composableBuilder(
    column: $table.horaFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pagaAlmuerzo => $composableBuilder(
    column: $table.pagaAlmuerzo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inicioDescanso => $composableBuilder(
    column: $table.inicioDescanso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finDescanso => $composableBuilder(
    column: $table.finDescanso,
    builder: (column) => ColumnOrderings(column),
  );

  $$UbicacionesTableOrderingComposer get ubicacionId {
    final $$UbicacionesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ubicacionId,
      referencedTable: $db.ubicaciones,
      getReferencedColumn: (t) => t.ubicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UbicacionesTableOrderingComposer(
            $db: $db,
            $table: $db.ubicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $HorariosTable> {
  $$HorariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, String> get fechaInicio =>
      $composableBuilder(
        column: $table.fechaInicio,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<DateTime, String> get fechaFin =>
      $composableBuilder(column: $table.fechaFin, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDay, String> get horaInicio =>
      $composableBuilder(
        column: $table.horaInicio,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<TimeOfDay, String> get horaFin =>
      $composableBuilder(column: $table.horaFin, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<bool> get pagaAlmuerzo => $composableBuilder(
    column: $table.pagaAlmuerzo,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TimeOfDay, String> get inicioDescanso =>
      $composableBuilder(
        column: $table.inicioDescanso,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<TimeOfDay, String> get finDescanso =>
      $composableBuilder(
        column: $table.finDescanso,
        builder: (column) => column,
      );

  $$UbicacionesTableAnnotationComposer get ubicacionId {
    final $$UbicacionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ubicacionId,
      referencedTable: $db.ubicaciones,
      getReferencedColumn: (t) => t.ubicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UbicacionesTableAnnotationComposer(
            $db: $db,
            $table: $db.ubicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HorariosTable,
          Horario,
          $$HorariosTableFilterComposer,
          $$HorariosTableOrderingComposer,
          $$HorariosTableAnnotationComposer,
          $$HorariosTableCreateCompanionBuilder,
          $$HorariosTableUpdateCompanionBuilder,
          (Horario, $$HorariosTableReferences),
          Horario,
          PrefetchHooks Function({bool ubicacionId})
        > {
  $$HorariosTableTableManager(_$AppDatabase db, $HorariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HorariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$HorariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HorariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ubicacionId = const Value.absent(),
                Value<DateTime> fechaInicio = const Value.absent(),
                Value<DateTime> fechaFin = const Value.absent(),
                Value<TimeOfDay> horaInicio = const Value.absent(),
                Value<TimeOfDay> horaFin = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<bool> pagaAlmuerzo = const Value.absent(),
                Value<TimeOfDay> inicioDescanso = const Value.absent(),
                Value<TimeOfDay> finDescanso = const Value.absent(),
              }) => HorariosCompanion(
                id: id,
                ubicacionId: ubicacionId,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                horaInicio: horaInicio,
                horaFin: horaFin,
                estado: estado,
                pagaAlmuerzo: pagaAlmuerzo,
                inicioDescanso: inicioDescanso,
                finDescanso: finDescanso,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ubicacionId,
                required DateTime fechaInicio,
                required DateTime fechaFin,
                required TimeOfDay horaInicio,
                required TimeOfDay horaFin,
                Value<bool> estado = const Value.absent(),
                Value<bool> pagaAlmuerzo = const Value.absent(),
                required TimeOfDay inicioDescanso,
                required TimeOfDay finDescanso,
              }) => HorariosCompanion.insert(
                id: id,
                ubicacionId: ubicacionId,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                horaInicio: horaInicio,
                horaFin: horaFin,
                estado: estado,
                pagaAlmuerzo: pagaAlmuerzo,
                inicioDescanso: inicioDescanso,
                finDescanso: finDescanso,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$HorariosTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({ubicacionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (ubicacionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.ubicacionId,
                            referencedTable: $$HorariosTableReferences
                                ._ubicacionIdTable(db),
                            referencedColumn:
                                $$HorariosTableReferences
                                    ._ubicacionIdTable(db)
                                    .ubicacionId,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HorariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HorariosTable,
      Horario,
      $$HorariosTableFilterComposer,
      $$HorariosTableOrderingComposer,
      $$HorariosTableAnnotationComposer,
      $$HorariosTableCreateCompanionBuilder,
      $$HorariosTableUpdateCompanionBuilder,
      (Horario, $$HorariosTableReferences),
      Horario,
      PrefetchHooks Function({bool ubicacionId})
    >;
typedef $$SyncsEntitysTableCreateCompanionBuilder =
    SyncsEntitysCompanion Function({
      Value<int> id,
      required String entityTableNameToSync,
      required String action,
      required String registerId,
      Value<DateTime> timestamp,
      Value<bool> isSynced,
      required Map<String, dynamic> data,
    });
typedef $$SyncsEntitysTableUpdateCompanionBuilder =
    SyncsEntitysCompanion Function({
      Value<int> id,
      Value<String> entityTableNameToSync,
      Value<String> action,
      Value<String> registerId,
      Value<DateTime> timestamp,
      Value<bool> isSynced,
      Value<Map<String, dynamic>> data,
    });

class $$SyncsEntitysTableFilterComposer
    extends Composer<_$AppDatabase, $SyncsEntitysTable> {
  $$SyncsEntitysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityTableNameToSync => $composableBuilder(
    column: $table.entityTableNameToSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registerId => $composableBuilder(
    column: $table.registerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$SyncsEntitysTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncsEntitysTable> {
  $$SyncsEntitysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityTableNameToSync => $composableBuilder(
    column: $table.entityTableNameToSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registerId => $composableBuilder(
    column: $table.registerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncsEntitysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncsEntitysTable> {
  $$SyncsEntitysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityTableNameToSync => $composableBuilder(
    column: $table.entityTableNameToSync,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get registerId => $composableBuilder(
    column: $table.registerId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$SyncsEntitysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncsEntitysTable,
          SyncsEntity,
          $$SyncsEntitysTableFilterComposer,
          $$SyncsEntitysTableOrderingComposer,
          $$SyncsEntitysTableAnnotationComposer,
          $$SyncsEntitysTableCreateCompanionBuilder,
          $$SyncsEntitysTableUpdateCompanionBuilder,
          (
            SyncsEntity,
            BaseReferences<_$AppDatabase, $SyncsEntitysTable, SyncsEntity>,
          ),
          SyncsEntity,
          PrefetchHooks Function()
        > {
  $$SyncsEntitysTableTableManager(_$AppDatabase db, $SyncsEntitysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncsEntitysTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncsEntitysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$SyncsEntitysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityTableNameToSync = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> registerId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<Map<String, dynamic>> data = const Value.absent(),
              }) => SyncsEntitysCompanion(
                id: id,
                entityTableNameToSync: entityTableNameToSync,
                action: action,
                registerId: registerId,
                timestamp: timestamp,
                isSynced: isSynced,
                data: data,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityTableNameToSync,
                required String action,
                required String registerId,
                Value<DateTime> timestamp = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                required Map<String, dynamic> data,
              }) => SyncsEntitysCompanion.insert(
                id: id,
                entityTableNameToSync: entityTableNameToSync,
                action: action,
                registerId: registerId,
                timestamp: timestamp,
                isSynced: isSynced,
                data: data,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncsEntitysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncsEntitysTable,
      SyncsEntity,
      $$SyncsEntitysTableFilterComposer,
      $$SyncsEntitysTableOrderingComposer,
      $$SyncsEntitysTableAnnotationComposer,
      $$SyncsEntitysTableCreateCompanionBuilder,
      $$SyncsEntitysTableUpdateCompanionBuilder,
      (
        SyncsEntity,
        BaseReferences<_$AppDatabase, $SyncsEntitysTable, SyncsEntity>,
      ),
      SyncsEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TrabajadoresTableTableManager get trabajadores =>
      $$TrabajadoresTableTableManager(_db, _db.trabajadores);
  $$GruposUbicacionesTableTableManager get gruposUbicaciones =>
      $$GruposUbicacionesTableTableManager(_db, _db.gruposUbicaciones);
  $$UbicacionesTableTableManager get ubicaciones =>
      $$UbicacionesTableTableManager(_db, _db.ubicaciones);
  $$HorariosTableTableManager get horarios =>
      $$HorariosTableTableManager(_db, _db.horarios);
  $$SyncsEntitysTableTableManager get syncsEntitys =>
      $$SyncsEntitysTableTableManager(_db, _db.syncsEntitys);
}
