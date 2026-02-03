import "package:dio/dio.dart";
import "package:get_it/get_it.dart";

import "../../auth/core/data/data_sources/auth_data_source.dart";
import "../../auth/core/data/data_sources/auth_data_source_impl.dart";
import "../../auth/core/data/repositories/auth_repository_impl.dart";
import "../../auth/core/domain/repositories/auth_repository.dart";
import "../../auth/core/domain/use_cases/sign_in/sign_in_use_case.dart";
import "../../auth/core/domain/use_cases/sign_in/sign_in_use_case_impl.dart";
import "../../auth/core/domain/use_cases/sign_up/sign_up_use_case.dart";
import "../../auth/core/domain/use_cases/sign_up/sign_up_use_case_impl.dart";
import "../../auth/presentation/blocs/sign_in_bloc.dart";
import "../../auth/presentation/blocs/sign_out_bloc.dart";
import "../../auth/presentation/blocs/sign_up_bloc.dart";
import "../../news/core/data/data_sources/news_data_source.dart";
import "../../news/core/data/data_sources/news_data_source_impl.dart";
import "../../news/core/data/repositories/news_repository_impl.dart";
import "../../news/core/domain/repositories/news_repository.dart";
import "../../news/core/domain/use_cases/get_news/get_news_use_case.dart";
import "../../news/core/domain/use_cases/get_news/get_news_use_case_impl.dart";
import "../../news/core/domain/use_cases/get_news_detail/get_news_detail_use_case.dart";
import "../../news/core/domain/use_cases/get_news_detail/get_news_detail_use_case_impl.dart";
import "../../news/presentation/blocs/get_news_bloc.dart";
import "../../news/presentation/blocs/get_news_detail_bloc.dart";
import "../../profile/core/data/data_sources/profile_data_source.dart";
import "../../profile/core/data/data_sources/profile_data_source_impl.dart";
import "../../profile/core/data/repositories/profile_repository_impl.dart";
import "../../profile/core/domain/repositories/profile_repository.dart";
import "../../profile/core/domain/use_cases/get_profile/get_profile_use_case.dart";
import "../../profile/core/domain/use_cases/get_profile/get_profile_use_case_impl.dart";
import "../../profile/core/domain/use_cases/update_profile/update_profile_use_case.dart";
import "../../profile/core/domain/use_cases/update_profile/update_profile_use_case_impl.dart";
import "../../profile/presentation/blocs/get_profile_bloc.dart";
import "../../profile/presentation/blocs/update_profile_bloc.dart";
import "../core/data/services/http_service_impl.dart";
import "../core/domain/services/http_service.dart";

final getIt = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();
  static void init() {
    getIt.registerFactory<HttpService>(() => HttpServiceImpl(Dio()));

    getIt.registerFactory<AuthDataSource>(() => AuthDataSourceImpl());
    getIt.registerFactory<NewsDataSource>(() => NewsDataSourceImpl());
    getIt.registerFactory<ProfileDataSource>(() => ProfileDataSourceImpl());

    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
    getIt.registerFactory<NewsRepository>(() => NewsRepositoryImpl());
    getIt.registerFactory<ProfileRepository>(() => ProfileRepositoryImpl());

    getIt.registerFactory<SignInUseCase>(() => SignInUseCaseImpl());
    getIt.registerFactory<SignUpUseCase>(() => SignUpUseCaseImpl());
    getIt.registerFactory<GetNewsUseCase>(() => GetNewsUseCaseImpl());
    getIt.registerFactory<GetNewsDetailUseCase>(
      () => GetNewsDetailUseCaseImpl(),
    );
    getIt.registerFactory<GetProfileUseCase>(() => GetProfileUseCaseImpl());
    getIt.registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCaseImpl(),
    );

    getIt.registerFactory<SignUpBloc>(() => SignUpBloc());
    getIt.registerFactory<SignInBloc>(() => SignInBloc());
    getIt.registerFactory<SignOutBloc>(() => SignOutBloc());
    getIt.registerFactory<GetNewsBloc>(() => GetNewsBloc());
    getIt.registerFactory<GetNewsDetailBloc>(() => GetNewsDetailBloc());
    getIt.registerFactory<GetProfileBloc>(() => GetProfileBloc());
    getIt.registerFactory<UpdateProfileBloc>(() => UpdateProfileBloc());
  }
}
