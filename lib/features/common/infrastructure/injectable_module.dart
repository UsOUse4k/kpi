import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModule {
  @Named("BaseUrl")
  String get baseUrl => "new-kpi2.kpi-drive.ru";

  @Named("HttpUrl")
  String get httpUrl => "https://$baseUrl/_api";

  @lazySingleton
  Dio dio(@Named("HttpUrl") String url) {
    final dio = Dio(
      BaseOptions(baseUrl: url, responseType: ResponseType.plain),
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          const token = "5eb4d9d065cada207d646c0046c019a2";

          options.headers['Authorization'] = "Bearer $token";

          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}
