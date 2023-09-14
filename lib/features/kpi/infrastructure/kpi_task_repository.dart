import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart' hide Task;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kpi/features/common/domain/failures.dart';
import 'package:kpi/features/kpi/domain/i_task_repository.dart';
import 'package:kpi/features/kpi/domain/task.dart';
import 'package:kpi/features/kpi/infrastructure/task_rm.dart';

@LazySingleton(as: ITaskRepository)
class KPITaskRepository implements ITaskRepository {
  final Dio _dio;

  KPITaskRepository(this._dio);

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final response = await _dio.get(
        "/indicators/get_mo_indicators",
        queryParameters: {
          "period_start": "2023-08-01",
          "period_end": "2023-08-31",
          "period_key": "month",
          "requested_mo_id": "97",
          "behaviour_key": "task",
          "with_result": "false",
          "response_fields": "name,indicator_to_mo_id,parent_id,order",
          "auth_user_id": "1",
        },
      );

      final results = jsonDecode(response.data);

      final tasks = results['DATA']['rows'];

      final List<Task> list = [];
      tasks.forEach((c) => list.add(TaskRM.fromJson(c).toDomain()));

      return right(list);
    } on DioException catch (err) {
      print(err);
      return left(const Failure.unexpected());
    } on SocketException catch (_) {
      return left(const Failure.unexpected());
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(Task updatedTask) async {
    try {
      await _dio.post(
        "/indicators/save_indicator_instance_field",
        data: {
          "period_start": "2023-08-01",
          "period_end": "2023-08-31",
          "period_key": "month",
          "indicator_to_mo_id": updatedTask.id,
          "field_name": "parent_id",
          "field_value": updatedTask.parentId,
          "auth_user_id": 1,
        },
      );

      await _dio.post(
        "/indicators/save_indicator_instance_field",
        data: {
          "period_start": "2023-08-01",
          "period_end": "2023-08-31",
          "period_key": "month",
          "indicator_to_mo_id": updatedTask.id,
          "field_name": "order",
          "field_value": updatedTask.order,
          "auth_user_id": 1,
        },
      );

      return right(unit);
    } on DioException catch (_) {
      return left(const Failure.unexpected());
    } on SocketException catch (_) {
      return left(const Failure.unexpected());
    }
  }
}
