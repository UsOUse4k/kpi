// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kpi/features/common/infrastructure/injectable_module.dart'
    as _i8;
import 'package:kpi/features/kpi/application/get_tasks/tasks_cubit.dart' as _i6;
import 'package:kpi/features/kpi/application/update_task/update_tasks_bloc.dart'
    as _i7;
import 'package:kpi/features/kpi/domain/i_task_repository.dart' as _i4;
import 'package:kpi/features/kpi/infrastructure/kpi_task_repository.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<String>(
      () => injectableModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<String>(
      () => injectableModule.httpUrl,
      instanceName: 'HttpUrl',
    );
    gh.lazySingleton<_i3.Dio>(
        () => injectableModule.dio(gh<String>(instanceName: 'HttpUrl')));
    gh.lazySingleton<_i4.ITaskRepository>(
        () => _i5.KPITaskRepository(gh<_i3.Dio>()));
    gh.singleton<_i6.TasksCubit>(_i6.TasksCubit(gh<_i4.ITaskRepository>()));
    gh.singleton<_i7.UpdateTasksBloc>(_i7.UpdateTasksBloc(
      gh<_i6.TasksCubit>(),
      gh<_i4.ITaskRepository>(),
    ));
    return this;
  }
}

class _$InjectableModule extends _i8.InjectableModule {}
