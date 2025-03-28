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
  static const VerificationMeta _faceSyncMeta = const VerificationMeta(
    'faceSync',
  );
  @override
  late final GeneratedColumn<bool> faceSync = GeneratedColumn<bool>(
    'face_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("face_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fotoUrlMeta = const VerificationMeta(
    'fotoUrl',
  );
  @override
  late final GeneratedColumn<String> fotoUrl = GeneratedColumn<String>(
    'foto_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    primerApellido,
    segundoApellido,
    equipoId,
    estado,
    faceSync,
    fotoUrl,
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
    if (data.containsKey('face_sync')) {
      context.handle(
        _faceSyncMeta,
        faceSync.isAcceptableOrUnknown(data['face_sync']!, _faceSyncMeta),
      );
    }
    if (data.containsKey('foto_url')) {
      context.handle(
        _fotoUrlMeta,
        fotoUrl.isAcceptableOrUnknown(data['foto_url']!, _fotoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_fotoUrlMeta);
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
      faceSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}face_sync'],
          )!,
      fotoUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}foto_url'],
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
  final bool faceSync;
  final String fotoUrl;
  const Trabajadore({
    required this.id,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.equipoId,
    required this.estado,
    required this.faceSync,
    required this.fotoUrl,
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
    map['face_sync'] = Variable<bool>(faceSync);
    map['foto_url'] = Variable<String>(fotoUrl);
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
      faceSync: Value(faceSync),
      fotoUrl: Value(fotoUrl),
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
      faceSync: serializer.fromJson<bool>(json['faceSync']),
      fotoUrl: serializer.fromJson<String>(json['fotoUrl']),
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
      'faceSync': serializer.toJson<bool>(faceSync),
      'fotoUrl': serializer.toJson<String>(fotoUrl),
    };
  }

  Trabajadore copyWith({
    int? id,
    String? nombre,
    String? primerApellido,
    String? segundoApellido,
    int? equipoId,
    bool? estado,
    bool? faceSync,
    String? fotoUrl,
  }) => Trabajadore(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    primerApellido: primerApellido ?? this.primerApellido,
    segundoApellido: segundoApellido ?? this.segundoApellido,
    equipoId: equipoId ?? this.equipoId,
    estado: estado ?? this.estado,
    faceSync: faceSync ?? this.faceSync,
    fotoUrl: fotoUrl ?? this.fotoUrl,
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
      faceSync: data.faceSync.present ? data.faceSync.value : this.faceSync,
      fotoUrl: data.fotoUrl.present ? data.fotoUrl.value : this.fotoUrl,
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
          ..write('estado: $estado, ')
          ..write('faceSync: $faceSync, ')
          ..write('fotoUrl: $fotoUrl')
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
    faceSync,
    fotoUrl,
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
          other.estado == this.estado &&
          other.faceSync == this.faceSync &&
          other.fotoUrl == this.fotoUrl);
}

class TrabajadoresCompanion extends UpdateCompanion<Trabajadore> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> primerApellido;
  final Value<String> segundoApellido;
  final Value<int> equipoId;
  final Value<bool> estado;
  final Value<bool> faceSync;
  final Value<String> fotoUrl;
  const TrabajadoresCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.primerApellido = const Value.absent(),
    this.segundoApellido = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.estado = const Value.absent(),
    this.faceSync = const Value.absent(),
    this.fotoUrl = const Value.absent(),
  });
  TrabajadoresCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String primerApellido,
    required String segundoApellido,
    required int equipoId,
    this.estado = const Value.absent(),
    this.faceSync = const Value.absent(),
    required String fotoUrl,
  }) : nombre = Value(nombre),
       primerApellido = Value(primerApellido),
       segundoApellido = Value(segundoApellido),
       equipoId = Value(equipoId),
       fotoUrl = Value(fotoUrl);
  static Insertable<Trabajadore> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? primerApellido,
    Expression<String>? segundoApellido,
    Expression<int>? equipoId,
    Expression<bool>? estado,
    Expression<bool>? faceSync,
    Expression<String>? fotoUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (primerApellido != null) 'primer_apellido': primerApellido,
      if (segundoApellido != null) 'segundo_apellido': segundoApellido,
      if (equipoId != null) 'equipo_id': equipoId,
      if (estado != null) 'estado': estado,
      if (faceSync != null) 'face_sync': faceSync,
      if (fotoUrl != null) 'foto_url': fotoUrl,
    });
  }

  TrabajadoresCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? primerApellido,
    Value<String>? segundoApellido,
    Value<int>? equipoId,
    Value<bool>? estado,
    Value<bool>? faceSync,
    Value<String>? fotoUrl,
  }) {
    return TrabajadoresCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      primerApellido: primerApellido ?? this.primerApellido,
      segundoApellido: segundoApellido ?? this.segundoApellido,
      equipoId: equipoId ?? this.equipoId,
      estado: estado ?? this.estado,
      faceSync: faceSync ?? this.faceSync,
      fotoUrl: fotoUrl ?? this.fotoUrl,
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
    if (faceSync.present) {
      map['face_sync'] = Variable<bool>(faceSync.value);
    }
    if (fotoUrl.present) {
      map['foto_url'] = Variable<String>(fotoUrl.value);
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
          ..write('estado: $estado, ')
          ..write('faceSync: $faceSync, ')
          ..write('fotoUrl: $fotoUrl')
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

class $RegistrosBiometricosTable extends RegistrosBiometricos
    with TableInfo<$RegistrosBiometricosTable, RegistrosBiometrico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistrosBiometricosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _trabajadorIdMeta = const VerificationMeta(
    'trabajadorId',
  );
  @override
  late final GeneratedColumn<int> trabajadorId = GeneratedColumn<int>(
    'trabajador_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (equipo_id)',
    ),
  );
  static const VerificationMeta _fotoMeta = const VerificationMeta('foto');
  @override
  late final GeneratedColumn<String> foto = GeneratedColumn<String>(
    'foto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  datosBiometricos = GeneratedColumn<String>(
    'datos_biometricos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>(
    $RegistrosBiometricosTable.$converterdatosBiometricos,
  );
  static const VerificationMeta _pruebaVidaExitosaMeta = const VerificationMeta(
    'pruebaVidaExitosa',
  );
  @override
  late final GeneratedColumn<bool> pruebaVidaExitosa = GeneratedColumn<bool>(
    'prueba_vida_exitosa',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("prueba_vida_exitosa" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MetodoPruebaVida, String>
  metodoPruebaVida = GeneratedColumn<String>(
    'metodo_prueba_vida',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MetodoPruebaVida>(
    $RegistrosBiometricosTable.$convertermetodoPruebaVida,
  );
  static const VerificationMeta _puntajeConfianzaMeta = const VerificationMeta(
    'puntajeConfianza',
  );
  @override
  late final GeneratedColumn<double> puntajeConfianza = GeneratedColumn<double>(
    'puntaje_confianza',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  List<GeneratedColumn> get $columns => [
    id,
    trabajadorId,
    foto,
    datosBiometricos,
    pruebaVidaExitosa,
    metodoPruebaVida,
    puntajeConfianza,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registros_biometricos';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegistrosBiometrico> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trabajador_id')) {
      context.handle(
        _trabajadorIdMeta,
        trabajadorId.isAcceptableOrUnknown(
          data['trabajador_id']!,
          _trabajadorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trabajadorIdMeta);
    }
    if (data.containsKey('foto')) {
      context.handle(
        _fotoMeta,
        foto.isAcceptableOrUnknown(data['foto']!, _fotoMeta),
      );
    } else if (isInserting) {
      context.missing(_fotoMeta);
    }
    if (data.containsKey('prueba_vida_exitosa')) {
      context.handle(
        _pruebaVidaExitosaMeta,
        pruebaVidaExitosa.isAcceptableOrUnknown(
          data['prueba_vida_exitosa']!,
          _pruebaVidaExitosaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pruebaVidaExitosaMeta);
    }
    if (data.containsKey('puntaje_confianza')) {
      context.handle(
        _puntajeConfianzaMeta,
        puntajeConfianza.isAcceptableOrUnknown(
          data['puntaje_confianza']!,
          _puntajeConfianzaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_puntajeConfianzaMeta);
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
  RegistrosBiometrico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistrosBiometrico(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      trabajadorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}trabajador_id'],
          )!,
      foto:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}foto'],
          )!,
      datosBiometricos: $RegistrosBiometricosTable.$converterdatosBiometricos
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}datos_biometricos'],
            )!,
          ),
      pruebaVidaExitosa:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}prueba_vida_exitosa'],
          )!,
      metodoPruebaVida: $RegistrosBiometricosTable.$convertermetodoPruebaVida
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}metodo_prueba_vida'],
            )!,
          ),
      puntajeConfianza:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}puntaje_confianza'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $RegistrosBiometricosTable createAlias(String alias) {
    return $RegistrosBiometricosTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String>
  $converterdatosBiometricos = const JsonConverter();
  static TypeConverter<MetodoPruebaVida, String> $convertermetodoPruebaVida =
      const MetodoPruebaVidaConverter();
}

