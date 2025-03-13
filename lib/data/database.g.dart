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
  static const VerificationMeta _apellidoMeta = const VerificationMeta(
    'apellido',
  );
  @override
  late final GeneratedColumn<String> apellido = GeneratedColumn<String>(
    'apellido',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cedulaMeta = const VerificationMeta('cedula');
  @override
  late final GeneratedColumn<String> cedula = GeneratedColumn<String>(
    'cedula',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ultimaActualizacionMeta =
      const VerificationMeta('ultimaActualizacion');
  @override
  late final GeneratedColumn<DateTime> ultimaActualizacion =
      GeneratedColumn<DateTime>(
        'ultima_actualizacion',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    apellido,
    cedula,
    activo,
    ultimaActualizacion,
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
    if (data.containsKey('apellido')) {
      context.handle(
        _apellidoMeta,
        apellido.isAcceptableOrUnknown(data['apellido']!, _apellidoMeta),
      );
    } else if (isInserting) {
      context.missing(_apellidoMeta);
    }
    if (data.containsKey('cedula')) {
      context.handle(
        _cedulaMeta,
        cedula.isAcceptableOrUnknown(data['cedula']!, _cedulaMeta),
      );
    } else if (isInserting) {
      context.missing(_cedulaMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('ultima_actualizacion')) {
      context.handle(
        _ultimaActualizacionMeta,
        ultimaActualizacion.isAcceptableOrUnknown(
          data['ultima_actualizacion']!,
          _ultimaActualizacionMeta,
        ),
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
      apellido:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}apellido'],
          )!,
      cedula:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}cedula'],
          )!,
      activo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}activo'],
          )!,
      ultimaActualizacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ultima_actualizacion'],
      ),
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
  final String apellido;
  final String cedula;
  final bool activo;
  final DateTime? ultimaActualizacion;
  const Trabajadore({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.activo,
    this.ultimaActualizacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['apellido'] = Variable<String>(apellido);
    map['cedula'] = Variable<String>(cedula);
    map['activo'] = Variable<bool>(activo);
    if (!nullToAbsent || ultimaActualizacion != null) {
      map['ultima_actualizacion'] = Variable<DateTime>(ultimaActualizacion);
    }
    return map;
  }

  TrabajadoresCompanion toCompanion(bool nullToAbsent) {
    return TrabajadoresCompanion(
      id: Value(id),
      nombre: Value(nombre),
      apellido: Value(apellido),
      cedula: Value(cedula),
      activo: Value(activo),
      ultimaActualizacion:
          ultimaActualizacion == null && nullToAbsent
              ? const Value.absent()
              : Value(ultimaActualizacion),
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
      apellido: serializer.fromJson<String>(json['apellido']),
      cedula: serializer.fromJson<String>(json['cedula']),
      activo: serializer.fromJson<bool>(json['activo']),
      ultimaActualizacion: serializer.fromJson<DateTime?>(
        json['ultimaActualizacion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'apellido': serializer.toJson<String>(apellido),
      'cedula': serializer.toJson<String>(cedula),
      'activo': serializer.toJson<bool>(activo),
      'ultimaActualizacion': serializer.toJson<DateTime?>(ultimaActualizacion),
    };
  }

  Trabajadore copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? cedula,
    bool? activo,
    Value<DateTime?> ultimaActualizacion = const Value.absent(),
  }) => Trabajadore(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    apellido: apellido ?? this.apellido,
    cedula: cedula ?? this.cedula,
    activo: activo ?? this.activo,
    ultimaActualizacion:
        ultimaActualizacion.present
            ? ultimaActualizacion.value
            : this.ultimaActualizacion,
  );
  Trabajadore copyWithCompanion(TrabajadoresCompanion data) {
    return Trabajadore(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellido: data.apellido.present ? data.apellido.value : this.apellido,
      cedula: data.cedula.present ? data.cedula.value : this.cedula,
      activo: data.activo.present ? data.activo.value : this.activo,
      ultimaActualizacion:
          data.ultimaActualizacion.present
              ? data.ultimaActualizacion.value
              : this.ultimaActualizacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajadore(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('cedula: $cedula, ')
          ..write('activo: $activo, ')
          ..write('ultimaActualizacion: $ultimaActualizacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, apellido, cedula, activo, ultimaActualizacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajadore &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.apellido == this.apellido &&
          other.cedula == this.cedula &&
          other.activo == this.activo &&
          other.ultimaActualizacion == this.ultimaActualizacion);
}

class TrabajadoresCompanion extends UpdateCompanion<Trabajadore> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> apellido;
  final Value<String> cedula;
  final Value<bool> activo;
  final Value<DateTime?> ultimaActualizacion;
  const TrabajadoresCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.cedula = const Value.absent(),
    this.activo = const Value.absent(),
    this.ultimaActualizacion = const Value.absent(),
  });
  TrabajadoresCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String apellido,
    required String cedula,
    this.activo = const Value.absent(),
    this.ultimaActualizacion = const Value.absent(),
  }) : nombre = Value(nombre),
       apellido = Value(apellido),
       cedula = Value(cedula);
  static Insertable<Trabajadore> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? apellido,
    Expression<String>? cedula,
    Expression<bool>? activo,
    Expression<DateTime>? ultimaActualizacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (cedula != null) 'cedula': cedula,
      if (activo != null) 'activo': activo,
      if (ultimaActualizacion != null)
        'ultima_actualizacion': ultimaActualizacion,
    });
  }

  TrabajadoresCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? apellido,
    Value<String>? cedula,
    Value<bool>? activo,
    Value<DateTime?>? ultimaActualizacion,
  }) {
    return TrabajadoresCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      cedula: cedula ?? this.cedula,
      activo: activo ?? this.activo,
      ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
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
    if (apellido.present) {
      map['apellido'] = Variable<String>(apellido.value);
    }
    if (cedula.present) {
      map['cedula'] = Variable<String>(cedula.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (ultimaActualizacion.present) {
      map['ultima_actualizacion'] = Variable<DateTime>(
        ultimaActualizacion.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajadoresCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('cedula: $cedula, ')
          ..write('activo: $activo, ')
          ..write('ultimaActualizacion: $ultimaActualizacion')
          ..write(')'))
        .toString();
  }
}

class $GrupoUbicacionesTable extends GrupoUbicaciones
    with TableInfo<$GrupoUbicacionesTable, GrupoUbicacione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrupoUbicacionesTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grupo_ubicaciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrupoUbicacione> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrupoUbicacione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrupoUbicacione(
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
    );
  }

  @override
  $GrupoUbicacionesTable createAlias(String alias) {
    return $GrupoUbicacionesTable(attachedDatabase, alias);
  }
}

class GrupoUbicacione extends DataClass implements Insertable<GrupoUbicacione> {
  final int id;
  final String nombre;
  const GrupoUbicacione({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  GrupoUbicacionesCompanion toCompanion(bool nullToAbsent) {
    return GrupoUbicacionesCompanion(id: Value(id), nombre: Value(nombre));
  }

  factory GrupoUbicacione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrupoUbicacione(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  GrupoUbicacione copyWith({int? id, String? nombre}) =>
      GrupoUbicacione(id: id ?? this.id, nombre: nombre ?? this.nombre);
  GrupoUbicacione copyWithCompanion(GrupoUbicacionesCompanion data) {
    return GrupoUbicacione(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrupoUbicacione(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrupoUbicacione &&
          other.id == this.id &&
          other.nombre == this.nombre);
}

class GrupoUbicacionesCompanion extends UpdateCompanion<GrupoUbicacione> {
  final Value<int> id;
  final Value<String> nombre;
  const GrupoUbicacionesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  GrupoUbicacionesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<GrupoUbicacione> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  GrupoUbicacionesCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return GrupoUbicacionesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrupoUbicacionesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
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
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  disponibilidad = GeneratedColumn<String>(
    'disponibilidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>(
    $UbicacionesTable.$converterdisponibilidad,
  );
  static const VerificationMeta _grupoIdMeta = const VerificationMeta(
    'grupoId',
  );
  @override
  late final GeneratedColumn<String> grupoId = GeneratedColumn<String>(
    'grupo_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grupo_ubicaciones (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, disponibilidad, grupoId];
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
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('grupo_id')) {
      context.handle(
        _grupoIdMeta,
        grupoId.isAcceptableOrUnknown(data['grupo_id']!, _grupoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_grupoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ubicacione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ubicacione(
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
      disponibilidad: $UbicacionesTable.$converterdisponibilidad.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}disponibilidad'],
        )!,
      ),
      grupoId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}grupo_id'],
          )!,
    );
  }

  @override
  $UbicacionesTable createAlias(String alias) {
    return $UbicacionesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterdisponibilidad =
      const JsonConverter();
}

class Ubicacione extends DataClass implements Insertable<Ubicacione> {
  final int id;
  final String nombre;
  final Map<String, dynamic> disponibilidad;
  final String grupoId;
  const Ubicacione({
    required this.id,
    required this.nombre,
    required this.disponibilidad,
    required this.grupoId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    {
      map['disponibilidad'] = Variable<String>(
        $UbicacionesTable.$converterdisponibilidad.toSql(disponibilidad),
      );
    }
    map['grupo_id'] = Variable<String>(grupoId);
    return map;
  }

  UbicacionesCompanion toCompanion(bool nullToAbsent) {
    return UbicacionesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      disponibilidad: Value(disponibilidad),
      grupoId: Value(grupoId),
    );
  }

  factory Ubicacione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ubicacione(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      disponibilidad: serializer.fromJson<Map<String, dynamic>>(
        json['disponibilidad'],
      ),
      grupoId: serializer.fromJson<String>(json['grupoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'disponibilidad': serializer.toJson<Map<String, dynamic>>(disponibilidad),
      'grupoId': serializer.toJson<String>(grupoId),
    };
  }

  Ubicacione copyWith({
    int? id,
    String? nombre,
    Map<String, dynamic>? disponibilidad,
    String? grupoId,
  }) => Ubicacione(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    disponibilidad: disponibilidad ?? this.disponibilidad,
    grupoId: grupoId ?? this.grupoId,
  );
  Ubicacione copyWithCompanion(UbicacionesCompanion data) {
    return Ubicacione(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      disponibilidad:
          data.disponibilidad.present
              ? data.disponibilidad.value
              : this.disponibilidad,
      grupoId: data.grupoId.present ? data.grupoId.value : this.grupoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ubicacione(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('disponibilidad: $disponibilidad, ')
          ..write('grupoId: $grupoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, disponibilidad, grupoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ubicacione &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.disponibilidad == this.disponibilidad &&
          other.grupoId == this.grupoId);
}

class UbicacionesCompanion extends UpdateCompanion<Ubicacione> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<Map<String, dynamic>> disponibilidad;
  final Value<String> grupoId;
  const UbicacionesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.disponibilidad = const Value.absent(),
    this.grupoId = const Value.absent(),
  });
  UbicacionesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required Map<String, dynamic> disponibilidad,
    required String grupoId,
  }) : nombre = Value(nombre),
       disponibilidad = Value(disponibilidad),
       grupoId = Value(grupoId);
  static Insertable<Ubicacione> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? disponibilidad,
    Expression<String>? grupoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (disponibilidad != null) 'disponibilidad': disponibilidad,
      if (grupoId != null) 'grupo_id': grupoId,
    });
  }

  UbicacionesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<Map<String, dynamic>>? disponibilidad,
    Value<String>? grupoId,
  }) {
    return UbicacionesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      disponibilidad: disponibilidad ?? this.disponibilidad,
      grupoId: grupoId ?? this.grupoId,
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
    if (disponibilidad.present) {
      map['disponibilidad'] = Variable<String>(
        $UbicacionesTable.$converterdisponibilidad.toSql(disponibilidad.value),
      );
    }
    if (grupoId.present) {
      map['grupo_id'] = Variable<String>(grupoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UbicacionesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('disponibilidad: $disponibilidad, ')
          ..write('grupoId: $grupoId')
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
  late final GeneratedColumn<String> ubicacionId = GeneratedColumn<String>(
    'ubicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ubicaciones (id)',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ubicacionId,
    fechaInicio,
    fechaFin,
    horaInicio,
    horaFin,
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
            DriftSqlType.string,
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
}

class HorariosCompanion extends UpdateCompanion<Horario> {
  final Value<int> id;
  final Value<String> ubicacionId;
  final Value<DateTime> fechaInicio;
  final Value<DateTime> fechaFin;
  final Value<TimeOfDay> horaInicio;
  final Value<TimeOfDay> horaFin;
  const HorariosCompanion({
    this.id = const Value.absent(),
    this.ubicacionId = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.fechaFin = const Value.absent(),
    this.horaInicio = const Value.absent(),
    this.horaFin = const Value.absent(),
  });
  HorariosCompanion.insert({
    this.id = const Value.absent(),
    required String ubicacionId,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    required TimeOfDay horaInicio,
    required TimeOfDay horaFin,
  }) : ubicacionId = Value(ubicacionId),
       fechaInicio = Value(fechaInicio),
       fechaFin = Value(fechaFin),
       horaInicio = Value(horaInicio),
       horaFin = Value(horaFin);
  static Insertable<Horario> custom({
    Expression<int>? id,
    Expression<String>? ubicacionId,
    Expression<String>? fechaInicio,
    Expression<String>? fechaFin,
    Expression<String>? horaInicio,
    Expression<String>? horaFin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ubicacionId != null) 'ubicacion_id': ubicacionId,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (fechaFin != null) 'fecha_fin': fechaFin,
      if (horaInicio != null) 'hora_inicio': horaInicio,
      if (horaFin != null) 'hora_fin': horaFin,
    });
  }

  HorariosCompanion copyWith({
    Value<int>? id,
    Value<String>? ubicacionId,
    Value<DateTime>? fechaInicio,
    Value<DateTime>? fechaFin,
    Value<TimeOfDay>? horaInicio,
    Value<TimeOfDay>? horaFin,
  }) {
    return HorariosCompanion(
      id: id ?? this.id,
      ubicacionId: ubicacionId ?? this.ubicacionId,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFin: horaFin ?? this.horaFin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ubicacionId.present) {
      map['ubicacion_id'] = Variable<String>(ubicacionId.value);
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
          ..write('horaFin: $horaFin')
          ..write(')'))
        .toString();
  }
}

class $RegistroBiometricoTable extends RegistroBiometrico
    with TableInfo<$RegistroBiometricoTable, RegistroBiometricoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistroBiometricoTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> trabajadorId = GeneratedColumn<String>(
    'trabajador_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (id)',
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
    $RegistroBiometricoTable.$converterdatosBiometricos,
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
    $RegistroBiometricoTable.$convertermetodoPruebaVida,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trabajadorId,
    foto,
    datosBiometricos,
    pruebaVidaExitosa,
    metodoPruebaVida,
    puntajeConfianza,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registro_biometrico';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegistroBiometricoData> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegistroBiometricoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistroBiometricoData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      trabajadorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trabajador_id'],
          )!,
      foto:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}foto'],
          )!,
      datosBiometricos: $RegistroBiometricoTable.$converterdatosBiometricos
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
      metodoPruebaVida: $RegistroBiometricoTable.$convertermetodoPruebaVida
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
    );
  }

  @override
  $RegistroBiometricoTable createAlias(String alias) {
    return $RegistroBiometricoTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String>
  $converterdatosBiometricos = const JsonConverter();
  static TypeConverter<MetodoPruebaVida, String> $convertermetodoPruebaVida =
      const MetodoPruebaVidaConverter();
}

