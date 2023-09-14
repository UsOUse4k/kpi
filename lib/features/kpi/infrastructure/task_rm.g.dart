// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskRM _$$_TaskRMFromJson(Map<String, dynamic> json) => _$_TaskRM(
      indicatorToMoId: json['indicator_to_mo_id'] as int,
      parentId: json['parent_id'] as int,
      order: json['order'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_TaskRMToJson(_$_TaskRM instance) => <String, dynamic>{
      'indicator_to_mo_id': instance.indicatorToMoId,
      'parent_id': instance.parentId,
      'order': instance.order,
      'name': instance.name,
    };
