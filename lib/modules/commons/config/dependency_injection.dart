import "package:dio/dio.dart";
import "package:get_it/get_it.dart";

import "../core/data/services/http_service_impl.dart";
import "../core/domain/services/http_service.dart";

final getIt = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();
  static void init() {
    getIt.registerFactory<HttpService>(() => HttpServiceImpl(Dio()));
  }
}