class RegistrosBiometrico extends DataClass
    implements Insertable<RegistrosBiometrico> {
  final int id;
  final int trabajadorId;
  final String foto;
  final Map<String, dynamic> datosBiometricos;
  final bool pruebaVidaExitosa;
  final MetodoPruebaVida metodoPruebaVida;
  final double puntajeConfianza;
  final bool estado;
  const RegistrosBiometrico({
    required this.id,
    required this.trabajadorId,
    required this.foto,
    required this.datosBiometricos,
    required this.pruebaVidaExitosa,
    required this.metodoPruebaVida,
    required this.puntajeConfianza,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trabajador_id'] = Variable<int>(trabajadorId);
    map['foto'] = Variable<String>(foto);
    {
      map['datos_biometricos'] = Variable<String>(
        $RegistrosBiometricosTable.$converterdatosBiometricos.toSql(
          datosBiometricos,
        ),
      );
    }
    map['prueba_vida_exitosa'] = Variable<bool>(pruebaVidaExitosa);
    {
      map['metodo_prueba_vida'] = Variable<String>(
        $RegistrosBiometricosTable.$convertermetodoPruebaVida.toSql(
          metodoPruebaVida,
        ),
      );
    }
    map['puntaje_confianza'] = Variable<double>(puntajeConfianza);
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  RegistrosBiometricosCompanion toCompanion(bool nullToAbsent) {
    return RegistrosBiometricosCompanion(
      id: Value(id),
      trabajadorId: Value(trabajadorId),
      foto: Value(foto),
      datosBiometricos: Value(datosBiometricos),
      pruebaVidaExitosa: Value(pruebaVidaExitosa),
      metodoPruebaVida: Value(metodoPruebaVida),
      puntajeConfianza: Value(puntajeConfianza),
      estado: Value(estado),
    );
  }

  factory RegistrosBiometrico.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistrosBiometrico(
      id: serializer.fromJson<int>(json['id']),
      trabajadorId: serializer.fromJson<int>(json['trabajadorId']),
      foto: serializer.fromJson<String>(json['foto']),
      datosBiometricos: serializer.fromJson<Map<String, dynamic>>(
        json['datosBiometricos'],
      ),
      pruebaVidaExitosa: serializer.fromJson<bool>(json['pruebaVidaExitosa']),
      metodoPruebaVida: serializer.fromJson<MetodoPruebaVida>(
        json['metodoPruebaVida'],
      ),
      puntajeConfianza: serializer.fromJson<double>(json['puntajeConfianza']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trabajadorId': serializer.toJson<int>(trabajadorId),
      'foto': serializer.toJson<String>(foto),
      'datosBiometricos': serializer.toJson<Map<String, dynamic>>(
        datosBiometricos,
      ),
      'pruebaVidaExitosa': serializer.toJson<bool>(pruebaVidaExitosa),
      'metodoPruebaVida': serializer.toJson<MetodoPruebaVida>(metodoPruebaVida),
      'puntajeConfianza': serializer.toJson<double>(puntajeConfianza),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  RegistrosBiometrico copyWith({
    int? id,
    int? trabajadorId,
    String? foto,
    Map<String, dynamic>? datosBiometricos,
    bool? pruebaVidaExitosa,
    MetodoPruebaVida? metodoPruebaVida,
    double? puntajeConfianza,
    bool? estado,
  }) => RegistrosBiometrico(
    id: id ?? this.id,
    trabajadorId: trabajadorId ?? this.trabajadorId,
    foto: foto ?? this.foto,
    datosBiometricos: datosBiometricos ?? this.datosBiometricos,
    pruebaVidaExitosa: pruebaVidaExitosa ?? this.pruebaVidaExitosa,
    metodoPruebaVida: metodoPruebaVida ?? this.metodoPruebaVida,
    puntajeConfianza: puntajeConfianza ?? this.puntajeConfianza,
    estado: estado ?? this.estado,
  );
  RegistrosBiometrico copyWithCompanion(RegistrosBiometricosCompanion data) {
    return RegistrosBiometrico(
      id: data.id.present ? data.id.value : this.id,
      trabajadorId:
          data.trabajadorId.present
              ? data.trabajadorId.value
              : this.trabajadorId,
      foto: data.foto.present ? data.foto.value : this.foto,
      datosBiometricos:
          data.datosBiometricos.present
              ? data.datosBiometricos.value
              : this.datosBiometricos,
      pruebaVidaExitosa:
          data.pruebaVidaExitosa.present
              ? data.pruebaVidaExitosa.value
              : this.pruebaVidaExitosa,
      metodoPruebaVida:
          data.metodoPruebaVida.present
              ? data.metodoPruebaVida.value
              : this.metodoPruebaVida,
      puntajeConfianza:
          data.puntajeConfianza.present
              ? data.puntajeConfianza.value
              : this.puntajeConfianza,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosBiometrico(')
          ..write('id: $id, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('foto: $foto, ')
          ..write('datosBiometricos: $datosBiometricos, ')
          ..write('pruebaVidaExitosa: $pruebaVidaExitosa, ')
          ..write('metodoPruebaVida: $metodoPruebaVida, ')
          ..write('puntajeConfianza: $puntajeConfianza, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trabajadorId,
    foto,
    datosBiometricos,
    pruebaVidaExitosa,
    metodoPruebaVida,
    puntajeConfianza,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistrosBiometrico &&
          other.id == this.id &&
          other.trabajadorId == this.trabajadorId &&
          other.foto == this.foto &&
          other.datosBiometricos == this.datosBiometricos &&
          other.pruebaVidaExitosa == this.pruebaVidaExitosa &&
          other.metodoPruebaVida == this.metodoPruebaVida &&
          other.puntajeConfianza == this.puntajeConfianza &&
          other.estado == this.estado);
}

class RegistrosBiometricosCompanion
    extends UpdateCompanion<RegistrosBiometrico> {
  final Value<int> id;
  final Value<int> trabajadorId;
  final Value<String> foto;
  final Value<Map<String, dynamic>> datosBiometricos;
  final Value<bool> pruebaVidaExitosa;
  final Value<MetodoPruebaVida> metodoPruebaVida;
  final Value<double> puntajeConfianza;
  final Value<bool> estado;
  const RegistrosBiometricosCompanion({
    this.id = const Value.absent(),
    this.trabajadorId = const Value.absent(),
    this.foto = const Value.absent(),
    this.datosBiometricos = const Value.absent(),
    this.pruebaVidaExitosa = const Value.absent(),
    this.metodoPruebaVida = const Value.absent(),
    this.puntajeConfianza = const Value.absent(),
    this.estado = const Value.absent(),
  });
  RegistrosBiometricosCompanion.insert({
    this.id = const Value.absent(),
    required int trabajadorId,
    required String foto,
    required Map<String, dynamic> datosBiometricos,
    required bool pruebaVidaExitosa,
    required MetodoPruebaVida metodoPruebaVida,
    required double puntajeConfianza,
    this.estado = const Value.absent(),
  }) : trabajadorId = Value(trabajadorId),
       foto = Value(foto),
       datosBiometricos = Value(datosBiometricos),
       pruebaVidaExitosa = Value(pruebaVidaExitosa),
       metodoPruebaVida = Value(metodoPruebaVida),
       puntajeConfianza = Value(puntajeConfianza);
  static Insertable<RegistrosBiometrico> custom({
    Expression<int>? id,
    Expression<int>? trabajadorId,
    Expression<String>? foto,
    Expression<String>? datosBiometricos,
    Expression<bool>? pruebaVidaExitosa,
    Expression<String>? metodoPruebaVida,
    Expression<double>? puntajeConfianza,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trabajadorId != null) 'trabajador_id': trabajadorId,
      if (foto != null) 'foto': foto,
      if (datosBiometricos != null) 'datos_biometricos': datosBiometricos,
      if (pruebaVidaExitosa != null) 'prueba_vida_exitosa': pruebaVidaExitosa,
      if (metodoPruebaVida != null) 'metodo_prueba_vida': metodoPruebaVida,
      if (puntajeConfianza != null) 'puntaje_confianza': puntajeConfianza,
      if (estado != null) 'estado': estado,
    });
  }

  RegistrosBiometricosCompanion copyWith({
    Value<int>? id,
    Value<int>? trabajadorId,
    Value<String>? foto,
    Value<Map<String, dynamic>>? datosBiometricos,
    Value<bool>? pruebaVidaExitosa,
    Value<MetodoPruebaVida>? metodoPruebaVida,
    Value<double>? puntajeConfianza,
    Value<bool>? estado,
  }) {
    return RegistrosBiometricosCompanion(
      id: id ?? this.id,
      trabajadorId: trabajadorId ?? this.trabajadorId,
      foto: foto ?? this.foto,
      datosBiometricos: datosBiometricos ?? this.datosBiometricos,
      pruebaVidaExitosa: pruebaVidaExitosa ?? this.pruebaVidaExitosa,
      metodoPruebaVida: metodoPruebaVida ?? this.metodoPruebaVida,
      puntajeConfianza: puntajeConfianza ?? this.puntajeConfianza,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trabajadorId.present) {
      map['trabajador_id'] = Variable<int>(trabajadorId.value);
    }
    if (foto.present) {
      map['foto'] = Variable<String>(foto.value);
    }
    if (datosBiometricos.present) {
      map['datos_biometricos'] = Variable<String>(
        $RegistrosBiometricosTable.$converterdatosBiometricos.toSql(
          datosBiometricos.value,
        ),
      );
    }
    if (pruebaVidaExitosa.present) {
      map['prueba_vida_exitosa'] = Variable<bool>(pruebaVidaExitosa.value);
    }
    if (metodoPruebaVida.present) {
      map['metodo_prueba_vida'] = Variable<String>(
        $RegistrosBiometricosTable.$convertermetodoPruebaVida.toSql(
          metodoPruebaVida.value,
        ),
      );
    }
    if (puntajeConfianza.present) {
      map['puntaje_confianza'] = Variable<double>(puntajeConfianza.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosBiometricosCompanion(')
          ..write('id: $id, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('foto: $foto, ')
          ..write('datosBiometricos: $datosBiometricos, ')
          ..write('pruebaVidaExitosa: $pruebaVidaExitosa, ')
          ..write('metodoPruebaVida: $metodoPruebaVida, ')
          ..write('puntajeConfianza: $puntajeConfianza, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $RegistrosDiariosTable extends RegistrosDiarios
    with TableInfo<$RegistrosDiariosTable, RegistrosDiario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistrosDiariosTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (equipo_id)',
    ),
  );
  static const VerificationMeta _registroBiometricoIdMeta =
      const VerificationMeta('registroBiometricoId');
  @override
  late final GeneratedColumn<String> registroBiometricoId =
      GeneratedColumn<String>(
        'registro_biometrico_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES registros_biometricos (id)',
        ),
      );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> fechaIngreso =
      GeneratedColumn<String>(
        'fecha_ingreso',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($RegistrosDiariosTable.$converterfechaIngreso);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> horaIngreso =
      GeneratedColumn<String>(
        'hora_ingreso',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($RegistrosDiariosTable.$converterhoraIngreso);
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> fechaSalida =
      GeneratedColumn<String>(
        'fecha_salida',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($RegistrosDiariosTable.$converterfechaSalida);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> horaSalida =
      GeneratedColumn<String>(
        'hora_salida',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($RegistrosDiariosTable.$converterhoraSalida);
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
    equipoId,
    registroBiometricoId,
    fechaIngreso,
    horaIngreso,
    fechaSalida,
    horaSalida,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registros_diarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegistrosDiario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipo_id')) {
      context.handle(
        _equipoIdMeta,
        equipoId.isAcceptableOrUnknown(data['equipo_id']!, _equipoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_equipoIdMeta);
    }
    if (data.containsKey('registro_biometrico_id')) {
      context.handle(
        _registroBiometricoIdMeta,
        registroBiometricoId.isAcceptableOrUnknown(
          data['registro_biometrico_id']!,
          _registroBiometricoIdMeta,
        ),
      );
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
  RegistrosDiario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistrosDiario(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      equipoId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}equipo_id'],
          )!,
      registroBiometricoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registro_biometrico_id'],
      ),
      fechaIngreso: $RegistrosDiariosTable.$converterfechaIngreso.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fecha_ingreso'],
        )!,
      ),
      horaIngreso: $RegistrosDiariosTable.$converterhoraIngreso.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hora_ingreso'],
        )!,
      ),
      fechaSalida: $RegistrosDiariosTable.$converterfechaSalida.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fecha_salida'],
        )!,
      ),
      horaSalida: $RegistrosDiariosTable.$converterhoraSalida.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hora_salida'],
        )!,
      ),
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $RegistrosDiariosTable createAlias(String alias) {
    return $RegistrosDiariosTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, String> $converterfechaIngreso =
      const DateConverter();
  static TypeConverter<TimeOfDay, String> $converterhoraIngreso =
      const TimeOfDayConverter();
  static TypeConverter<DateTime, String> $converterfechaSalida =
      const DateConverter();
  static TypeConverter<TimeOfDay, String> $converterhoraSalida =
      const TimeOfDayConverter();
}

class RegistrosDiario extends DataClass implements Insertable<RegistrosDiario> {
  final int id;
  final int equipoId;
  final String? registroBiometricoId;
  final DateTime fechaIngreso;
  final TimeOfDay horaIngreso;
  final DateTime fechaSalida;
  final TimeOfDay horaSalida;
  final bool estado;
  const RegistrosDiario({
    required this.id,
    required this.equipoId,
    this.registroBiometricoId,
    required this.fechaIngreso,
    required this.horaIngreso,
    required this.fechaSalida,
    required this.horaSalida,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipo_id'] = Variable<int>(equipoId);
    if (!nullToAbsent || registroBiometricoId != null) {
      map['registro_biometrico_id'] = Variable<String>(registroBiometricoId);
    }
    {
      map['fecha_ingreso'] = Variable<String>(
        $RegistrosDiariosTable.$converterfechaIngreso.toSql(fechaIngreso),
      );
    }
    {
      map['hora_ingreso'] = Variable<String>(
        $RegistrosDiariosTable.$converterhoraIngreso.toSql(horaIngreso),
      );
    }
    {
      map['fecha_salida'] = Variable<String>(
        $RegistrosDiariosTable.$converterfechaSalida.toSql(fechaSalida),
      );
    }
    {
      map['hora_salida'] = Variable<String>(
        $RegistrosDiariosTable.$converterhoraSalida.toSql(horaSalida),
      );
    }
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  RegistrosDiariosCompanion toCompanion(bool nullToAbsent) {
    return RegistrosDiariosCompanion(
      id: Value(id),
      equipoId: Value(equipoId),
      registroBiometricoId:
          registroBiometricoId == null && nullToAbsent
              ? const Value.absent()
              : Value(registroBiometricoId),
      fechaIngreso: Value(fechaIngreso),
      horaIngreso: Value(horaIngreso),
      fechaSalida: Value(fechaSalida),
      horaSalida: Value(horaSalida),
      estado: Value(estado),
    );
  }

  factory RegistrosDiario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistrosDiario(
      id: serializer.fromJson<int>(json['id']),
      equipoId: serializer.fromJson<int>(json['equipoId']),
      registroBiometricoId: serializer.fromJson<String?>(
        json['registroBiometricoId'],
      ),
      fechaIngreso: serializer.fromJson<DateTime>(json['fechaIngreso']),
      horaIngreso: serializer.fromJson<TimeOfDay>(json['horaIngreso']),
      fechaSalida: serializer.fromJson<DateTime>(json['fechaSalida']),
      horaSalida: serializer.fromJson<TimeOfDay>(json['horaSalida']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipoId': serializer.toJson<int>(equipoId),
      'registroBiometricoId': serializer.toJson<String?>(registroBiometricoId),
      'fechaIngreso': serializer.toJson<DateTime>(fechaIngreso),
      'horaIngreso': serializer.toJson<TimeOfDay>(horaIngreso),
      'fechaSalida': serializer.toJson<DateTime>(fechaSalida),
      'horaSalida': serializer.toJson<TimeOfDay>(horaSalida),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  RegistrosDiario copyWith({
    int? id,
    int? equipoId,
    Value<String?> registroBiometricoId = const Value.absent(),
    DateTime? fechaIngreso,
    TimeOfDay? horaIngreso,
    DateTime? fechaSalida,
    TimeOfDay? horaSalida,
    bool? estado,
  }) => RegistrosDiario(
    id: id ?? this.id,
    equipoId: equipoId ?? this.equipoId,
    registroBiometricoId:
        registroBiometricoId.present
            ? registroBiometricoId.value
            : this.registroBiometricoId,
    fechaIngreso: fechaIngreso ?? this.fechaIngreso,
    horaIngreso: horaIngreso ?? this.horaIngreso,
    fechaSalida: fechaSalida ?? this.fechaSalida,
    horaSalida: horaSalida ?? this.horaSalida,
    estado: estado ?? this.estado,
  );
  RegistrosDiario copyWithCompanion(RegistrosDiariosCompanion data) {
    return RegistrosDiario(
      id: data.id.present ? data.id.value : this.id,
      equipoId: data.equipoId.present ? data.equipoId.value : this.equipoId,
      registroBiometricoId:
          data.registroBiometricoId.present
              ? data.registroBiometricoId.value
              : this.registroBiometricoId,
      fechaIngreso:
          data.fechaIngreso.present
              ? data.fechaIngreso.value
              : this.fechaIngreso,
      horaIngreso:
          data.horaIngreso.present ? data.horaIngreso.value : this.horaIngreso,
      fechaSalida:
          data.fechaSalida.present ? data.fechaSalida.value : this.fechaSalida,
      horaSalida:
          data.horaSalida.present ? data.horaSalida.value : this.horaSalida,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosDiario(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('registroBiometricoId: $registroBiometricoId, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('horaIngreso: $horaIngreso, ')
          ..write('fechaSalida: $fechaSalida, ')
          ..write('horaSalida: $horaSalida, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    equipoId,
    registroBiometricoId,
    fechaIngreso,
    horaIngreso,
    fechaSalida,
    horaSalida,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistrosDiario &&
          other.id == this.id &&
          other.equipoId == this.equipoId &&
          other.registroBiometricoId == this.registroBiometricoId &&
          other.fechaIngreso == this.fechaIngreso &&
          other.horaIngreso == this.horaIngreso &&
          other.fechaSalida == this.fechaSalida &&
          other.horaSalida == this.horaSalida &&
          other.estado == this.estado);
}

class RegistrosDiariosCompanion extends UpdateCompanion<RegistrosDiario> {
  final Value<int> id;
  final Value<int> equipoId;
  final Value<String?> registroBiometricoId;
  final Value<DateTime> fechaIngreso;
  final Value<TimeOfDay> horaIngreso;
  final Value<DateTime> fechaSalida;
  final Value<TimeOfDay> horaSalida;
  final Value<bool> estado;
  const RegistrosDiariosCompanion({
    this.id = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.registroBiometricoId = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.horaIngreso = const Value.absent(),
    this.fechaSalida = const Value.absent(),
    this.horaSalida = const Value.absent(),
    this.estado = const Value.absent(),
  });
  RegistrosDiariosCompanion.insert({
    this.id = const Value.absent(),
    required int equipoId,
    this.registroBiometricoId = const Value.absent(),
    required DateTime fechaIngreso,
    required TimeOfDay horaIngreso,
    required DateTime fechaSalida,
    required TimeOfDay horaSalida,
    this.estado = const Value.absent(),
  }) : equipoId = Value(equipoId),
       fechaIngreso = Value(fechaIngreso),
       horaIngreso = Value(horaIngreso),
       fechaSalida = Value(fechaSalida),
       horaSalida = Value(horaSalida);
  static Insertable<RegistrosDiario> custom({
    Expression<int>? id,
    Expression<int>? equipoId,
    Expression<String>? registroBiometricoId,
    Expression<String>? fechaIngreso,
    Expression<String>? horaIngreso,
    Expression<String>? fechaSalida,
    Expression<String>? horaSalida,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipoId != null) 'equipo_id': equipoId,
      if (registroBiometricoId != null)
        'registro_biometrico_id': registroBiometricoId,
      if (fechaIngreso != null) 'fecha_ingreso': fechaIngreso,
      if (horaIngreso != null) 'hora_ingreso': horaIngreso,
      if (fechaSalida != null) 'fecha_salida': fechaSalida,
      if (horaSalida != null) 'hora_salida': horaSalida,
      if (estado != null) 'estado': estado,
    });
  }

  RegistrosDiariosCompanion copyWith({
    Value<int>? id,
    Value<int>? equipoId,
    Value<String?>? registroBiometricoId,
    Value<DateTime>? fechaIngreso,
    Value<TimeOfDay>? horaIngreso,
    Value<DateTime>? fechaSalida,
    Value<TimeOfDay>? horaSalida,
    Value<bool>? estado,
  }) {
    return RegistrosDiariosCompanion(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      registroBiometricoId: registroBiometricoId ?? this.registroBiometricoId,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      horaIngreso: horaIngreso ?? this.horaIngreso,
      fechaSalida: fechaSalida ?? this.fechaSalida,
      horaSalida: horaSalida ?? this.horaSalida,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipoId.present) {
      map['equipo_id'] = Variable<int>(equipoId.value);
    }
    if (registroBiometricoId.present) {
      map['registro_biometrico_id'] = Variable<String>(
        registroBiometricoId.value,
      );
    }
    if (fechaIngreso.present) {
      map['fecha_ingreso'] = Variable<String>(
        $RegistrosDiariosTable.$converterfechaIngreso.toSql(fechaIngreso.value),
      );
    }
    if (horaIngreso.present) {
      map['hora_ingreso'] = Variable<String>(
        $RegistrosDiariosTable.$converterhoraIngreso.toSql(horaIngreso.value),
      );
    }
    if (fechaSalida.present) {
      map['fecha_salida'] = Variable<String>(
        $RegistrosDiariosTable.$converterfechaSalida.toSql(fechaSalida.value),
      );
    }
    if (horaSalida.present) {
      map['hora_salida'] = Variable<String>(
        $RegistrosDiariosTable.$converterhoraSalida.toSql(horaSalida.value),
      );
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosDiariosCompanion(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('registroBiometricoId: $registroBiometricoId, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('horaIngreso: $horaIngreso, ')
          ..write('fechaSalida: $fechaSalida, ')
          ..write('horaSalida: $horaSalida, ')
          ..write('estado: $estado')
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
  late final $RegistrosBiometricosTable registrosBiometricos =
      $RegistrosBiometricosTable(this);
  late final $RegistrosDiariosTable registrosDiarios = $RegistrosDiariosTable(
    this,
  );
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
    registrosBiometricos,
    registrosDiarios,
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
      Value<bool> faceSync,
      required String fotoUrl,
    });
typedef $$TrabajadoresTableUpdateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> primerApellido,
      Value<String> segundoApellido,
      Value<int> equipoId,
      Value<bool> estado,
      Value<bool> faceSync,
      Value<String> fotoUrl,
    });

final class $$TrabajadoresTableReferences
    extends BaseReferences<_$AppDatabase, $TrabajadoresTable, Trabajadore> {
  $$TrabajadoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $RegistrosBiometricosTable,
    List<RegistrosBiometrico>
  >
  _registrosBiometricosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.registrosBiometricos,
        aliasName: $_aliasNameGenerator(
          db.trabajadores.equipoId,
          db.registrosBiometricos.trabajadorId,
        ),
      );

  $$RegistrosBiometricosTableProcessedTableManager
  get registrosBiometricosRefs {
    final manager = $$RegistrosBiometricosTableTableManager(
      $_db,
      $_db.registrosBiometricos,
    ).filter(
      (f) => f.trabajadorId.equipoId.sqlEquals($_itemColumn<int>('equipo_id')!),
    );

    final cache = $_typedResult.readTableOrNull(
      _registrosBiometricosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RegistrosDiariosTable, List<RegistrosDiario>>
  _registrosDiariosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registrosDiarios,
    aliasName: $_aliasNameGenerator(
      db.trabajadores.equipoId,
      db.registrosDiarios.equipoId,
    ),
  );

  $$RegistrosDiariosTableProcessedTableManager get registrosDiariosRefs {
    final manager = $$RegistrosDiariosTableTableManager(
      $_db,
      $_db.registrosDiarios,
    ).filter(
      (f) => f.equipoId.equipoId.sqlEquals($_itemColumn<int>('equipo_id')!),
    );

    final cache = $_typedResult.readTableOrNull(
      _registrosDiariosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<bool> get faceSync => $composableBuilder(
    column: $table.faceSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotoUrl => $composableBuilder(
    column: $table.fotoUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> registrosBiometricosRefs(
    Expression<bool> Function($$RegistrosBiometricosTableFilterComposer f) f,
  ) {
    final $$RegistrosBiometricosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.registrosBiometricos,
      getReferencedColumn: (t) => t.trabajadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosBiometricosTableFilterComposer(
            $db: $db,
            $table: $db.registrosBiometricos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> registrosDiariosRefs(
    Expression<bool> Function($$RegistrosDiariosTableFilterComposer f) f,
  ) {
    final $$RegistrosDiariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.registrosDiarios,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosDiariosTableFilterComposer(
            $db: $db,
            $table: $db.registrosDiarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<bool> get faceSync => $composableBuilder(
    column: $table.faceSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotoUrl => $composableBuilder(
    column: $table.fotoUrl,
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

  GeneratedColumn<bool> get faceSync =>
      $composableBuilder(column: $table.faceSync, builder: (column) => column);

  GeneratedColumn<String> get fotoUrl =>
      $composableBuilder(column: $table.fotoUrl, builder: (column) => column);

  Expression<T> registrosBiometricosRefs<T extends Object>(
    Expression<T> Function($$RegistrosBiometricosTableAnnotationComposer a) f,
  ) {
    final $$RegistrosBiometricosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.equipoId,
          referencedTable: $db.registrosBiometricos,
          getReferencedColumn: (t) => t.trabajadorId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RegistrosBiometricosTableAnnotationComposer(
                $db: $db,
                $table: $db.registrosBiometricos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> registrosDiariosRefs<T extends Object>(
    Expression<T> Function($$RegistrosDiariosTableAnnotationComposer a) f,
  ) {
    final $$RegistrosDiariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.registrosDiarios,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosDiariosTableAnnotationComposer(
            $db: $db,
            $table: $db.registrosDiarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Trabajadore, $$TrabajadoresTableReferences),
          Trabajadore,
          PrefetchHooks Function({
            bool registrosBiometricosRefs,
            bool registrosDiariosRefs,
          })
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
                Value<bool> faceSync = const Value.absent(),
                Value<String> fotoUrl = const Value.absent(),
              }) => TrabajadoresCompanion(
                id: id,
                nombre: nombre,
                primerApellido: primerApellido,
                segundoApellido: segundoApellido,
                equipoId: equipoId,
                estado: estado,
                faceSync: faceSync,
                fotoUrl: fotoUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String primerApellido,
                required String segundoApellido,
                required int equipoId,
                Value<bool> estado = const Value.absent(),
                Value<bool> faceSync = const Value.absent(),
                required String fotoUrl,
              }) => TrabajadoresCompanion.insert(
                id: id,
                nombre: nombre,
                primerApellido: primerApellido,
                segundoApellido: segundoApellido,
                equipoId: equipoId,
                estado: estado,
                faceSync: faceSync,
                fotoUrl: fotoUrl,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TrabajadoresTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            registrosBiometricosRefs = false,
            registrosDiariosRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (registrosBiometricosRefs) db.registrosBiometricos,
                if (registrosDiariosRefs) db.registrosDiarios,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (registrosBiometricosRefs)
                    await $_getPrefetchedData<
                      Trabajadore,
                      $TrabajadoresTable,
                      RegistrosBiometrico
                    >(
                      currentTable: table,
                      referencedTable: $$TrabajadoresTableReferences
                          ._registrosBiometricosRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TrabajadoresTableReferences(
                                db,
                                table,
                                p0,
                              ).registrosBiometricosRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.trabajadorId == item.equipoId,
                          ),
                      typedResults: items,
                    ),
                  if (registrosDiariosRefs)
                    await $_getPrefetchedData<
                      Trabajadore,
                      $TrabajadoresTable,
                      RegistrosDiario
                    >(
                      currentTable: table,
                      referencedTable: $$TrabajadoresTableReferences
                          ._registrosDiariosRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TrabajadoresTableReferences(
                                db,
                                table,
                                p0,
                              ).registrosDiariosRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.equipoId == item.equipoId,
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
      (Trabajadore, $$TrabajadoresTableReferences),
      Trabajadore,
      PrefetchHooks Function({
        bool registrosBiometricosRefs,
        bool registrosDiariosRefs,
      })
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
typedef $$RegistrosBiometricosTableCreateCompanionBuilder =
    RegistrosBiometricosCompanion Function({
      Value<int> id,
      required int trabajadorId,
      required String foto,
      required Map<String, dynamic> datosBiometricos,
      required bool pruebaVidaExitosa,
      required MetodoPruebaVida metodoPruebaVida,
      required double puntajeConfianza,
      Value<bool> estado,
    });
typedef $$RegistrosBiometricosTableUpdateCompanionBuilder =
    RegistrosBiometricosCompanion Function({
      Value<int> id,
      Value<int> trabajadorId,
      Value<String> foto,
      Value<Map<String, dynamic>> datosBiometricos,
      Value<bool> pruebaVidaExitosa,
      Value<MetodoPruebaVida> metodoPruebaVida,
      Value<double> puntajeConfianza,
      Value<bool> estado,
    });

final class $$RegistrosBiometricosTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RegistrosBiometricosTable,
          RegistrosBiometrico
        > {
  $$RegistrosBiometricosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrabajadoresTable _trabajadorIdTable(_$AppDatabase db) =>
      db.trabajadores.createAlias(
        $_aliasNameGenerator(
          db.registrosBiometricos.trabajadorId,
          db.trabajadores.equipoId,
        ),
      );

  $$TrabajadoresTableProcessedTableManager get trabajadorId {
    final $_column = $_itemColumn<int>('trabajador_id')!;

    final manager = $$TrabajadoresTableTableManager(
      $_db,
      $_db.trabajadores,
    ).filter((f) => f.equipoId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trabajadorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegistrosBiometricosTableFilterComposer
    extends Composer<_$AppDatabase, $RegistrosBiometricosTable> {
  $$RegistrosBiometricosTableFilterComposer({
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

  ColumnFilters<String> get foto => $composableBuilder(
    column: $table.foto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get datosBiometricos => $composableBuilder(
    column: $table.datosBiometricos,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get pruebaVidaExitosa => $composableBuilder(
    column: $table.pruebaVidaExitosa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MetodoPruebaVida, MetodoPruebaVida, String>
  get metodoPruebaVida => $composableBuilder(
    column: $table.metodoPruebaVida,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get puntajeConfianza => $composableBuilder(
    column: $table.puntajeConfianza,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  $$TrabajadoresTableFilterComposer get trabajadorId {
    final $$TrabajadoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trabajadorId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableFilterComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosBiometricosTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistrosBiometricosTable> {
  $$RegistrosBiometricosTableOrderingComposer({
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

  ColumnOrderings<String> get foto => $composableBuilder(
    column: $table.foto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get datosBiometricos => $composableBuilder(
    column: $table.datosBiometricos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pruebaVidaExitosa => $composableBuilder(
    column: $table.pruebaVidaExitosa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodoPruebaVida => $composableBuilder(
    column: $table.metodoPruebaVida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get puntajeConfianza => $composableBuilder(
    column: $table.puntajeConfianza,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrabajadoresTableOrderingComposer get trabajadorId {
    final $$TrabajadoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trabajadorId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableOrderingComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosBiometricosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistrosBiometricosTable> {
  $$RegistrosBiometricosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foto =>
      $composableBuilder(column: $table.foto, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get datosBiometricos => $composableBuilder(
    column: $table.datosBiometricos,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pruebaVidaExitosa => $composableBuilder(
    column: $table.pruebaVidaExitosa,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MetodoPruebaVida, String>
  get metodoPruebaVida => $composableBuilder(
    column: $table.metodoPruebaVida,
    builder: (column) => column,
  );

  GeneratedColumn<double> get puntajeConfianza => $composableBuilder(
    column: $table.puntajeConfianza,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  $$TrabajadoresTableAnnotationComposer get trabajadorId {
    final $$TrabajadoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trabajadorId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableAnnotationComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosBiometricosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistrosBiometricosTable,
          RegistrosBiometrico,
          $$RegistrosBiometricosTableFilterComposer,
          $$RegistrosBiometricosTableOrderingComposer,
          $$RegistrosBiometricosTableAnnotationComposer,
          $$RegistrosBiometricosTableCreateCompanionBuilder,
          $$RegistrosBiometricosTableUpdateCompanionBuilder,
          (RegistrosBiometrico, $$RegistrosBiometricosTableReferences),
          RegistrosBiometrico,
          PrefetchHooks Function({bool trabajadorId})
        > {
  $$RegistrosBiometricosTableTableManager(
    _$AppDatabase db,
    $RegistrosBiometricosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RegistrosBiometricosTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$RegistrosBiometricosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$RegistrosBiometricosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trabajadorId = const Value.absent(),
                Value<String> foto = const Value.absent(),
                Value<Map<String, dynamic>> datosBiometricos =
                    const Value.absent(),
                Value<bool> pruebaVidaExitosa = const Value.absent(),
                Value<MetodoPruebaVida> metodoPruebaVida = const Value.absent(),
                Value<double> puntajeConfianza = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => RegistrosBiometricosCompanion(
                id: id,
                trabajadorId: trabajadorId,
                foto: foto,
                datosBiometricos: datosBiometricos,
                pruebaVidaExitosa: pruebaVidaExitosa,
                metodoPruebaVida: metodoPruebaVida,
                puntajeConfianza: puntajeConfianza,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trabajadorId,
                required String foto,
                required Map<String, dynamic> datosBiometricos,
                required bool pruebaVidaExitosa,
                required MetodoPruebaVida metodoPruebaVida,
                required double puntajeConfianza,
                Value<bool> estado = const Value.absent(),
              }) => RegistrosBiometricosCompanion.insert(
                id: id,
                trabajadorId: trabajadorId,
                foto: foto,
                datosBiometricos: datosBiometricos,
                pruebaVidaExitosa: pruebaVidaExitosa,
                metodoPruebaVida: metodoPruebaVida,
                puntajeConfianza: puntajeConfianza,
                estado: estado,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RegistrosBiometricosTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({trabajadorId = false}) {
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
                if (trabajadorId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.trabajadorId,
                            referencedTable:
                                $$RegistrosBiometricosTableReferences
                                    ._trabajadorIdTable(db),
                            referencedColumn:
                                $$RegistrosBiometricosTableReferences
                                    ._trabajadorIdTable(db)
                                    .equipoId,
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

typedef $$RegistrosBiometricosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistrosBiometricosTable,
      RegistrosBiometrico,
      $$RegistrosBiometricosTableFilterComposer,
      $$RegistrosBiometricosTableOrderingComposer,
      $$RegistrosBiometricosTableAnnotationComposer,
      $$RegistrosBiometricosTableCreateCompanionBuilder,
      $$RegistrosBiometricosTableUpdateCompanionBuilder,
      (RegistrosBiometrico, $$RegistrosBiometricosTableReferences),
      RegistrosBiometrico,
      PrefetchHooks Function({bool trabajadorId})
    >;
typedef $$RegistrosDiariosTableCreateCompanionBuilder =
    RegistrosDiariosCompanion Function({
      Value<int> id,
      required int equipoId,
      Value<String?> registroBiometricoId,
      required DateTime fechaIngreso,
      required TimeOfDay horaIngreso,
      required DateTime fechaSalida,
      required TimeOfDay horaSalida,
      Value<bool> estado,
    });
typedef $$RegistrosDiariosTableUpdateCompanionBuilder =
    RegistrosDiariosCompanion Function({
      Value<int> id,
      Value<int> equipoId,
      Value<String?> registroBiometricoId,
      Value<DateTime> fechaIngreso,
      Value<TimeOfDay> horaIngreso,
      Value<DateTime> fechaSalida,
      Value<TimeOfDay> horaSalida,
      Value<bool> estado,
    });

final class $$RegistrosDiariosTableReferences
    extends
        BaseReferences<_$AppDatabase, $RegistrosDiariosTable, RegistrosDiario> {
  $$RegistrosDiariosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrabajadoresTable _equipoIdTable(_$AppDatabase db) =>
      db.trabajadores.createAlias(
        $_aliasNameGenerator(
          db.registrosDiarios.equipoId,
          db.trabajadores.equipoId,
        ),
      );

  $$TrabajadoresTableProcessedTableManager get equipoId {
    final $_column = $_itemColumn<int>('equipo_id')!;

    final manager = $$TrabajadoresTableTableManager(
      $_db,
      $_db.trabajadores,
    ).filter((f) => f.equipoId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_equipoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegistrosDiariosTableFilterComposer
    extends Composer<_$AppDatabase, $RegistrosDiariosTable> {
  $$RegistrosDiariosTableFilterComposer({
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

  ColumnWithTypeConverterFilters<DateTime, DateTime, String> get fechaIngreso =>
      $composableBuilder(
        column: $table.fechaIngreso,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, String>
  get horaIngreso => $composableBuilder(
    column: $table.horaIngreso,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, String> get fechaSalida =>
      $composableBuilder(
        column: $table.fechaSalida,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TimeOfDay, TimeOfDay, String> get horaSalida =>
      $composableBuilder(
        column: $table.horaSalida,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  $$TrabajadoresTableFilterComposer get equipoId {
    final $$TrabajadoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableFilterComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosDiariosTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistrosDiariosTable> {
  $$RegistrosDiariosTableOrderingComposer({
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

  ColumnOrderings<String> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaIngreso => $composableBuilder(
    column: $table.horaIngreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaSalida => $composableBuilder(
    column: $table.fechaSalida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaSalida => $composableBuilder(
    column: $table.horaSalida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrabajadoresTableOrderingComposer get equipoId {
    final $$TrabajadoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableOrderingComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosDiariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistrosDiariosTable> {
  $$RegistrosDiariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, String> get fechaIngreso =>
      $composableBuilder(
        column: $table.fechaIngreso,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<TimeOfDay, String> get horaIngreso =>
      $composableBuilder(
        column: $table.horaIngreso,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<DateTime, String> get fechaSalida =>
      $composableBuilder(
        column: $table.fechaSalida,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<TimeOfDay, String> get horaSalida =>
      $composableBuilder(
        column: $table.horaSalida,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  $$TrabajadoresTableAnnotationComposer get equipoId {
    final $$TrabajadoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableAnnotationComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosDiariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistrosDiariosTable,
          RegistrosDiario,
          $$RegistrosDiariosTableFilterComposer,
          $$RegistrosDiariosTableOrderingComposer,
          $$RegistrosDiariosTableAnnotationComposer,
          $$RegistrosDiariosTableCreateCompanionBuilder,
          $$RegistrosDiariosTableUpdateCompanionBuilder,
          (RegistrosDiario, $$RegistrosDiariosTableReferences),
          RegistrosDiario,
          PrefetchHooks Function({bool equipoId})
        > {
  $$RegistrosDiariosTableTableManager(
    _$AppDatabase db,
    $RegistrosDiariosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$RegistrosDiariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RegistrosDiariosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$RegistrosDiariosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> equipoId = const Value.absent(),
                Value<String?> registroBiometricoId = const Value.absent(),
                Value<DateTime> fechaIngreso = const Value.absent(),
                Value<TimeOfDay> horaIngreso = const Value.absent(),
                Value<DateTime> fechaSalida = const Value.absent(),
                Value<TimeOfDay> horaSalida = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => RegistrosDiariosCompanion(
                id: id,
                equipoId: equipoId,
                registroBiometricoId: registroBiometricoId,
                fechaIngreso: fechaIngreso,
                horaIngreso: horaIngreso,
                fechaSalida: fechaSalida,
                horaSalida: horaSalida,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int equipoId,
                Value<String?> registroBiometricoId = const Value.absent(),
                required DateTime fechaIngreso,
                required TimeOfDay horaIngreso,
                required DateTime fechaSalida,
                required TimeOfDay horaSalida,
                Value<bool> estado = const Value.absent(),
              }) => RegistrosDiariosCompanion.insert(
                id: id,
                equipoId: equipoId,
                registroBiometricoId: registroBiometricoId,
                fechaIngreso: fechaIngreso,
                horaIngreso: horaIngreso,
                fechaSalida: fechaSalida,
                horaSalida: horaSalida,
                estado: estado,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RegistrosDiariosTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({equipoId = false}) {
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
                if (equipoId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.equipoId,
                            referencedTable: $$RegistrosDiariosTableReferences
                                ._equipoIdTable(db),
                            referencedColumn:
                                $$RegistrosDiariosTableReferences
                                    ._equipoIdTable(db)
                                    .equipoId,
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

typedef $$RegistrosDiariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistrosDiariosTable,
      RegistrosDiario,
      $$RegistrosDiariosTableFilterComposer,
      $$RegistrosDiariosTableOrderingComposer,
      $$RegistrosDiariosTableAnnotationComposer,
      $$RegistrosDiariosTableCreateCompanionBuilder,
      $$RegistrosDiariosTableUpdateCompanionBuilder,
      (RegistrosDiario, $$RegistrosDiariosTableReferences),
      RegistrosDiario,
      PrefetchHooks Function({bool equipoId})
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
  $$RegistrosBiometricosTableTableManager get registrosBiometricos =>
      $$RegistrosBiometricosTableTableManager(_db, _db.registrosBiometricos);
  $$RegistrosDiariosTableTableManager get registrosDiarios =>
      $$RegistrosDiariosTableTableManager(_db, _db.registrosDiarios);
  $$SyncsEntitysTableTableManager get syncsEntitys =>
      $$SyncsEntitysTableTableManager(_db, _db.syncsEntitys);
}
