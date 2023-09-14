import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kpi/features/kpi/application/update_task/update_tasks_bloc.dart';
import 'package:kpi/features/kpi/application/get_tasks/tasks_cubit.dart';
import 'package:kpi/features/kpi/presentation/pages/kpi_page.dart';
import 'package:kpi/injection.dart';

appRouter() => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) => '/home',
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UpdateTasksBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<TasksCubit>()..getTasks(),
              ),
            ],
            child: const KPIPage(),
          ),
        ),
      ],
    );