class RegistroBiometricoData extends DataClass
    implements Insertable<RegistroBiometricoData> {
  final int id;
  final String trabajadorId;
  final String foto;
  final Map<String, dynamic> datosBiometricos;
  final bool pruebaVidaExitosa;
  final MetodoPruebaVida metodoPruebaVida;
  final double puntajeConfianza;
  const RegistroBiometricoData({
    required this.id,
    required this.trabajadorId,
    required this.foto,
    required this.datosBiometricos,
    required this.pruebaVidaExitosa,
    required this.metodoPruebaVida,
    required this.puntajeConfianza,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trabajador_id'] = Variable<String>(trabajadorId);
    map['foto'] = Variable<String>(foto);
    {
      map['datos_biometricos'] = Variable<String>(
        $RegistroBiometricoTable.$converterdatosBiometricos.toSql(
          datosBiometricos,
        ),
      );
    }
    map['prueba_vida_exitosa'] = Variable<bool>(pruebaVidaExitosa);
    {
      map['metodo_prueba_vida'] = Variable<String>(
        $RegistroBiometricoTable.$convertermetodoPruebaVida.toSql(
          metodoPruebaVida,
        ),
      );
    }
    map['puntaje_confianza'] = Variable<double>(puntajeConfianza);
    return map;
  }

  RegistroBiometricoCompanion toCompanion(bool nullToAbsent) {
    return RegistroBiometricoCompanion(
      id: Value(id),
      trabajadorId: Value(trabajadorId),
      foto: Value(foto),
      datosBiometricos: Value(datosBiometricos),
      pruebaVidaExitosa: Value(pruebaVidaExitosa),
      metodoPruebaVida: Value(metodoPruebaVida),
      puntajeConfianza: Value(puntajeConfianza),
    );
  }

  factory RegistroBiometricoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistroBiometricoData(
      id: serializer.fromJson<int>(json['id']),
      trabajadorId: serializer.fromJson<String>(json['trabajadorId']),
      foto: serializer.fromJson<String>(json['foto']),
      datosBiometricos: serializer.fromJson<Map<String, dynamic>>(
        json['datosBiometricos'],
      ),
      pruebaVidaExitosa: serializer.fromJson<bool>(json['pruebaVidaExitosa']),
      metodoPruebaVida: serializer.fromJson<MetodoPruebaVida>(
        json['metodoPruebaVida'],
      ),
      puntajeConfianza: serializer.fromJson<double>(json['puntajeConfianza']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trabajadorId': serializer.toJson<String>(trabajadorId),
      'foto': serializer.toJson<String>(foto),
      'datosBiometricos': serializer.toJson<Map<String, dynamic>>(
        datosBiometricos,
      ),
      'pruebaVidaExitosa': serializer.toJson<bool>(pruebaVidaExitosa),
      'metodoPruebaVida': serializer.toJson<MetodoPruebaVida>(metodoPruebaVida),
      'puntajeConfianza': serializer.toJson<double>(puntajeConfianza),
    };
  }

  RegistroBiometricoData copyWith({
    int? id,
    String? trabajadorId,
    String? foto,
    Map<String, dynamic>? datosBiometricos,
    bool? pruebaVidaExitosa,
    MetodoPruebaVida? metodoPruebaVida,
    double? puntajeConfianza,
  }) => RegistroBiometricoData(
    id: id ?? this.id,
    trabajadorId: trabajadorId ?? this.trabajadorId,
    foto: foto ?? this.foto,
    datosBiometricos: datosBiometricos ?? this.datosBiometricos,
    pruebaVidaExitosa: pruebaVidaExitosa ?? this.pruebaVidaExitosa,
    metodoPruebaVida: metodoPruebaVida ?? this.metodoPruebaVida,
    puntajeConfianza: puntajeConfianza ?? this.puntajeConfianza,
  );
  RegistroBiometricoData copyWithCompanion(RegistroBiometricoCompanion data) {
    return RegistroBiometricoData(
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistroBiometricoData(')
          ..write('id: $id, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('foto: $foto, ')
          ..write('datosBiometricos: $datosBiometricos, ')
          ..write('pruebaVidaExitosa: $pruebaVidaExitosa, ')
          ..write('metodoPruebaVida: $metodoPruebaVida, ')
          ..write('puntajeConfianza: $puntajeConfianza')
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistroBiometricoData &&
          other.id == this.id &&
          other.trabajadorId == this.trabajadorId &&
          other.foto == this.foto &&
          other.datosBiometricos == this.datosBiometricos &&
          other.pruebaVidaExitosa == this.pruebaVidaExitosa &&
          other.metodoPruebaVida == this.metodoPruebaVida &&
          other.puntajeConfianza == this.puntajeConfianza);
}

class RegistroBiometricoCompanion
    extends UpdateCompanion<RegistroBiometricoData> {
  final Value<int> id;
  final Value<String> trabajadorId;
  final Value<String> foto;
  final Value<Map<String, dynamic>> datosBiometricos;
  final Value<bool> pruebaVidaExitosa;
  final Value<MetodoPruebaVida> metodoPruebaVida;
  final Value<double> puntajeConfianza;
  const RegistroBiometricoCompanion({
    this.id = const Value.absent(),
    this.trabajadorId = const Value.absent(),
    this.foto = const Value.absent(),
    this.datosBiometricos = const Value.absent(),
    this.pruebaVidaExitosa = const Value.absent(),
    this.metodoPruebaVida = const Value.absent(),
    this.puntajeConfianza = const Value.absent(),
  });
  RegistroBiometricoCompanion.insert({
    this.id = const Value.absent(),
    required String trabajadorId,
    required String foto,
    required Map<String, dynamic> datosBiometricos,
    required bool pruebaVidaExitosa,
    required MetodoPruebaVida metodoPruebaVida,
    required double puntajeConfianza,
  }) : trabajadorId = Value(trabajadorId),
       foto = Value(foto),
       datosBiometricos = Value(datosBiometricos),
       pruebaVidaExitosa = Value(pruebaVidaExitosa),
       metodoPruebaVida = Value(metodoPruebaVida),
       puntajeConfianza = Value(puntajeConfianza);
  static Insertable<RegistroBiometricoData> custom({
    Expression<int>? id,
    Expression<String>? trabajadorId,
    Expression<String>? foto,
    Expression<String>? datosBiometricos,
    Expression<bool>? pruebaVidaExitosa,
    Expression<String>? metodoPruebaVida,
    Expression<double>? puntajeConfianza,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trabajadorId != null) 'trabajador_id': trabajadorId,
      if (foto != null) 'foto': foto,
      if (datosBiometricos != null) 'datos_biometricos': datosBiometricos,
      if (pruebaVidaExitosa != null) 'prueba_vida_exitosa': pruebaVidaExitosa,
      if (metodoPruebaVida != null) 'metodo_prueba_vida': metodoPruebaVida,
      if (puntajeConfianza != null) 'puntaje_confianza': puntajeConfianza,
    });
  }

  RegistroBiometricoCompanion copyWith({
    Value<int>? id,
    Value<String>? trabajadorId,
    Value<String>? foto,
    Value<Map<String, dynamic>>? datosBiometricos,
    Value<bool>? pruebaVidaExitosa,
    Value<MetodoPruebaVida>? metodoPruebaVida,
    Value<double>? puntajeConfianza,
  }) {
    return RegistroBiometricoCompanion(
      id: id ?? this.id,
      trabajadorId: trabajadorId ?? this.trabajadorId,
      foto: foto ?? this.foto,
      datosBiometricos: datosBiometricos ?? this.datosBiometricos,
      pruebaVidaExitosa: pruebaVidaExitosa ?? this.pruebaVidaExitosa,
      metodoPruebaVida: metodoPruebaVida ?? this.metodoPruebaVida,
      puntajeConfianza: puntajeConfianza ?? this.puntajeConfianza,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trabajadorId.present) {
      map['trabajador_id'] = Variable<String>(trabajadorId.value);
    }
    if (foto.present) {
      map['foto'] = Variable<String>(foto.value);
    }
    if (datosBiometricos.present) {
      map['datos_biometricos'] = Variable<String>(
        $RegistroBiometricoTable.$converterdatosBiometricos.toSql(
          datosBiometricos.value,
        ),
      );
    }
    if (pruebaVidaExitosa.present) {
      map['prueba_vida_exitosa'] = Variable<bool>(pruebaVidaExitosa.value);
    }
    if (metodoPruebaVida.present) {
      map['metodo_prueba_vida'] = Variable<String>(
        $RegistroBiometricoTable.$convertermetodoPruebaVida.toSql(
          metodoPruebaVida.value,
        ),
      );
    }
    if (puntajeConfianza.present) {
      map['puntaje_confianza'] = Variable<double>(puntajeConfianza.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistroBiometricoCompanion(')
          ..write('id: $id, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('foto: $foto, ')
          ..write('datosBiometricos: $datosBiometricos, ')
          ..write('pruebaVidaExitosa: $pruebaVidaExitosa, ')
          ..write('metodoPruebaVida: $metodoPruebaVida, ')
          ..write('puntajeConfianza: $puntajeConfianza')
          ..write(')'))
        .toString();
  }
}

class $CargosLiderazgoTable extends CargosLiderazgo
    with TableInfo<$CargosLiderazgoTable, CargoLiderazgo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CargosLiderazgoTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _observacionMeta = const VerificationMeta(
    'observacion',
  );
  @override
  late final GeneratedColumn<String> observacion = GeneratedColumn<String>(
    'observacion',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 300),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  List<GeneratedColumn> get $columns => [id, nombre, observacion, estado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cargos_liderazgo';
  @override
  VerificationContext validateIntegrity(
    Insertable<CargoLiderazgo> instance, {
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
    if (data.containsKey('observacion')) {
      context.handle(
        _observacionMeta,
        observacion.isAcceptableOrUnknown(
          data['observacion']!,
          _observacionMeta,
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
  CargoLiderazgo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CargoLiderazgo(
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
      observacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observacion'],
      ),
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $CargosLiderazgoTable createAlias(String alias) {
    return $CargosLiderazgoTable(attachedDatabase, alias);
  }
}

class CargoLiderazgo extends DataClass implements Insertable<CargoLiderazgo> {
  final int id;
  final String nombre;
  final String? observacion;
  final bool estado;
  const CargoLiderazgo({
    required this.id,
    required this.nombre,
    this.observacion,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || observacion != null) {
      map['observacion'] = Variable<String>(observacion);
    }
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  CargosLiderazgoCompanion toCompanion(bool nullToAbsent) {
    return CargosLiderazgoCompanion(
      id: Value(id),
      nombre: Value(nombre),
      observacion:
          observacion == null && nullToAbsent
              ? const Value.absent()
              : Value(observacion),
      estado: Value(estado),
    );
  }

  factory CargoLiderazgo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CargoLiderazgo(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      observacion: serializer.fromJson<String?>(json['observacion']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'observacion': serializer.toJson<String?>(observacion),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  CargoLiderazgo copyWith({
    int? id,
    String? nombre,
    Value<String?> observacion = const Value.absent(),
    bool? estado,
  }) => CargoLiderazgo(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    observacion: observacion.present ? observacion.value : this.observacion,
    estado: estado ?? this.estado,
  );
  CargoLiderazgo copyWithCompanion(CargosLiderazgoCompanion data) {
    return CargoLiderazgo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      observacion:
          data.observacion.present ? data.observacion.value : this.observacion,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CargoLiderazgo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('observacion: $observacion, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, observacion, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CargoLiderazgo &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.observacion == this.observacion &&
          other.estado == this.estado);
}

class CargosLiderazgoCompanion extends UpdateCompanion<CargoLiderazgo> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> observacion;
  final Value<bool> estado;
  const CargosLiderazgoCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.observacion = const Value.absent(),
    this.estado = const Value.absent(),
  });
  CargosLiderazgoCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.observacion = const Value.absent(),
    this.estado = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<CargoLiderazgo> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? observacion,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (observacion != null) 'observacion': observacion,
      if (estado != null) 'estado': estado,
    });
  }

  CargosLiderazgoCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? observacion,
    Value<bool>? estado,
  }) {
    return CargosLiderazgoCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      observacion: observacion ?? this.observacion,
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
    if (observacion.present) {
      map['observacion'] = Variable<String>(observacion.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CargosLiderazgoCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('observacion: $observacion, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $LiderUbicacionesTable extends LiderUbicaciones
    with TableInfo<$LiderUbicacionesTable, LiderUbicacion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiderUbicacionesTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> ubicacionId = GeneratedColumn<String>(
    'ubicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ubicaciones (id)',
    ),
  );
  static const VerificationMeta _liderIdMeta = const VerificationMeta(
    'liderId',
  );
  @override
  late final GeneratedColumn<String> liderId = GeneratedColumn<String>(
    'lider_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (id)',
    ),
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
  static const VerificationMeta _cargoLiderazgoIdMeta = const VerificationMeta(
    'cargoLiderazgoId',
  );
  @override
  late final GeneratedColumn<String> cargoLiderazgoId = GeneratedColumn<String>(
    'cargo_liderazgo_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cargos_liderazgo (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ubicacionId,
    liderId,
    estado,
    cargoLiderazgoId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lider_ubicaciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<LiderUbicacion> instance, {
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
    if (data.containsKey('lider_id')) {
      context.handle(
        _liderIdMeta,
        liderId.isAcceptableOrUnknown(data['lider_id']!, _liderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_liderIdMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('cargo_liderazgo_id')) {
      context.handle(
        _cargoLiderazgoIdMeta,
        cargoLiderazgoId.isAcceptableOrUnknown(
          data['cargo_liderazgo_id']!,
          _cargoLiderazgoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cargoLiderazgoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LiderUbicacion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiderUbicacion(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      ubicacionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ubicacion_id'],
          )!,
      liderId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}lider_id'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
      cargoLiderazgoId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}cargo_liderazgo_id'],
          )!,
    );
  }

  @override
  $LiderUbicacionesTable createAlias(String alias) {
    return $LiderUbicacionesTable(attachedDatabase, alias);
  }
}

class LiderUbicacion extends DataClass implements Insertable<LiderUbicacion> {
  final int id;
  final String ubicacionId;
  final String liderId;
  final bool estado;
  final String cargoLiderazgoId;
  const LiderUbicacion({
    required this.id,
    required this.ubicacionId,
    required this.liderId,
    required this.estado,
    required this.cargoLiderazgoId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ubicacion_id'] = Variable<String>(ubicacionId);
    map['lider_id'] = Variable<String>(liderId);
    map['estado'] = Variable<bool>(estado);
    map['cargo_liderazgo_id'] = Variable<String>(cargoLiderazgoId);
    return map;
  }

  LiderUbicacionesCompanion toCompanion(bool nullToAbsent) {
    return LiderUbicacionesCompanion(
      id: Value(id),
      ubicacionId: Value(ubicacionId),
      liderId: Value(liderId),
      estado: Value(estado),
      cargoLiderazgoId: Value(cargoLiderazgoId),
    );
  }

  factory LiderUbicacion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiderUbicacion(
      id: serializer.fromJson<int>(json['id']),
      ubicacionId: serializer.fromJson<String>(json['ubicacionId']),
      liderId: serializer.fromJson<String>(json['liderId']),
      estado: serializer.fromJson<bool>(json['estado']),
      cargoLiderazgoId: serializer.fromJson<String>(json['cargoLiderazgoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ubicacionId': serializer.toJson<String>(ubicacionId),
      'liderId': serializer.toJson<String>(liderId),
      'estado': serializer.toJson<bool>(estado),
      'cargoLiderazgoId': serializer.toJson<String>(cargoLiderazgoId),
    };
  }

  LiderUbicacion copyWith({
    int? id,
    String? ubicacionId,
    String? liderId,
    bool? estado,
    String? cargoLiderazgoId,
  }) => LiderUbicacion(
    id: id ?? this.id,
    ubicacionId: ubicacionId ?? this.ubicacionId,
    liderId: liderId ?? this.liderId,
    estado: estado ?? this.estado,
    cargoLiderazgoId: cargoLiderazgoId ?? this.cargoLiderazgoId,
  );
  LiderUbicacion copyWithCompanion(LiderUbicacionesCompanion data) {
    return LiderUbicacion(
      id: data.id.present ? data.id.value : this.id,
      ubicacionId:
          data.ubicacionId.present ? data.ubicacionId.value : this.ubicacionId,
      liderId: data.liderId.present ? data.liderId.value : this.liderId,
      estado: data.estado.present ? data.estado.value : this.estado,
      cargoLiderazgoId:
          data.cargoLiderazgoId.present
              ? data.cargoLiderazgoId.value
              : this.cargoLiderazgoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiderUbicacion(')
          ..write('id: $id, ')
          ..write('ubicacionId: $ubicacionId, ')
          ..write('liderId: $liderId, ')
          ..write('estado: $estado, ')
          ..write('cargoLiderazgoId: $cargoLiderazgoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ubicacionId, liderId, estado, cargoLiderazgoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiderUbicacion &&
          other.id == this.id &&
          other.ubicacionId == this.ubicacionId &&
          other.liderId == this.liderId &&
          other.estado == this.estado &&
          other.cargoLiderazgoId == this.cargoLiderazgoId);
}

class LiderUbicacionesCompanion extends UpdateCompanion<LiderUbicacion> {
  final Value<int> id;
  final Value<String> ubicacionId;
  final Value<String> liderId;
  final Value<bool> estado;
  final Value<String> cargoLiderazgoId;
  const LiderUbicacionesCompanion({
    this.id = const Value.absent(),
    this.ubicacionId = const Value.absent(),
    this.liderId = const Value.absent(),
    this.estado = const Value.absent(),
    this.cargoLiderazgoId = const Value.absent(),
  });
  LiderUbicacionesCompanion.insert({
    this.id = const Value.absent(),
    required String ubicacionId,
    required String liderId,
    this.estado = const Value.absent(),
    required String cargoLiderazgoId,
  }) : ubicacionId = Value(ubicacionId),
       liderId = Value(liderId),
       cargoLiderazgoId = Value(cargoLiderazgoId);
  static Insertable<LiderUbicacion> custom({
    Expression<int>? id,
    Expression<String>? ubicacionId,
    Expression<String>? liderId,
    Expression<bool>? estado,
    Expression<String>? cargoLiderazgoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ubicacionId != null) 'ubicacion_id': ubicacionId,
      if (liderId != null) 'lider_id': liderId,
      if (estado != null) 'estado': estado,
      if (cargoLiderazgoId != null) 'cargo_liderazgo_id': cargoLiderazgoId,
    });
  }

  LiderUbicacionesCompanion copyWith({
    Value<int>? id,
    Value<String>? ubicacionId,
    Value<String>? liderId,
    Value<bool>? estado,
    Value<String>? cargoLiderazgoId,
  }) {
    return LiderUbicacionesCompanion(
      id: id ?? this.id,
      ubicacionId: ubicacionId ?? this.ubicacionId,
      liderId: liderId ?? this.liderId,
      estado: estado ?? this.estado,
      cargoLiderazgoId: cargoLiderazgoId ?? this.cargoLiderazgoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ubicacionId.present) {
      map['ubicacion_id'] = Variable<String>(ubicacionId.value);
    }
    if (liderId.present) {
      map['lider_id'] = Variable<String>(liderId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (cargoLiderazgoId.present) {
      map['cargo_liderazgo_id'] = Variable<String>(cargoLiderazgoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiderUbicacionesCompanion(')
          ..write('id: $id, ')
          ..write('ubicacionId: $ubicacionId, ')
          ..write('liderId: $liderId, ')
          ..write('estado: $estado, ')
          ..write('cargoLiderazgoId: $cargoLiderazgoId')
          ..write(')'))
        .toString();
  }
}

class $EquipoTable extends Equipo with TableInfo<$EquipoTable, EquipoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipoTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _liderUbicacionIdMeta = const VerificationMeta(
    'liderUbicacionId',
  );
  @override
  late final GeneratedColumn<String> liderUbicacionId = GeneratedColumn<String>(
    'lider_ubicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lider_ubicaciones (id)',
    ),
  );
  static const VerificationMeta _trabajadorIdMeta = const VerificationMeta(
    'trabajadorId',
  );
  @override
  late final GeneratedColumn<String> trabajadorId = GeneratedColumn<String>(
    'trabajador_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (id)',
    ),
  );
  static const VerificationMeta _idRegistroMeta = const VerificationMeta(
    'idRegistro',
  );
  @override
  late final GeneratedColumn<String> idRegistro = GeneratedColumn<String>(
    'id_registro',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (id)',
    ),
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
    liderUbicacionId,
    trabajadorId,
    idRegistro,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipo';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lider_ubicacion_id')) {
      context.handle(
        _liderUbicacionIdMeta,
        liderUbicacionId.isAcceptableOrUnknown(
          data['lider_ubicacion_id']!,
          _liderUbicacionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_liderUbicacionIdMeta);
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
    if (data.containsKey('id_registro')) {
      context.handle(
        _idRegistroMeta,
        idRegistro.isAcceptableOrUnknown(data['id_registro']!, _idRegistroMeta),
      );
    } else if (isInserting) {
      context.missing(_idRegistroMeta);
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
  EquipoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipoData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      liderUbicacionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}lider_ubicacion_id'],
          )!,
      trabajadorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trabajador_id'],
          )!,
      idRegistro:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id_registro'],
          )!,
      estado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}estado'],
          )!,
    );
  }

  @override
  $EquipoTable createAlias(String alias) {
    return $EquipoTable(attachedDatabase, alias);
  }
}

class EquipoData extends DataClass implements Insertable<EquipoData> {
  final int id;
  final String liderUbicacionId;
  final String trabajadorId;
  final String idRegistro;
  final bool estado;
  const EquipoData({
    required this.id,
    required this.liderUbicacionId,
    required this.trabajadorId,
    required this.idRegistro,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lider_ubicacion_id'] = Variable<String>(liderUbicacionId);
    map['trabajador_id'] = Variable<String>(trabajadorId);
    map['id_registro'] = Variable<String>(idRegistro);
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  EquipoCompanion toCompanion(bool nullToAbsent) {
    return EquipoCompanion(
      id: Value(id),
      liderUbicacionId: Value(liderUbicacionId),
      trabajadorId: Value(trabajadorId),
      idRegistro: Value(idRegistro),
      estado: Value(estado),
    );
  }

  factory EquipoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipoData(
      id: serializer.fromJson<int>(json['id']),
      liderUbicacionId: serializer.fromJson<String>(json['liderUbicacionId']),
      trabajadorId: serializer.fromJson<String>(json['trabajadorId']),
      idRegistro: serializer.fromJson<String>(json['idRegistro']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'liderUbicacionId': serializer.toJson<String>(liderUbicacionId),
      'trabajadorId': serializer.toJson<String>(trabajadorId),
      'idRegistro': serializer.toJson<String>(idRegistro),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  EquipoData copyWith({
    int? id,
    String? liderUbicacionId,
    String? trabajadorId,
    String? idRegistro,
    bool? estado,
  }) => EquipoData(
    id: id ?? this.id,
    liderUbicacionId: liderUbicacionId ?? this.liderUbicacionId,
    trabajadorId: trabajadorId ?? this.trabajadorId,
    idRegistro: idRegistro ?? this.idRegistro,
    estado: estado ?? this.estado,
  );
  EquipoData copyWithCompanion(EquipoCompanion data) {
    return EquipoData(
      id: data.id.present ? data.id.value : this.id,
      liderUbicacionId:
          data.liderUbicacionId.present
              ? data.liderUbicacionId.value
              : this.liderUbicacionId,
      trabajadorId:
          data.trabajadorId.present
              ? data.trabajadorId.value
              : this.trabajadorId,
      idRegistro:
          data.idRegistro.present ? data.idRegistro.value : this.idRegistro,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipoData(')
          ..write('id: $id, ')
          ..write('liderUbicacionId: $liderUbicacionId, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('idRegistro: $idRegistro, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, liderUbicacionId, trabajadorId, idRegistro, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipoData &&
          other.id == this.id &&
          other.liderUbicacionId == this.liderUbicacionId &&
          other.trabajadorId == this.trabajadorId &&
          other.idRegistro == this.idRegistro &&
          other.estado == this.estado);
}

class EquipoCompanion extends UpdateCompanion<EquipoData> {
  final Value<int> id;
  final Value<String> liderUbicacionId;
  final Value<String> trabajadorId;
  final Value<String> idRegistro;
  final Value<bool> estado;
  const EquipoCompanion({
    this.id = const Value.absent(),
    this.liderUbicacionId = const Value.absent(),
    this.trabajadorId = const Value.absent(),
    this.idRegistro = const Value.absent(),
    this.estado = const Value.absent(),
  });
  EquipoCompanion.insert({
    this.id = const Value.absent(),
    required String liderUbicacionId,
    required String trabajadorId,
    required String idRegistro,
    this.estado = const Value.absent(),
  }) : liderUbicacionId = Value(liderUbicacionId),
       trabajadorId = Value(trabajadorId),
       idRegistro = Value(idRegistro);
  static Insertable<EquipoData> custom({
    Expression<int>? id,
    Expression<String>? liderUbicacionId,
    Expression<String>? trabajadorId,
    Expression<String>? idRegistro,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (liderUbicacionId != null) 'lider_ubicacion_id': liderUbicacionId,
      if (trabajadorId != null) 'trabajador_id': trabajadorId,
      if (idRegistro != null) 'id_registro': idRegistro,
      if (estado != null) 'estado': estado,
    });
  }

  EquipoCompanion copyWith({
    Value<int>? id,
    Value<String>? liderUbicacionId,
    Value<String>? trabajadorId,
    Value<String>? idRegistro,
    Value<bool>? estado,
  }) {
    return EquipoCompanion(
      id: id ?? this.id,
      liderUbicacionId: liderUbicacionId ?? this.liderUbicacionId,
      trabajadorId: trabajadorId ?? this.trabajadorId,
      idRegistro: idRegistro ?? this.idRegistro,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (liderUbicacionId.present) {
      map['lider_ubicacion_id'] = Variable<String>(liderUbicacionId.value);
    }
    if (trabajadorId.present) {
      map['trabajador_id'] = Variable<String>(trabajadorId.value);
    }
    if (idRegistro.present) {
      map['id_registro'] = Variable<String>(idRegistro.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipoCompanion(')
          ..write('id: $id, ')
          ..write('liderUbicacionId: $liderUbicacionId, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('idRegistro: $idRegistro, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $RegistroDiarioTable extends RegistroDiario
    with TableInfo<$RegistroDiarioTable, RegistroDiarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistroDiarioTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> equipoId = GeneratedColumn<String>(
    'equipo_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES equipo (id)',
    ),
  );
  static const VerificationMeta _registroBiometricoIdMeta =
      const VerificationMeta('registroBiometricoId');
  @override
  late final GeneratedColumn<String> registroBiometricoId =
      GeneratedColumn<String>(
        'registro_biometrico_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES registro_biometrico (id)',
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
      ).withConverter<DateTime>($RegistroDiarioTable.$converterfechaIngreso);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> horaIngreso =
      GeneratedColumn<String>(
        'hora_ingreso',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($RegistroDiarioTable.$converterhoraIngreso);
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> fechaSalida =
      GeneratedColumn<String>(
        'fecha_salida',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($RegistroDiarioTable.$converterfechaSalida);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, String> horaSalida =
      GeneratedColumn<String>(
        'hora_salida',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TimeOfDay>($RegistroDiarioTable.$converterhoraSalida);
  static const VerificationMeta _ingresoSincronizadoMeta =
      const VerificationMeta('ingresoSincronizado');
  @override
  late final GeneratedColumn<bool> ingresoSincronizado = GeneratedColumn<bool>(
    'ingreso_sincronizado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ingreso_sincronizado" IN (0, 1))',
    ),
  );
  static const VerificationMeta _salidaSincronizadaMeta =
      const VerificationMeta('salidaSincronizada');
  @override
  late final GeneratedColumn<bool> salidaSincronizada = GeneratedColumn<bool>(
    'salida_sincronizada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("salida_sincronizada" IN (0, 1))',
    ),
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
    ingresoSincronizado,
    salidaSincronizada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registro_diario';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegistroDiarioData> instance, {
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
    } else if (isInserting) {
      context.missing(_registroBiometricoIdMeta);
    }
    if (data.containsKey('ingreso_sincronizado')) {
      context.handle(
        _ingresoSincronizadoMeta,
        ingresoSincronizado.isAcceptableOrUnknown(
          data['ingreso_sincronizado']!,
          _ingresoSincronizadoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingresoSincronizadoMeta);
    }
    if (data.containsKey('salida_sincronizada')) {
      context.handle(
        _salidaSincronizadaMeta,
        salidaSincronizada.isAcceptableOrUnknown(
          data['salida_sincronizada']!,
          _salidaSincronizadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_salidaSincronizadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegistroDiarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistroDiarioData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      equipoId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}equipo_id'],
          )!,
      registroBiometricoId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}registro_biometrico_id'],
          )!,
      fechaIngreso: $RegistroDiarioTable.$converterfechaIngreso.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fecha_ingreso'],
        )!,
      ),
      horaIngreso: $RegistroDiarioTable.$converterhoraIngreso.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hora_ingreso'],
        )!,
      ),
      fechaSalida: $RegistroDiarioTable.$converterfechaSalida.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fecha_salida'],
        )!,
      ),
      horaSalida: $RegistroDiarioTable.$converterhoraSalida.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}hora_salida'],
        )!,
      ),
      ingresoSincronizado:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}ingreso_sincronizado'],
          )!,
      salidaSincronizada:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}salida_sincronizada'],
          )!,
    );
  }

  @override
  $RegistroDiarioTable createAlias(String alias) {
    return $RegistroDiarioTable(attachedDatabase, alias);
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

class RegistroDiarioData extends DataClass
    implements Insertable<RegistroDiarioData> {
  final int id;
  final String equipoId;
  final String registroBiometricoId;
  final DateTime fechaIngreso;
  final TimeOfDay horaIngreso;
  final DateTime fechaSalida;
  final TimeOfDay horaSalida;
  final bool ingresoSincronizado;
  final bool salidaSincronizada;
  const RegistroDiarioData({
    required this.id,
    required this.equipoId,
    required this.registroBiometricoId,
    required this.fechaIngreso,
    required this.horaIngreso,
    required this.fechaSalida,
    required this.horaSalida,
    required this.ingresoSincronizado,
    required this.salidaSincronizada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipo_id'] = Variable<String>(equipoId);
    map['registro_biometrico_id'] = Variable<String>(registroBiometricoId);
    {
      map['fecha_ingreso'] = Variable<String>(
        $RegistroDiarioTable.$converterfechaIngreso.toSql(fechaIngreso),
      );
    }
    {
      map['hora_ingreso'] = Variable<String>(
        $RegistroDiarioTable.$converterhoraIngreso.toSql(horaIngreso),
      );
    }
    {
      map['fecha_salida'] = Variable<String>(
        $RegistroDiarioTable.$converterfechaSalida.toSql(fechaSalida),
      );
    }
    {
      map['hora_salida'] = Variable<String>(
        $RegistroDiarioTable.$converterhoraSalida.toSql(horaSalida),
      );
    }
    map['ingreso_sincronizado'] = Variable<bool>(ingresoSincronizado);
    map['salida_sincronizada'] = Variable<bool>(salidaSincronizada);
    return map;
  }

  RegistroDiarioCompanion toCompanion(bool nullToAbsent) {
    return RegistroDiarioCompanion(
      id: Value(id),
      equipoId: Value(equipoId),
      registroBiometricoId: Value(registroBiometricoId),
      fechaIngreso: Value(fechaIngreso),
      horaIngreso: Value(horaIngreso),
      fechaSalida: Value(fechaSalida),
      horaSalida: Value(horaSalida),
      ingresoSincronizado: Value(ingresoSincronizado),
      salidaSincronizada: Value(salidaSincronizada),
    );
  }

  factory RegistroDiarioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistroDiarioData(
      id: serializer.fromJson<int>(json['id']),
      equipoId: serializer.fromJson<String>(json['equipoId']),
      registroBiometricoId: serializer.fromJson<String>(
        json['registroBiometricoId'],
      ),
      fechaIngreso: serializer.fromJson<DateTime>(json['fechaIngreso']),
      horaIngreso: serializer.fromJson<TimeOfDay>(json['horaIngreso']),
      fechaSalida: serializer.fromJson<DateTime>(json['fechaSalida']),
      horaSalida: serializer.fromJson<TimeOfDay>(json['horaSalida']),
      ingresoSincronizado: serializer.fromJson<bool>(
        json['ingresoSincronizado'],
      ),
      salidaSincronizada: serializer.fromJson<bool>(json['salidaSincronizada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipoId': serializer.toJson<String>(equipoId),
      'registroBiometricoId': serializer.toJson<String>(registroBiometricoId),
      'fechaIngreso': serializer.toJson<DateTime>(fechaIngreso),
      'horaIngreso': serializer.toJson<TimeOfDay>(horaIngreso),
      'fechaSalida': serializer.toJson<DateTime>(fechaSalida),
      'horaSalida': serializer.toJson<TimeOfDay>(horaSalida),
      'ingresoSincronizado': serializer.toJson<bool>(ingresoSincronizado),
      'salidaSincronizada': serializer.toJson<bool>(salidaSincronizada),
    };
  }

  RegistroDiarioData copyWith({
    int? id,
    String? equipoId,
    String? registroBiometricoId,
    DateTime? fechaIngreso,
    TimeOfDay? horaIngreso,
    DateTime? fechaSalida,
    TimeOfDay? horaSalida,
    bool? ingresoSincronizado,
    bool? salidaSincronizada,
  }) => RegistroDiarioData(
    id: id ?? this.id,
    equipoId: equipoId ?? this.equipoId,
    registroBiometricoId: registroBiometricoId ?? this.registroBiometricoId,
    fechaIngreso: fechaIngreso ?? this.fechaIngreso,
    horaIngreso: horaIngreso ?? this.horaIngreso,
    fechaSalida: fechaSalida ?? this.fechaSalida,
    horaSalida: horaSalida ?? this.horaSalida,
    ingresoSincronizado: ingresoSincronizado ?? this.ingresoSincronizado,
    salidaSincronizada: salidaSincronizada ?? this.salidaSincronizada,
  );
  RegistroDiarioData copyWithCompanion(RegistroDiarioCompanion data) {
    return RegistroDiarioData(
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
      ingresoSincronizado:
          data.ingresoSincronizado.present
              ? data.ingresoSincronizado.value
              : this.ingresoSincronizado,
      salidaSincronizada:
          data.salidaSincronizada.present
              ? data.salidaSincronizada.value
              : this.salidaSincronizada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistroDiarioData(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('registroBiometricoId: $registroBiometricoId, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('horaIngreso: $horaIngreso, ')
          ..write('fechaSalida: $fechaSalida, ')
          ..write('horaSalida: $horaSalida, ')
          ..write('ingresoSincronizado: $ingresoSincronizado, ')
          ..write('salidaSincronizada: $salidaSincronizada')
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
    ingresoSincronizado,
    salidaSincronizada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistroDiarioData &&
          other.id == this.id &&
          other.equipoId == this.equipoId &&
          other.registroBiometricoId == this.registroBiometricoId &&
          other.fechaIngreso == this.fechaIngreso &&
          other.horaIngreso == this.horaIngreso &&
          other.fechaSalida == this.fechaSalida &&
          other.horaSalida == this.horaSalida &&
          other.ingresoSincronizado == this.ingresoSincronizado &&
          other.salidaSincronizada == this.salidaSincronizada);
}

class RegistroDiarioCompanion extends UpdateCompanion<RegistroDiarioData> {
  final Value<int> id;
  final Value<String> equipoId;
  final Value<String> registroBiometricoId;
  final Value<DateTime> fechaIngreso;
  final Value<TimeOfDay> horaIngreso;
  final Value<DateTime> fechaSalida;
  final Value<TimeOfDay> horaSalida;
  final Value<bool> ingresoSincronizado;
  final Value<bool> salidaSincronizada;
  const RegistroDiarioCompanion({
    this.id = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.registroBiometricoId = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.horaIngreso = const Value.absent(),
    this.fechaSalida = const Value.absent(),
    this.horaSalida = const Value.absent(),
    this.ingresoSincronizado = const Value.absent(),
    this.salidaSincronizada = const Value.absent(),
  });
  RegistroDiarioCompanion.insert({
    this.id = const Value.absent(),
    required String equipoId,
    required String registroBiometricoId,
    required DateTime fechaIngreso,
    required TimeOfDay horaIngreso,
    required DateTime fechaSalida,
    required TimeOfDay horaSalida,
    required bool ingresoSincronizado,
    required bool salidaSincronizada,
  }) : equipoId = Value(equipoId),
       registroBiometricoId = Value(registroBiometricoId),
       fechaIngreso = Value(fechaIngreso),
       horaIngreso = Value(horaIngreso),
       fechaSalida = Value(fechaSalida),
       horaSalida = Value(horaSalida),
       ingresoSincronizado = Value(ingresoSincronizado),
       salidaSincronizada = Value(salidaSincronizada);
  static Insertable<RegistroDiarioData> custom({
    Expression<int>? id,
    Expression<String>? equipoId,
    Expression<String>? registroBiometricoId,
    Expression<String>? fechaIngreso,
    Expression<String>? horaIngreso,
    Expression<String>? fechaSalida,
    Expression<String>? horaSalida,
    Expression<bool>? ingresoSincronizado,
    Expression<bool>? salidaSincronizada,
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
      if (ingresoSincronizado != null)
        'ingreso_sincronizado': ingresoSincronizado,
      if (salidaSincronizada != null) 'salida_sincronizada': salidaSincronizada,
    });
  }

  RegistroDiarioCompanion copyWith({
    Value<int>? id,
    Value<String>? equipoId,
    Value<String>? registroBiometricoId,
    Value<DateTime>? fechaIngreso,
    Value<TimeOfDay>? horaIngreso,
    Value<DateTime>? fechaSalida,
    Value<TimeOfDay>? horaSalida,
    Value<bool>? ingresoSincronizado,
    Value<bool>? salidaSincronizada,
  }) {
    return RegistroDiarioCompanion(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      registroBiometricoId: registroBiometricoId ?? this.registroBiometricoId,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      horaIngreso: horaIngreso ?? this.horaIngreso,
      fechaSalida: fechaSalida ?? this.fechaSalida,
      horaSalida: horaSalida ?? this.horaSalida,
      ingresoSincronizado: ingresoSincronizado ?? this.ingresoSincronizado,
      salidaSincronizada: salidaSincronizada ?? this.salidaSincronizada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipoId.present) {
      map['equipo_id'] = Variable<String>(equipoId.value);
    }
    if (registroBiometricoId.present) {
      map['registro_biometrico_id'] = Variable<String>(
        registroBiometricoId.value,
      );
    }
    if (fechaIngreso.present) {
      map['fecha_ingreso'] = Variable<String>(
        $RegistroDiarioTable.$converterfechaIngreso.toSql(fechaIngreso.value),
      );
    }
    if (horaIngreso.present) {
      map['hora_ingreso'] = Variable<String>(
        $RegistroDiarioTable.$converterhoraIngreso.toSql(horaIngreso.value),
      );
    }
    if (fechaSalida.present) {
      map['fecha_salida'] = Variable<String>(
        $RegistroDiarioTable.$converterfechaSalida.toSql(fechaSalida.value),
      );
    }
    if (horaSalida.present) {
      map['hora_salida'] = Variable<String>(
        $RegistroDiarioTable.$converterhoraSalida.toSql(horaSalida.value),
      );
    }
    if (ingresoSincronizado.present) {
      map['ingreso_sincronizado'] = Variable<bool>(ingresoSincronizado.value);
    }
    if (salidaSincronizada.present) {
      map['salida_sincronizada'] = Variable<bool>(salidaSincronizada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistroDiarioCompanion(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('registroBiometricoId: $registroBiometricoId, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('horaIngreso: $horaIngreso, ')
          ..write('fechaSalida: $fechaSalida, ')
          ..write('horaSalida: $horaSalida, ')
          ..write('ingresoSincronizado: $ingresoSincronizado, ')
          ..write('salidaSincronizada: $salidaSincronizada')
          ..write(')'))
        .toString();
  }
}

class $SyncEntitysTable extends SyncEntitys
    with TableInfo<$SyncEntitysTable, SyncEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncEntitysTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityTableNameToSync,
    action,
    registerId,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_entitys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncEntity> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncEntity(
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
    );
  }

  @override
  $SyncEntitysTable createAlias(String alias) {
    return $SyncEntitysTable(attachedDatabase, alias);
  }
}

class SyncEntity extends DataClass implements Insertable<SyncEntity> {
  final int id;
  final String entityTableNameToSync;
  final String action;
  final String registerId;
  final DateTime timestamp;
  const SyncEntity({
    required this.id,
    required this.entityTableNameToSync,
    required this.action,
    required this.registerId,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_table_name_to_sync'] = Variable<String>(entityTableNameToSync);
    map['action'] = Variable<String>(action);
    map['register_id'] = Variable<String>(registerId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  SyncEntitysCompanion toCompanion(bool nullToAbsent) {
    return SyncEntitysCompanion(
      id: Value(id),
      entityTableNameToSync: Value(entityTableNameToSync),
      action: Value(action),
      registerId: Value(registerId),
      timestamp: Value(timestamp),
    );
  }

  factory SyncEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncEntity(
      id: serializer.fromJson<int>(json['id']),
      entityTableNameToSync: serializer.fromJson<String>(
        json['entityTableNameToSync'],
      ),
      action: serializer.fromJson<String>(json['action']),
      registerId: serializer.fromJson<String>(json['registerId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
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
    };
  }

  SyncEntity copyWith({
    int? id,
    String? entityTableNameToSync,
    String? action,
    String? registerId,
    DateTime? timestamp,
  }) => SyncEntity(
    id: id ?? this.id,
    entityTableNameToSync: entityTableNameToSync ?? this.entityTableNameToSync,
    action: action ?? this.action,
    registerId: registerId ?? this.registerId,
    timestamp: timestamp ?? this.timestamp,
  );
  SyncEntity copyWithCompanion(SyncEntitysCompanion data) {
    return SyncEntity(
      id: data.id.present ? data.id.value : this.id,
      entityTableNameToSync:
          data.entityTableNameToSync.present
              ? data.entityTableNameToSync.value
              : this.entityTableNameToSync,
      action: data.action.present ? data.action.value : this.action,
      registerId:
          data.registerId.present ? data.registerId.value : this.registerId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncEntity(')
          ..write('id: $id, ')
          ..write('entityTableNameToSync: $entityTableNameToSync, ')
          ..write('action: $action, ')
          ..write('registerId: $registerId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityTableNameToSync, action, registerId, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncEntity &&
          other.id == this.id &&
          other.entityTableNameToSync == this.entityTableNameToSync &&
          other.action == this.action &&
          other.registerId == this.registerId &&
          other.timestamp == this.timestamp);
}

class SyncEntitysCompanion extends UpdateCompanion<SyncEntity> {
  final Value<int> id;
  final Value<String> entityTableNameToSync;
  final Value<String> action;
  final Value<String> registerId;
  final Value<DateTime> timestamp;
  const SyncEntitysCompanion({
    this.id = const Value.absent(),
    this.entityTableNameToSync = const Value.absent(),
    this.action = const Value.absent(),
    this.registerId = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  SyncEntitysCompanion.insert({
    this.id = const Value.absent(),
    required String entityTableNameToSync,
    required String action,
    required String registerId,
    this.timestamp = const Value.absent(),
  }) : entityTableNameToSync = Value(entityTableNameToSync),
       action = Value(action),
       registerId = Value(registerId);
  static Insertable<SyncEntity> custom({
    Expression<int>? id,
    Expression<String>? entityTableNameToSync,
    Expression<String>? action,
    Expression<String>? registerId,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityTableNameToSync != null)
        'entity_table_name_to_sync': entityTableNameToSync,
      if (action != null) 'action': action,
      if (registerId != null) 'register_id': registerId,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  SyncEntitysCompanion copyWith({
    Value<int>? id,
    Value<String>? entityTableNameToSync,
    Value<String>? action,
    Value<String>? registerId,
    Value<DateTime>? timestamp,
  }) {
    return SyncEntitysCompanion(
      id: id ?? this.id,
      entityTableNameToSync:
          entityTableNameToSync ?? this.entityTableNameToSync,
      action: action ?? this.action,
      registerId: registerId ?? this.registerId,
      timestamp: timestamp ?? this.timestamp,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncEntitysCompanion(')
          ..write('id: $id, ')
          ..write('entityTableNameToSync: $entityTableNameToSync, ')
          ..write('action: $action, ')
          ..write('registerId: $registerId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TrabajadoresTable trabajadores = $TrabajadoresTable(this);
  late final $GrupoUbicacionesTable grupoUbicaciones = $GrupoUbicacionesTable(
    this,
  );
  late final $UbicacionesTable ubicaciones = $UbicacionesTable(this);
  late final $HorariosTable horarios = $HorariosTable(this);
  late final $RegistroBiometricoTable registroBiometrico =
      $RegistroBiometricoTable(this);
  late final $CargosLiderazgoTable cargosLiderazgo = $CargosLiderazgoTable(
    this,
  );
  late final $LiderUbicacionesTable liderUbicaciones = $LiderUbicacionesTable(
    this,
  );
  late final $EquipoTable equipo = $EquipoTable(this);
  late final $RegistroDiarioTable registroDiario = $RegistroDiarioTable(this);
  late final $SyncEntitysTable syncEntitys = $SyncEntitysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trabajadores,
    grupoUbicaciones,
    ubicaciones,
    horarios,
    registroBiometrico,
    cargosLiderazgo,
    liderUbicaciones,
    equipo,
    registroDiario,
    syncEntitys,
  ];
}

typedef $$TrabajadoresTableCreateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      required String nombre,
      required String apellido,
      required String cedula,
      Value<bool> activo,
      Value<DateTime?> ultimaActualizacion,
    });
typedef $$TrabajadoresTableUpdateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> apellido,
      Value<String> cedula,
      Value<bool> activo,
      Value<DateTime?> ultimaActualizacion,
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

  ColumnFilters<String> get apellido => $composableBuilder(
    column: $table.apellido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cedula => $composableBuilder(
    column: $table.cedula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
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

  ColumnOrderings<String> get apellido => $composableBuilder(
    column: $table.apellido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cedula => $composableBuilder(
    column: $table.cedula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
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

  GeneratedColumn<String> get apellido =>
      $composableBuilder(column: $table.apellido, builder: (column) => column);

  GeneratedColumn<String> get cedula =>
      $composableBuilder(column: $table.cedula, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => column,
  );
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
                Value<String> apellido = const Value.absent(),
                Value<String> cedula = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime?> ultimaActualizacion = const Value.absent(),
              }) => TrabajadoresCompanion(
                id: id,
                nombre: nombre,
                apellido: apellido,
                cedula: cedula,
                activo: activo,
                ultimaActualizacion: ultimaActualizacion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String apellido,
                required String cedula,
                Value<bool> activo = const Value.absent(),
                Value<DateTime?> ultimaActualizacion = const Value.absent(),
              }) => TrabajadoresCompanion.insert(
                id: id,
                nombre: nombre,
                apellido: apellido,
                cedula: cedula,
                activo: activo,
                ultimaActualizacion: ultimaActualizacion,
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
typedef $$GrupoUbicacionesTableCreateCompanionBuilder =
    GrupoUbicacionesCompanion Function({Value<int> id, required String nombre});
typedef $$GrupoUbicacionesTableUpdateCompanionBuilder =
    GrupoUbicacionesCompanion Function({Value<int> id, Value<String> nombre});

class $$GrupoUbicacionesTableFilterComposer
    extends Composer<_$AppDatabase, $GrupoUbicacionesTable> {
  $$GrupoUbicacionesTableFilterComposer({
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
}

class $$GrupoUbicacionesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrupoUbicacionesTable> {
  $$GrupoUbicacionesTableOrderingComposer({
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
}

class $$GrupoUbicacionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrupoUbicacionesTable> {
  $$GrupoUbicacionesTableAnnotationComposer({
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
}

class $$GrupoUbicacionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrupoUbicacionesTable,
          GrupoUbicacione,
          $$GrupoUbicacionesTableFilterComposer,
          $$GrupoUbicacionesTableOrderingComposer,
          $$GrupoUbicacionesTableAnnotationComposer,
          $$GrupoUbicacionesTableCreateCompanionBuilder,
          $$GrupoUbicacionesTableUpdateCompanionBuilder,
          (
            GrupoUbicacione,
            BaseReferences<
              _$AppDatabase,
              $GrupoUbicacionesTable,
              GrupoUbicacione
            >,
          ),
          GrupoUbicacione,
          PrefetchHooks Function()
        > {
  $$GrupoUbicacionesTableTableManager(
    _$AppDatabase db,
    $GrupoUbicacionesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$GrupoUbicacionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$GrupoUbicacionesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$GrupoUbicacionesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
              }) => GrupoUbicacionesCompanion(id: id, nombre: nombre),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
              }) => GrupoUbicacionesCompanion.insert(id: id, nombre: nombre),
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

typedef $$GrupoUbicacionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrupoUbicacionesTable,
      GrupoUbicacione,
      $$GrupoUbicacionesTableFilterComposer,
      $$GrupoUbicacionesTableOrderingComposer,
      $$GrupoUbicacionesTableAnnotationComposer,
      $$GrupoUbicacionesTableCreateCompanionBuilder,
      $$GrupoUbicacionesTableUpdateCompanionBuilder,
      (
        GrupoUbicacione,
        BaseReferences<_$AppDatabase, $GrupoUbicacionesTable, GrupoUbicacione>,
      ),
      GrupoUbicacione,
      PrefetchHooks Function()
    >;
typedef $$UbicacionesTableCreateCompanionBuilder =
    UbicacionesCompanion Function({
      Value<int> id,
      required String nombre,
      required Map<String, dynamic> disponibilidad,
      required String grupoId,
    });
typedef $$UbicacionesTableUpdateCompanionBuilder =
    UbicacionesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<Map<String, dynamic>> disponibilidad,
      Value<String> grupoId,
    });

class $$UbicacionesTableFilterComposer
    extends Composer<_$AppDatabase, $UbicacionesTable> {
  $$UbicacionesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get disponibilidad => $composableBuilder(
    column: $table.disponibilidad,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get disponibilidad => $composableBuilder(
    column: $table.disponibilidad,
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get disponibilidad => $composableBuilder(
    column: $table.disponibilidad,
    builder: (column) => column,
  );
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
          (
            Ubicacione,
            BaseReferences<_$AppDatabase, $UbicacionesTable, Ubicacione>,
          ),
          Ubicacione,
          PrefetchHooks Function()
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
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<Map<String, dynamic>> disponibilidad =
                    const Value.absent(),
                Value<String> grupoId = const Value.absent(),
              }) => UbicacionesCompanion(
                id: id,
                nombre: nombre,
                disponibilidad: disponibilidad,
                grupoId: grupoId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required Map<String, dynamic> disponibilidad,
                required String grupoId,
              }) => UbicacionesCompanion.insert(
                id: id,
                nombre: nombre,
                disponibilidad: disponibilidad,
                grupoId: grupoId,
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
      (
        Ubicacione,
        BaseReferences<_$AppDatabase, $UbicacionesTable, Ubicacione>,
      ),
      Ubicacione,
      PrefetchHooks Function()
    >;
typedef $$HorariosTableCreateCompanionBuilder =
    HorariosCompanion Function({
      Value<int> id,
      required String ubicacionId,
      required DateTime fechaInicio,
      required DateTime fechaFin,
      required TimeOfDay horaInicio,
      required TimeOfDay horaFin,
    });
typedef $$HorariosTableUpdateCompanionBuilder =
    HorariosCompanion Function({
      Value<int> id,
      Value<String> ubicacionId,
      Value<DateTime> fechaInicio,
      Value<DateTime> fechaFin,
      Value<TimeOfDay> horaInicio,
      Value<TimeOfDay> horaFin,
    });

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
          (Horario, BaseReferences<_$AppDatabase, $HorariosTable, Horario>),
          Horario,
          PrefetchHooks Function()
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
                Value<String> ubicacionId = const Value.absent(),
                Value<DateTime> fechaInicio = const Value.absent(),
                Value<DateTime> fechaFin = const Value.absent(),
                Value<TimeOfDay> horaInicio = const Value.absent(),
                Value<TimeOfDay> horaFin = const Value.absent(),
              }) => HorariosCompanion(
                id: id,
                ubicacionId: ubicacionId,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                horaInicio: horaInicio,
                horaFin: horaFin,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ubicacionId,
                required DateTime fechaInicio,
                required DateTime fechaFin,
                required TimeOfDay horaInicio,
                required TimeOfDay horaFin,
              }) => HorariosCompanion.insert(
                id: id,
                ubicacionId: ubicacionId,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                horaInicio: horaInicio,
                horaFin: horaFin,
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
      (Horario, BaseReferences<_$AppDatabase, $HorariosTable, Horario>),
      Horario,
      PrefetchHooks Function()
    >;
typedef $$RegistroBiometricoTableCreateCompanionBuilder =
    RegistroBiometricoCompanion Function({
      Value<int> id,
      required String trabajadorId,
      required String foto,
      required Map<String, dynamic> datosBiometricos,
      required bool pruebaVidaExitosa,
      required MetodoPruebaVida metodoPruebaVida,
      required double puntajeConfianza,
    });
typedef $$RegistroBiometricoTableUpdateCompanionBuilder =
    RegistroBiometricoCompanion Function({
      Value<int> id,
      Value<String> trabajadorId,
      Value<String> foto,
      Value<Map<String, dynamic>> datosBiometricos,
      Value<bool> pruebaVidaExitosa,
      Value<MetodoPruebaVida> metodoPruebaVida,
      Value<double> puntajeConfianza,
    });

class $$RegistroBiometricoTableFilterComposer
    extends Composer<_$AppDatabase, $RegistroBiometricoTable> {
  $$RegistroBiometricoTableFilterComposer({
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
}

class $$RegistroBiometricoTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistroBiometricoTable> {
  $$RegistroBiometricoTableOrderingComposer({
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
}

class $$RegistroBiometricoTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistroBiometricoTable> {
  $$RegistroBiometricoTableAnnotationComposer({
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
}

class $$RegistroBiometricoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistroBiometricoTable,
          RegistroBiometricoData,
          $$RegistroBiometricoTableFilterComposer,
          $$RegistroBiometricoTableOrderingComposer,
          $$RegistroBiometricoTableAnnotationComposer,
          $$RegistroBiometricoTableCreateCompanionBuilder,
          $$RegistroBiometricoTableUpdateCompanionBuilder,
          (
            RegistroBiometricoData,
            BaseReferences<
              _$AppDatabase,
              $RegistroBiometricoTable,
              RegistroBiometricoData
            >,
          ),
          RegistroBiometricoData,
          PrefetchHooks Function()
        > {
  $$RegistroBiometricoTableTableManager(
    _$AppDatabase db,
    $RegistroBiometricoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RegistroBiometricoTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$RegistroBiometricoTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$RegistroBiometricoTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> trabajadorId = const Value.absent(),
                Value<String> foto = const Value.absent(),
                Value<Map<String, dynamic>> datosBiometricos =
                    const Value.absent(),
                Value<bool> pruebaVidaExitosa = const Value.absent(),
                Value<MetodoPruebaVida> metodoPruebaVida = const Value.absent(),
                Value<double> puntajeConfianza = const Value.absent(),
              }) => RegistroBiometricoCompanion(
                id: id,
                trabajadorId: trabajadorId,
                foto: foto,
                datosBiometricos: datosBiometricos,
                pruebaVidaExitosa: pruebaVidaExitosa,
                metodoPruebaVida: metodoPruebaVida,
                puntajeConfianza: puntajeConfianza,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String trabajadorId,
                required String foto,
                required Map<String, dynamic> datosBiometricos,
                required bool pruebaVidaExitosa,
                required MetodoPruebaVida metodoPruebaVida,
                required double puntajeConfianza,
              }) => RegistroBiometricoCompanion.insert(
                id: id,
                trabajadorId: trabajadorId,
                foto: foto,
                datosBiometricos: datosBiometricos,
                pruebaVidaExitosa: pruebaVidaExitosa,
                metodoPruebaVida: metodoPruebaVida,
                puntajeConfianza: puntajeConfianza,
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

typedef $$RegistroBiometricoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistroBiometricoTable,
      RegistroBiometricoData,
      $$RegistroBiometricoTableFilterComposer,
      $$RegistroBiometricoTableOrderingComposer,
      $$RegistroBiometricoTableAnnotationComposer,
      $$RegistroBiometricoTableCreateCompanionBuilder,
      $$RegistroBiometricoTableUpdateCompanionBuilder,
      (
        RegistroBiometricoData,
        BaseReferences<
          _$AppDatabase,
          $RegistroBiometricoTable,
          RegistroBiometricoData
        >,
      ),
      RegistroBiometricoData,
      PrefetchHooks Function()
    >;
typedef $$CargosLiderazgoTableCreateCompanionBuilder =
    CargosLiderazgoCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String?> observacion,
      Value<bool> estado,
    });
typedef $$CargosLiderazgoTableUpdateCompanionBuilder =
    CargosLiderazgoCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String?> observacion,
      Value<bool> estado,
    });

class $$CargosLiderazgoTableFilterComposer
    extends Composer<_$AppDatabase, $CargosLiderazgoTable> {
  $$CargosLiderazgoTableFilterComposer({
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

  ColumnFilters<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CargosLiderazgoTableOrderingComposer
    extends Composer<_$AppDatabase, $CargosLiderazgoTable> {
  $$CargosLiderazgoTableOrderingComposer({
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

  ColumnOrderings<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CargosLiderazgoTableAnnotationComposer
    extends Composer<_$AppDatabase, $CargosLiderazgoTable> {
  $$CargosLiderazgoTableAnnotationComposer({
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

  GeneratedColumn<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$CargosLiderazgoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CargosLiderazgoTable,
          CargoLiderazgo,
          $$CargosLiderazgoTableFilterComposer,
          $$CargosLiderazgoTableOrderingComposer,
          $$CargosLiderazgoTableAnnotationComposer,
          $$CargosLiderazgoTableCreateCompanionBuilder,
          $$CargosLiderazgoTableUpdateCompanionBuilder,
          (
            CargoLiderazgo,
            BaseReferences<
              _$AppDatabase,
              $CargosLiderazgoTable,
              CargoLiderazgo
            >,
          ),
          CargoLiderazgo,
          PrefetchHooks Function()
        > {
  $$CargosLiderazgoTableTableManager(
    _$AppDatabase db,
    $CargosLiderazgoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CargosLiderazgoTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CargosLiderazgoTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CargosLiderazgoTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> observacion = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => CargosLiderazgoCompanion(
                id: id,
                nombre: nombre,
                observacion: observacion,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> observacion = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => CargosLiderazgoCompanion.insert(
                id: id,
                nombre: nombre,
                observacion: observacion,
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

typedef $$CargosLiderazgoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CargosLiderazgoTable,
      CargoLiderazgo,
      $$CargosLiderazgoTableFilterComposer,
      $$CargosLiderazgoTableOrderingComposer,
      $$CargosLiderazgoTableAnnotationComposer,
      $$CargosLiderazgoTableCreateCompanionBuilder,
      $$CargosLiderazgoTableUpdateCompanionBuilder,
      (
        CargoLiderazgo,
        BaseReferences<_$AppDatabase, $CargosLiderazgoTable, CargoLiderazgo>,
      ),
      CargoLiderazgo,
      PrefetchHooks Function()
    >;
typedef $$LiderUbicacionesTableCreateCompanionBuilder =
    LiderUbicacionesCompanion Function({
      Value<int> id,
      required String ubicacionId,
      required String liderId,
      Value<bool> estado,
      required String cargoLiderazgoId,
    });
typedef $$LiderUbicacionesTableUpdateCompanionBuilder =
    LiderUbicacionesCompanion Function({
      Value<int> id,
      Value<String> ubicacionId,
      Value<String> liderId,
      Value<bool> estado,
      Value<String> cargoLiderazgoId,
    });

class $$LiderUbicacionesTableFilterComposer
    extends Composer<_$AppDatabase, $LiderUbicacionesTable> {
  $$LiderUbicacionesTableFilterComposer({
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

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LiderUbicacionesTableOrderingComposer
    extends Composer<_$AppDatabase, $LiderUbicacionesTable> {
  $$LiderUbicacionesTableOrderingComposer({
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

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LiderUbicacionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiderUbicacionesTable> {
  $$LiderUbicacionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$LiderUbicacionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LiderUbicacionesTable,
          LiderUbicacion,
          $$LiderUbicacionesTableFilterComposer,
          $$LiderUbicacionesTableOrderingComposer,
          $$LiderUbicacionesTableAnnotationComposer,
          $$LiderUbicacionesTableCreateCompanionBuilder,
          $$LiderUbicacionesTableUpdateCompanionBuilder,
          (
            LiderUbicacion,
            BaseReferences<
              _$AppDatabase,
              $LiderUbicacionesTable,
              LiderUbicacion
            >,
          ),
          LiderUbicacion,
          PrefetchHooks Function()
        > {
  $$LiderUbicacionesTableTableManager(
    _$AppDatabase db,
    $LiderUbicacionesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$LiderUbicacionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LiderUbicacionesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$LiderUbicacionesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ubicacionId = const Value.absent(),
                Value<String> liderId = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<String> cargoLiderazgoId = const Value.absent(),
              }) => LiderUbicacionesCompanion(
                id: id,
                ubicacionId: ubicacionId,
                liderId: liderId,
                estado: estado,
                cargoLiderazgoId: cargoLiderazgoId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ubicacionId,
                required String liderId,
                Value<bool> estado = const Value.absent(),
                required String cargoLiderazgoId,
              }) => LiderUbicacionesCompanion.insert(
                id: id,
                ubicacionId: ubicacionId,
                liderId: liderId,
                estado: estado,
                cargoLiderazgoId: cargoLiderazgoId,
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

typedef $$LiderUbicacionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LiderUbicacionesTable,
      LiderUbicacion,
      $$LiderUbicacionesTableFilterComposer,
      $$LiderUbicacionesTableOrderingComposer,
      $$LiderUbicacionesTableAnnotationComposer,
      $$LiderUbicacionesTableCreateCompanionBuilder,
      $$LiderUbicacionesTableUpdateCompanionBuilder,
      (
        LiderUbicacion,
        BaseReferences<_$AppDatabase, $LiderUbicacionesTable, LiderUbicacion>,
      ),
      LiderUbicacion,
      PrefetchHooks Function()
    >;
typedef $$EquipoTableCreateCompanionBuilder =
    EquipoCompanion Function({
      Value<int> id,
      required String liderUbicacionId,
      required String trabajadorId,
      required String idRegistro,
      Value<bool> estado,
    });
typedef $$EquipoTableUpdateCompanionBuilder =
    EquipoCompanion Function({
      Value<int> id,
      Value<String> liderUbicacionId,
      Value<String> trabajadorId,
      Value<String> idRegistro,
      Value<bool> estado,
    });

class $$EquipoTableFilterComposer
    extends Composer<_$AppDatabase, $EquipoTable> {
  $$EquipoTableFilterComposer({
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

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EquipoTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipoTable> {
  $$EquipoTableOrderingComposer({
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

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipoTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipoTable> {
  $$EquipoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$EquipoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquipoTable,
          EquipoData,
          $$EquipoTableFilterComposer,
          $$EquipoTableOrderingComposer,
          $$EquipoTableAnnotationComposer,
          $$EquipoTableCreateCompanionBuilder,
          $$EquipoTableUpdateCompanionBuilder,
          (EquipoData, BaseReferences<_$AppDatabase, $EquipoTable, EquipoData>),
          EquipoData,
          PrefetchHooks Function()
        > {
  $$EquipoTableTableManager(_$AppDatabase db, $EquipoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EquipoTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EquipoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EquipoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> liderUbicacionId = const Value.absent(),
                Value<String> trabajadorId = const Value.absent(),
                Value<String> idRegistro = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => EquipoCompanion(
                id: id,
                liderUbicacionId: liderUbicacionId,
                trabajadorId: trabajadorId,
                idRegistro: idRegistro,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String liderUbicacionId,
                required String trabajadorId,
                required String idRegistro,
                Value<bool> estado = const Value.absent(),
              }) => EquipoCompanion.insert(
                id: id,
                liderUbicacionId: liderUbicacionId,
                trabajadorId: trabajadorId,
                idRegistro: idRegistro,
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

typedef $$EquipoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquipoTable,
      EquipoData,
      $$EquipoTableFilterComposer,
      $$EquipoTableOrderingComposer,
      $$EquipoTableAnnotationComposer,
      $$EquipoTableCreateCompanionBuilder,
      $$EquipoTableUpdateCompanionBuilder,
      (EquipoData, BaseReferences<_$AppDatabase, $EquipoTable, EquipoData>),
      EquipoData,
      PrefetchHooks Function()
    >;
typedef $$RegistroDiarioTableCreateCompanionBuilder =
    RegistroDiarioCompanion Function({
      Value<int> id,
      required String equipoId,
      required String registroBiometricoId,
      required DateTime fechaIngreso,
      required TimeOfDay horaIngreso,
      required DateTime fechaSalida,
      required TimeOfDay horaSalida,
      required bool ingresoSincronizado,
      required bool salidaSincronizada,
    });
typedef $$RegistroDiarioTableUpdateCompanionBuilder =
    RegistroDiarioCompanion Function({
      Value<int> id,
      Value<String> equipoId,
      Value<String> registroBiometricoId,
      Value<DateTime> fechaIngreso,
      Value<TimeOfDay> horaIngreso,
      Value<DateTime> fechaSalida,
      Value<TimeOfDay> horaSalida,
      Value<bool> ingresoSincronizado,
      Value<bool> salidaSincronizada,
    });

class $$RegistroDiarioTableFilterComposer
    extends Composer<_$AppDatabase, $RegistroDiarioTable> {
  $$RegistroDiarioTableFilterComposer({
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

  ColumnFilters<bool> get ingresoSincronizado => $composableBuilder(
    column: $table.ingresoSincronizado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get salidaSincronizada => $composableBuilder(
    column: $table.salidaSincronizada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RegistroDiarioTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistroDiarioTable> {
  $$RegistroDiarioTableOrderingComposer({
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

  ColumnOrderings<bool> get ingresoSincronizado => $composableBuilder(
    column: $table.ingresoSincronizado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get salidaSincronizada => $composableBuilder(
    column: $table.salidaSincronizada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RegistroDiarioTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistroDiarioTable> {
  $$RegistroDiarioTableAnnotationComposer({
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

  GeneratedColumn<bool> get ingresoSincronizado => $composableBuilder(
    column: $table.ingresoSincronizado,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get salidaSincronizada => $composableBuilder(
    column: $table.salidaSincronizada,
    builder: (column) => column,
  );
}

class $$RegistroDiarioTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistroDiarioTable,
          RegistroDiarioData,
          $$RegistroDiarioTableFilterComposer,
          $$RegistroDiarioTableOrderingComposer,
          $$RegistroDiarioTableAnnotationComposer,
          $$RegistroDiarioTableCreateCompanionBuilder,
          $$RegistroDiarioTableUpdateCompanionBuilder,
          (
            RegistroDiarioData,
            BaseReferences<
              _$AppDatabase,
              $RegistroDiarioTable,
              RegistroDiarioData
            >,
          ),
          RegistroDiarioData,
          PrefetchHooks Function()
        > {
  $$RegistroDiarioTableTableManager(
    _$AppDatabase db,
    $RegistroDiarioTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RegistroDiarioTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$RegistroDiarioTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RegistroDiarioTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> equipoId = const Value.absent(),
                Value<String> registroBiometricoId = const Value.absent(),
                Value<DateTime> fechaIngreso = const Value.absent(),
                Value<TimeOfDay> horaIngreso = const Value.absent(),
                Value<DateTime> fechaSalida = const Value.absent(),
                Value<TimeOfDay> horaSalida = const Value.absent(),
                Value<bool> ingresoSincronizado = const Value.absent(),
                Value<bool> salidaSincronizada = const Value.absent(),
              }) => RegistroDiarioCompanion(
                id: id,
                equipoId: equipoId,
                registroBiometricoId: registroBiometricoId,
                fechaIngreso: fechaIngreso,
                horaIngreso: horaIngreso,
                fechaSalida: fechaSalida,
                horaSalida: horaSalida,
                ingresoSincronizado: ingresoSincronizado,
                salidaSincronizada: salidaSincronizada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String equipoId,
                required String registroBiometricoId,
                required DateTime fechaIngreso,
                required TimeOfDay horaIngreso,
                required DateTime fechaSalida,
                required TimeOfDay horaSalida,
                required bool ingresoSincronizado,
                required bool salidaSincronizada,
              }) => RegistroDiarioCompanion.insert(
                id: id,
                equipoId: equipoId,
                registroBiometricoId: registroBiometricoId,
                fechaIngreso: fechaIngreso,
                horaIngreso: horaIngreso,
                fechaSalida: fechaSalida,
                horaSalida: horaSalida,
                ingresoSincronizado: ingresoSincronizado,
                salidaSincronizada: salidaSincronizada,
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

typedef $$RegistroDiarioTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistroDiarioTable,
      RegistroDiarioData,
      $$RegistroDiarioTableFilterComposer,
      $$RegistroDiarioTableOrderingComposer,
      $$RegistroDiarioTableAnnotationComposer,
      $$RegistroDiarioTableCreateCompanionBuilder,
      $$RegistroDiarioTableUpdateCompanionBuilder,
      (
        RegistroDiarioData,
        BaseReferences<_$AppDatabase, $RegistroDiarioTable, RegistroDiarioData>,
      ),
      RegistroDiarioData,
      PrefetchHooks Function()
    >;
typedef $$SyncEntitysTableCreateCompanionBuilder =
    SyncEntitysCompanion Function({
      Value<int> id,
      required String entityTableNameToSync,
      required String action,
      required String registerId,
      Value<DateTime> timestamp,
    });
typedef $$SyncEntitysTableUpdateCompanionBuilder =
    SyncEntitysCompanion Function({
      Value<int> id,
      Value<String> entityTableNameToSync,
      Value<String> action,
      Value<String> registerId,
      Value<DateTime> timestamp,
    });

class $$SyncEntitysTableFilterComposer
    extends Composer<_$AppDatabase, $SyncEntitysTable> {
  $$SyncEntitysTableFilterComposer({
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
}

class $$SyncEntitysTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncEntitysTable> {
  $$SyncEntitysTableOrderingComposer({
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
}

class $$SyncEntitysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncEntitysTable> {
  $$SyncEntitysTableAnnotationComposer({
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
}

class $$SyncEntitysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncEntitysTable,
          SyncEntity,
          $$SyncEntitysTableFilterComposer,
          $$SyncEntitysTableOrderingComposer,
          $$SyncEntitysTableAnnotationComposer,
          $$SyncEntitysTableCreateCompanionBuilder,
          $$SyncEntitysTableUpdateCompanionBuilder,
          (
            SyncEntity,
            BaseReferences<_$AppDatabase, $SyncEntitysTable, SyncEntity>,
          ),
          SyncEntity,
          PrefetchHooks Function()
        > {
  $$SyncEntitysTableTableManager(_$AppDatabase db, $SyncEntitysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncEntitysTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncEntitysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$SyncEntitysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityTableNameToSync = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> registerId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => SyncEntitysCompanion(
                id: id,
                entityTableNameToSync: entityTableNameToSync,
                action: action,
                registerId: registerId,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityTableNameToSync,
                required String action,
                required String registerId,
                Value<DateTime> timestamp = const Value.absent(),
              }) => SyncEntitysCompanion.insert(
                id: id,
                entityTableNameToSync: entityTableNameToSync,
                action: action,
                registerId: registerId,
                timestamp: timestamp,
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

typedef $$SyncEntitysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncEntitysTable,
      SyncEntity,
      $$SyncEntitysTableFilterComposer,
      $$SyncEntitysTableOrderingComposer,
      $$SyncEntitysTableAnnotationComposer,
      $$SyncEntitysTableCreateCompanionBuilder,
      $$SyncEntitysTableUpdateCompanionBuilder,
      (
        SyncEntity,
        BaseReferences<_$AppDatabase, $SyncEntitysTable, SyncEntity>,
      ),
      SyncEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TrabajadoresTableTableManager get trabajadores =>
      $$TrabajadoresTableTableManager(_db, _db.trabajadores);
  $$GrupoUbicacionesTableTableManager get grupoUbicaciones =>
      $$GrupoUbicacionesTableTableManager(_db, _db.grupoUbicaciones);
  $$UbicacionesTableTableManager get ubicaciones =>
      $$UbicacionesTableTableManager(_db, _db.ubicaciones);
  $$HorariosTableTableManager get horarios =>
      $$HorariosTableTableManager(_db, _db.horarios);
  $$RegistroBiometricoTableTableManager get registroBiometrico =>
      $$RegistroBiometricoTableTableManager(_db, _db.registroBiometrico);
  $$CargosLiderazgoTableTableManager get cargosLiderazgo =>
      $$CargosLiderazgoTableTableManager(_db, _db.cargosLiderazgo);
  $$LiderUbicacionesTableTableManager get liderUbicaciones =>
      $$LiderUbicacionesTableTableManager(_db, _db.liderUbicaciones);
  $$EquipoTableTableManager get equipo =>
      $$EquipoTableTableManager(_db, _db.equipo);
  $$RegistroDiarioTableTableManager get registroDiario =>
      $$RegistroDiarioTableTableManager(_db, _db.registroDiario);
  $$SyncEntitysTableTableManager get syncEntitys =>
      $$SyncEntitysTableTableManager(_db, _db.syncEntitys);
}
