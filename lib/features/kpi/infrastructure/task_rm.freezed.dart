// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_rm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskRM _$TaskRMFromJson(Map<String, dynamic> json) {
  return _TaskRM.fromJson(json);
}

/// @nodoc
mixin _$TaskRM {
  @JsonKey(name: "indicator_to_mo_id")
  int get indicatorToMoId => throw _privateConstructorUsedError;
  @JsonKey(name: "parent_id")
  int get parentId => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskRMCopyWith<TaskRM> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskRMCopyWith<$Res> {
  factory $TaskRMCopyWith(TaskRM value, $Res Function(TaskRM) then) =
      _$TaskRMCopyWithImpl<$Res, TaskRM>;
  @useResult
  $Res call(
      {@JsonKey(name: "indicator_to_mo_id") int indicatorToMoId,
      @JsonKey(name: "parent_id") int parentId,
      int order,
      String name});
}

/// @nodoc
class _$TaskRMCopyWithImpl<$Res, $Val extends TaskRM>
    implements $TaskRMCopyWith<$Res> {
  _$TaskRMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? indicatorToMoId = null,
    Object? parentId = null,
    Object? order = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      indicatorToMoId: null == indicatorToMoId
          ? _value.indicatorToMoId
          : indicatorToMoId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskRMCopyWith<$Res> implements $TaskRMCopyWith<$Res> {
  factory _$$_TaskRMCopyWith(_$_TaskRM value, $Res Function(_$_TaskRM) then) =
      __$$_TaskRMCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "indicator_to_mo_id") int indicatorToMoId,
      @JsonKey(name: "parent_id") int parentId,
      int order,
      String name});
}

/// @nodoc
class __$$_TaskRMCopyWithImpl<$Res>
    extends _$TaskRMCopyWithImpl<$Res, _$_TaskRM>
    implements _$$_TaskRMCopyWith<$Res> {
  __$$_TaskRMCopyWithImpl(_$_TaskRM _value, $Res Function(_$_TaskRM) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? indicatorToMoId = null,
    Object? parentId = null,
    Object? order = null,
    Object? name = null,
  }) {
    return _then(_$_TaskRM(
      indicatorToMoId: null == indicatorToMoId
          ? _value.indicatorToMoId
          : indicatorToMoId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskRM extends _TaskRM {
  const _$_TaskRM(
      {@JsonKey(name: "indicator_to_mo_id") required this.indicatorToMoId,
      @JsonKey(name: "parent_id") required this.parentId,
      required this.order,
      required this.name})
      : super._();

  factory _$_TaskRM.fromJson(Map<String, dynamic> json) =>
      _$$_TaskRMFromJson(json);

  @override
  @JsonKey(name: "indicator_to_mo_id")
  final int indicatorToMoId;
  @override
  @JsonKey(name: "parent_id")
  final int parentId;
  @override
  final int order;
  @override
  final String name;

  @override
  String toString() {
    return 'TaskRM(indicatorToMoId: $indicatorToMoId, parentId: $parentId, order: $order, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskRM &&
            (identical(other.indicatorToMoId, indicatorToMoId) ||
                other.indicatorToMoId == indicatorToMoId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, indicatorToMoId, parentId, order, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskRMCopyWith<_$_TaskRM> get copyWith =>
      __$$_TaskRMCopyWithImpl<_$_TaskRM>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskRMToJson(
      this,
    );
  }
}

abstract class _TaskRM extends TaskRM {
  const factory _TaskRM(
      {@JsonKey(name: "indicator_to_mo_id") required final int indicatorToMoId,
      @JsonKey(name: "parent_id") required final int parentId,
      required final int order,
      required final String name}) = _$_TaskRM;
  const _TaskRM._() : super._();

  factory _TaskRM.fromJson(Map<String, dynamic> json) = _$_TaskRM.fromJson;

  @override
  @JsonKey(name: "indicator_to_mo_id")
  int get indicatorToMoId;
  @override
  @JsonKey(name: "parent_id")
  int get parentId;
  @override
  int get order;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_TaskRMCopyWith<_$_TaskRM> get copyWith =>
      throw _privateConstructorUsedError;
}
