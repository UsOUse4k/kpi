import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kpi/config/routes/router.dart';
import 'package:kpi/config/theme/theme.dart';
import 'package:kpi/features/common/application/global_bloc_observer.dart';
import 'package:kpi/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureInjection(Environment.prod);

  Bloc.observer = GlobalBlocObserver();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      routerConfig: appRouter(),
    );
  }
}
