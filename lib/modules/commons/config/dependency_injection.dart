import "package:dio/dio.dart";
import "package:get_it/get_it.dart";

import "../../auth/core/data/data_sources/auth_data_source.dart";
import "../../auth/core/data/data_sources/auth_data_source_impl.dart";
import "../../auth/core/data/repositories/auth_repository_impl.dart";
import "../../auth/core/domain/repositories/auth_repository.dart";
import "../../auth/core/domain/use_cases/sign_in/sign_in_use_case.dart";
import "../../auth/core/domain/use_cases/sign_in/sign_in_use_case_impl.dart";
import "../../auth/presentation/blocs/sign_in_bloc.dart";
import "../../auth/core/domain/use_cases/sign_up/sign_up_use_case.dart";
import "../../auth/core/domain/use_cases/sign_up/sign_up_use_case_impl.dart";
import "../../auth/presentation/blocs/sign_up_bloc.dart";
import "../core/data/services/http_service_impl.dart";
import "../core/domain/services/http_service.dart";

final getIt = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();
  static void init() {
    //SERVICES
    getIt.registerFactory<HttpService>(() => HttpServiceImpl(Dio()));

    //DATA SOURCES
    getIt.registerFactory<AuthDataSource>(() => AuthDataSourceImpl());

    //REPOSITORIES
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl());

    //USE CASES
    getIt.registerFactory<SignInUseCase>(() => SignInUseCaseImpl());
    getIt.registerFactory<SignUpUseCase>(() => SignUpUseCaseImpl());

    //BLOCS
    getIt.registerFactory<SignUpBloc>(() => SignUpBloc());
    getIt.registerFactory<SignInBloc>(() => SignInBloc());
  }
}
