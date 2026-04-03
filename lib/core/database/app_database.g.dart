// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completionTypeMeta =
      const VerificationMeta('completionType');
  @override
  late final GeneratedColumn<String> completionType = GeneratedColumn<String>(
      'completion_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('boolean'));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isOngoingMeta =
      const VerificationMeta('isOngoing');
  @override
  late final GeneratedColumn<bool> isOngoing = GeneratedColumn<bool>(
      'is_ongoing', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_ongoing" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _accentColorMeta =
      const VerificationMeta('accentColor');
  @override
  late final GeneratedColumn<int> accentColor = GeneratedColumn<int>(
      'accent_color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _reminderTimeMeta =
      const VerificationMeta('reminderTime');
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
      'reminder_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gracePeriodEnabledMeta =
      const VerificationMeta('gracePeriodEnabled');
  @override
  late final GeneratedColumn<bool> gracePeriodEnabled = GeneratedColumn<bool>(
      'grace_period_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("grace_period_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isPausedMeta =
      const VerificationMeta('isPaused');
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
      'is_paused', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_paused" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _pauseUntilMeta =
      const VerificationMeta('pauseUntil');
  @override
  late final GeneratedColumn<DateTime> pauseUntil = GeneratedColumn<DateTime>(
      'pause_until', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _archivedAtMeta =
      const VerificationMeta('archivedAt');
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
      'archived_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        completionType,
        unit,
        isOngoing,
        targetDate,
        accentColor,
        reminderTime,
        gracePeriodEnabled,
        isPaused,
        pauseUntil,
        isArchived,
        archivedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('completion_type')) {
      context.handle(
          _completionTypeMeta,
          completionType.isAcceptableOrUnknown(
              data['completion_type']!, _completionTypeMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('is_ongoing')) {
      context.handle(_isOngoingMeta,
          isOngoing.isAcceptableOrUnknown(data['is_ongoing']!, _isOngoingMeta));
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('accent_color')) {
      context.handle(
          _accentColorMeta,
          accentColor.isAcceptableOrUnknown(
              data['accent_color']!, _accentColorMeta));
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
          _reminderTimeMeta,
          reminderTime.isAcceptableOrUnknown(
              data['reminder_time']!, _reminderTimeMeta));
    }
    if (data.containsKey('grace_period_enabled')) {
      context.handle(
          _gracePeriodEnabledMeta,
          gracePeriodEnabled.isAcceptableOrUnknown(
              data['grace_period_enabled']!, _gracePeriodEnabledMeta));
    }
    if (data.containsKey('is_paused')) {
      context.handle(_isPausedMeta,
          isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta));
    }
    if (data.containsKey('pause_until')) {
      context.handle(
          _pauseUntilMeta,
          pauseUntil.isAcceptableOrUnknown(
              data['pause_until']!, _pauseUntilMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('archived_at')) {
      context.handle(
          _archivedAtMeta,
          archivedAt.isAcceptableOrUnknown(
              data['archived_at']!, _archivedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      completionType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}completion_type'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      isOngoing: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_ongoing'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date']),
      accentColor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accent_color']),
      reminderTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_time']),
      gracePeriodEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}grace_period_enabled'])!,
      isPaused: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_paused'])!,
      pauseUntil: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}pause_until']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      archivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}archived_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String name;
  final String? category;
  final String completionType;
  final String? unit;
  final bool isOngoing;
  final DateTime? targetDate;
  final int? accentColor;
  final String? reminderTime;
  final bool gracePeriodEnabled;
  final bool isPaused;
  final DateTime? pauseUntil;
  final bool isArchived;
  final DateTime? archivedAt;
  final DateTime createdAt;
  const Habit(
      {required this.id,
      required this.name,
      this.category,
      required this.completionType,
      this.unit,
      required this.isOngoing,
      this.targetDate,
      this.accentColor,
      this.reminderTime,
      required this.gracePeriodEnabled,
      required this.isPaused,
      this.pauseUntil,
      required this.isArchived,
      this.archivedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['completion_type'] = Variable<String>(completionType);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['is_ongoing'] = Variable<bool>(isOngoing);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || accentColor != null) {
      map['accent_color'] = Variable<int>(accentColor);
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    map['grace_period_enabled'] = Variable<bool>(gracePeriodEnabled);
    map['is_paused'] = Variable<bool>(isPaused);
    if (!nullToAbsent || pauseUntil != null) {
      map['pause_until'] = Variable<DateTime>(pauseUntil);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      completionType: Value(completionType),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      isOngoing: Value(isOngoing),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      accentColor: accentColor == null && nullToAbsent
          ? const Value.absent()
          : Value(accentColor),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      gracePeriodEnabled: Value(gracePeriodEnabled),
      isPaused: Value(isPaused),
      pauseUntil: pauseUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(pauseUntil),
      isArchived: Value(isArchived),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      completionType: serializer.fromJson<String>(json['completionType']),
      unit: serializer.fromJson<String?>(json['unit']),
      isOngoing: serializer.fromJson<bool>(json['isOngoing']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      accentColor: serializer.fromJson<int?>(json['accentColor']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
      gracePeriodEnabled: serializer.fromJson<bool>(json['gracePeriodEnabled']),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
      pauseUntil: serializer.fromJson<DateTime?>(json['pauseUntil']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'completionType': serializer.toJson<String>(completionType),
      'unit': serializer.toJson<String?>(unit),
      'isOngoing': serializer.toJson<bool>(isOngoing),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'accentColor': serializer.toJson<int?>(accentColor),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'gracePeriodEnabled': serializer.toJson<bool>(gracePeriodEnabled),
      'isPaused': serializer.toJson<bool>(isPaused),
      'pauseUntil': serializer.toJson<DateTime?>(pauseUntil),
      'isArchived': serializer.toJson<bool>(isArchived),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith(
          {int? id,
          String? name,
          Value<String?> category = const Value.absent(),
          String? completionType,
          Value<String?> unit = const Value.absent(),
          bool? isOngoing,
          Value<DateTime?> targetDate = const Value.absent(),
          Value<int?> accentColor = const Value.absent(),
          Value<String?> reminderTime = const Value.absent(),
          bool? gracePeriodEnabled,
          bool? isPaused,
          Value<DateTime?> pauseUntil = const Value.absent(),
          bool? isArchived,
          Value<DateTime?> archivedAt = const Value.absent(),
          DateTime? createdAt}) =>
      Habit(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category.present ? category.value : this.category,
        completionType: completionType ?? this.completionType,
        unit: unit.present ? unit.value : this.unit,
        isOngoing: isOngoing ?? this.isOngoing,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        accentColor: accentColor.present ? accentColor.value : this.accentColor,
        reminderTime:
            reminderTime.present ? reminderTime.value : this.reminderTime,
        gracePeriodEnabled: gracePeriodEnabled ?? this.gracePeriodEnabled,
        isPaused: isPaused ?? this.isPaused,
        pauseUntil: pauseUntil.present ? pauseUntil.value : this.pauseUntil,
        isArchived: isArchived ?? this.isArchived,
        archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      completionType: data.completionType.present
          ? data.completionType.value
          : this.completionType,
      unit: data.unit.present ? data.unit.value : this.unit,
      isOngoing: data.isOngoing.present ? data.isOngoing.value : this.isOngoing,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      accentColor:
          data.accentColor.present ? data.accentColor.value : this.accentColor,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      gracePeriodEnabled: data.gracePeriodEnabled.present
          ? data.gracePeriodEnabled.value
          : this.gracePeriodEnabled,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      pauseUntil:
          data.pauseUntil.present ? data.pauseUntil.value : this.pauseUntil,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      archivedAt:
          data.archivedAt.present ? data.archivedAt.value : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('completionType: $completionType, ')
          ..write('unit: $unit, ')
          ..write('isOngoing: $isOngoing, ')
          ..write('targetDate: $targetDate, ')
          ..write('accentColor: $accentColor, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('gracePeriodEnabled: $gracePeriodEnabled, ')
          ..write('isPaused: $isPaused, ')
          ..write('pauseUntil: $pauseUntil, ')
          ..write('isArchived: $isArchived, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      category,
      completionType,
      unit,
      isOngoing,
      targetDate,
      accentColor,
      reminderTime,
      gracePeriodEnabled,
      isPaused,
      pauseUntil,
      isArchived,
      archivedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.completionType == this.completionType &&
          other.unit == this.unit &&
          other.isOngoing == this.isOngoing &&
          other.targetDate == this.targetDate &&
          other.accentColor == this.accentColor &&
          other.reminderTime == this.reminderTime &&
          other.gracePeriodEnabled == this.gracePeriodEnabled &&
          other.isPaused == this.isPaused &&
          other.pauseUntil == this.pauseUntil &&
          other.isArchived == this.isArchived &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<String> completionType;
  final Value<String?> unit;
  final Value<bool> isOngoing;
  final Value<DateTime?> targetDate;
  final Value<int?> accentColor;
  final Value<String?> reminderTime;
  final Value<bool> gracePeriodEnabled;
  final Value<bool> isPaused;
  final Value<DateTime?> pauseUntil;
  final Value<bool> isArchived;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.completionType = const Value.absent(),
    this.unit = const Value.absent(),
    this.isOngoing = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.gracePeriodEnabled = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.pauseUntil = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.completionType = const Value.absent(),
    this.unit = const Value.absent(),
    this.isOngoing = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.gracePeriodEnabled = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.pauseUntil = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? completionType,
    Expression<String>? unit,
    Expression<bool>? isOngoing,
    Expression<DateTime>? targetDate,
    Expression<int>? accentColor,
    Expression<String>? reminderTime,
    Expression<bool>? gracePeriodEnabled,
    Expression<bool>? isPaused,
    Expression<DateTime>? pauseUntil,
    Expression<bool>? isArchived,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (completionType != null) 'completion_type': completionType,
      if (unit != null) 'unit': unit,
      if (isOngoing != null) 'is_ongoing': isOngoing,
      if (targetDate != null) 'target_date': targetDate,
      if (accentColor != null) 'accent_color': accentColor,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (gracePeriodEnabled != null)
        'grace_period_enabled': gracePeriodEnabled,
      if (isPaused != null) 'is_paused': isPaused,
      if (pauseUntil != null) 'pause_until': pauseUntil,
      if (isArchived != null) 'is_archived': isArchived,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? category,
      Value<String>? completionType,
      Value<String?>? unit,
      Value<bool>? isOngoing,
      Value<DateTime?>? targetDate,
      Value<int?>? accentColor,
      Value<String?>? reminderTime,
      Value<bool>? gracePeriodEnabled,
      Value<bool>? isPaused,
      Value<DateTime?>? pauseUntil,
      Value<bool>? isArchived,
      Value<DateTime?>? archivedAt,
      Value<DateTime>? createdAt}) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      completionType: completionType ?? this.completionType,
      unit: unit ?? this.unit,
      isOngoing: isOngoing ?? this.isOngoing,
      targetDate: targetDate ?? this.targetDate,
      accentColor: accentColor ?? this.accentColor,
      reminderTime: reminderTime ?? this.reminderTime,
      gracePeriodEnabled: gracePeriodEnabled ?? this.gracePeriodEnabled,
      isPaused: isPaused ?? this.isPaused,
      pauseUntil: pauseUntil ?? this.pauseUntil,
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (completionType.present) {
      map['completion_type'] = Variable<String>(completionType.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (isOngoing.present) {
      map['is_ongoing'] = Variable<bool>(isOngoing.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<int>(accentColor.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (gracePeriodEnabled.present) {
      map['grace_period_enabled'] = Variable<bool>(gracePeriodEnabled.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (pauseUntil.present) {
      map['pause_until'] = Variable<DateTime>(pauseUntil.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('completionType: $completionType, ')
          ..write('unit: $unit, ')
          ..write('isOngoing: $isOngoing, ')
          ..write('targetDate: $targetDate, ')
          ..write('accentColor: $accentColor, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('gracePeriodEnabled: $gracePeriodEnabled, ')
          ..write('isPaused: $isPaused, ')
          ..write('pauseUntil: $pauseUntil, ')
          ..write('isArchived: $isArchived, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckInsTable extends CheckIns with TableInfo<$CheckInsTable, CheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES habits (id) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, habitId, date, completed, value, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(Insertable<CheckIn> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckIn(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habit_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }
}

class CheckIn extends DataClass implements Insertable<CheckIn> {
  final int id;
  final int habitId;
  final DateTime date;
  final bool completed;
  final double? value;
  final String? note;
  final DateTime createdAt;
  const CheckIn(
      {required this.id,
      required this.habitId,
      required this.date,
      required this.completed,
      this.value,
      this.note,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['date'] = Variable<DateTime>(date);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CheckInsCompanion toCompanion(bool nullToAbsent) {
    return CheckInsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      completed: Value(completed),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory CheckIn.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckIn(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      date: serializer.fromJson<DateTime>(json['date']),
      completed: serializer.fromJson<bool>(json['completed']),
      value: serializer.fromJson<double?>(json['value']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'date': serializer.toJson<DateTime>(date),
      'completed': serializer.toJson<bool>(completed),
      'value': serializer.toJson<double?>(value),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CheckIn copyWith(
          {int? id,
          int? habitId,
          DateTime? date,
          bool? completed,
          Value<double?> value = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? createdAt}) =>
      CheckIn(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        completed: completed ?? this.completed,
        value: value.present ? value.value : this.value,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
      );
  CheckIn copyWithCompanion(CheckInsCompanion data) {
    return CheckIn(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      completed: data.completed.present ? data.completed.value : this.completed,
      value: data.value.present ? data.value.value : this.value,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckIn(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('completed: $completed, ')
          ..write('value: $value, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, date, completed, value, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckIn &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.completed == this.completed &&
          other.value == this.value &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class CheckInsCompanion extends UpdateCompanion<CheckIn> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<DateTime> date;
  final Value<bool> completed;
  final Value<double?> value;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const CheckInsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.completed = const Value.absent(),
    this.value = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckInsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required DateTime date,
    this.completed = const Value.absent(),
    this.value = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : habitId = Value(habitId),
        date = Value(date);
  static Insertable<CheckIn> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<DateTime>? date,
    Expression<bool>? completed,
    Expression<double>? value,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (completed != null) 'completed': completed,
      if (value != null) 'value': value,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckInsCompanion copyWith(
      {Value<int>? id,
      Value<int>? habitId,
      Value<DateTime>? date,
      Value<bool>? completed,
      Value<double?>? value,
      Value<String?>? note,
      Value<DateTime>? createdAt}) {
    return CheckInsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      value: value ?? this.value,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('completed: $completed, ')
          ..write('value: $value, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  late final CheckInsDao checkInsDao = CheckInsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habits, checkIns];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('habits',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('check_ins', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> category,
  Value<String> completionType,
  Value<String?> unit,
  Value<bool> isOngoing,
  Value<DateTime?> targetDate,
  Value<int?> accentColor,
  Value<String?> reminderTime,
  Value<bool> gracePeriodEnabled,
  Value<bool> isPaused,
  Value<DateTime?> pauseUntil,
  Value<bool> isArchived,
  Value<DateTime?> archivedAt,
  Value<DateTime> createdAt,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> category,
  Value<String> completionType,
  Value<String?> unit,
  Value<bool> isOngoing,
  Value<DateTime?> targetDate,
  Value<int?> accentColor,
  Value<String?> reminderTime,
  Value<bool> gracePeriodEnabled,
  Value<bool> isPaused,
  Value<DateTime?> pauseUntil,
  Value<bool> isArchived,
  Value<DateTime?> archivedAt,
  Value<DateTime> createdAt,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CheckInsTable, List<CheckIn>> _checkInsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.checkIns,
          aliasName: $_aliasNameGenerator(db.habits.id, db.checkIns.habitId));

  $$CheckInsTableProcessedTableManager get checkInsRefs {
    final manager = $$CheckInsTableTableManager($_db, $_db.checkIns)
        .filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completionType => $composableBuilder(
      column: $table.completionType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isOngoing => $composableBuilder(
      column: $table.isOngoing, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accentColor => $composableBuilder(
      column: $table.accentColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get gracePeriodEnabled => $composableBuilder(
      column: $table.gracePeriodEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPaused => $composableBuilder(
      column: $table.isPaused, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get pauseUntil => $composableBuilder(
      column: $table.pauseUntil, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> checkInsRefs(
      Expression<bool> Function($$CheckInsTableFilterComposer f) f) {
    final $$CheckInsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.checkIns,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CheckInsTableFilterComposer(
              $db: $db,
              $table: $db.checkIns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completionType => $composableBuilder(
      column: $table.completionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isOngoing => $composableBuilder(
      column: $table.isOngoing, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accentColor => $composableBuilder(
      column: $table.accentColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gracePeriodEnabled => $composableBuilder(
      column: $table.gracePeriodEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPaused => $composableBuilder(
      column: $table.isPaused, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get pauseUntil => $composableBuilder(
      column: $table.pauseUntil, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get completionType => $composableBuilder(
      column: $table.completionType, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get isOngoing =>
      $composableBuilder(column: $table.isOngoing, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<int> get accentColor => $composableBuilder(
      column: $table.accentColor, builder: (column) => column);

  GeneratedColumn<String> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => column);

  GeneratedColumn<bool> get gracePeriodEnabled => $composableBuilder(
      column: $table.gracePeriodEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<DateTime> get pauseUntil => $composableBuilder(
      column: $table.pauseUntil, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> checkInsRefs<T extends Object>(
      Expression<T> Function($$CheckInsTableAnnotationComposer a) f) {
    final $$CheckInsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.checkIns,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CheckInsTableAnnotationComposer(
              $db: $db,
              $table: $db.checkIns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, $$HabitsTableReferences),
    Habit,
    PrefetchHooks Function({bool checkInsRefs})> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String> completionType = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<bool> isOngoing = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<int?> accentColor = const Value.absent(),
            Value<String?> reminderTime = const Value.absent(),
            Value<bool> gracePeriodEnabled = const Value.absent(),
            Value<bool> isPaused = const Value.absent(),
            Value<DateTime?> pauseUntil = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            name: name,
            category: category,
            completionType: completionType,
            unit: unit,
            isOngoing: isOngoing,
            targetDate: targetDate,
            accentColor: accentColor,
            reminderTime: reminderTime,
            gracePeriodEnabled: gracePeriodEnabled,
            isPaused: isPaused,
            pauseUntil: pauseUntil,
            isArchived: isArchived,
            archivedAt: archivedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> category = const Value.absent(),
            Value<String> completionType = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<bool> isOngoing = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<int?> accentColor = const Value.absent(),
            Value<String?> reminderTime = const Value.absent(),
            Value<bool> gracePeriodEnabled = const Value.absent(),
            Value<bool> isPaused = const Value.absent(),
            Value<DateTime?> pauseUntil = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            name: name,
            category: category,
            completionType: completionType,
            unit: unit,
            isOngoing: isOngoing,
            targetDate: targetDate,
            accentColor: accentColor,
            reminderTime: reminderTime,
            gracePeriodEnabled: gracePeriodEnabled,
            isPaused: isPaused,
            pauseUntil: pauseUntil,
            isArchived: isArchived,
            archivedAt: archivedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$HabitsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({checkInsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (checkInsRefs) db.checkIns],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (checkInsRefs)
                    await $_getPrefetchedData<Habit, $HabitsTable, CheckIn>(
                        currentTable: table,
                        referencedTable:
                            $$HabitsTableReferences._checkInsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HabitsTableReferences(db, table, p0).checkInsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.habitId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HabitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, $$HabitsTableReferences),
    Habit,
    PrefetchHooks Function({bool checkInsRefs})>;
typedef $$CheckInsTableCreateCompanionBuilder = CheckInsCompanion Function({
  Value<int> id,
  required int habitId,
  required DateTime date,
  Value<bool> completed,
  Value<double?> value,
  Value<String?> note,
  Value<DateTime> createdAt,
});
typedef $$CheckInsTableUpdateCompanionBuilder = CheckInsCompanion Function({
  Value<int> id,
  Value<int> habitId,
  Value<DateTime> date,
  Value<bool> completed,
  Value<double?> value,
  Value<String?> note,
  Value<DateTime> createdAt,
});

final class $$CheckInsTableReferences
    extends BaseReferences<_$AppDatabase, $CheckInsTable, CheckIn> {
  $$CheckInsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits
      .createAlias($_aliasNameGenerator(db.checkIns.habitId, db.habits.id));

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager($_db, $_db.habits)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableFilterComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableOrderingComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableAnnotationComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CheckInsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CheckInsTable,
    CheckIn,
    $$CheckInsTableFilterComposer,
    $$CheckInsTableOrderingComposer,
    $$CheckInsTableAnnotationComposer,
    $$CheckInsTableCreateCompanionBuilder,
    $$CheckInsTableUpdateCompanionBuilder,
    (CheckIn, $$CheckInsTableReferences),
    CheckIn,
    PrefetchHooks Function({bool habitId})> {
  $$CheckInsTableTableManager(_$AppDatabase db, $CheckInsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> habitId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<double?> value = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CheckInsCompanion(
            id: id,
            habitId: habitId,
            date: date,
            completed: completed,
            value: value,
            note: note,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int habitId,
            required DateTime date,
            Value<bool> completed = const Value.absent(),
            Value<double?> value = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CheckInsCompanion.insert(
            id: id,
            habitId: habitId,
            date: date,
            completed: completed,
            value: value,
            note: note,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CheckInsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
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
                      dynamic>>(state) {
                if (habitId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.habitId,
                    referencedTable:
                        $$CheckInsTableReferences._habitIdTable(db),
                    referencedColumn:
                        $$CheckInsTableReferences._habitIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CheckInsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CheckInsTable,
    CheckIn,
    $$CheckInsTableFilterComposer,
    $$CheckInsTableOrderingComposer,
    $$CheckInsTableAnnotationComposer,
    $$CheckInsTableCreateCompanionBuilder,
    $$CheckInsTableUpdateCompanionBuilder,
    (CheckIn, $$CheckInsTableReferences),
    CheckIn,
    PrefetchHooks Function({bool habitId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
}
