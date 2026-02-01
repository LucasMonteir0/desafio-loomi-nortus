import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/repositories/auth_repository.dart";
import "../data_sources/auth_data_source.dart";

class AuthRepositoryImpl implements AuthRepository {
  late final AuthDataSource _authDataSource;

  AuthRepositoryImpl() {
    _authDataSource = getIt<AuthDataSource>();
  }

  @override
  Future<ResultWrapper<bool>> signIn(String login, String password) {
    return _authDataSource.signIn(login, password);
  }

  @override
  Future<ResultWrapper<bool>> signUp(String login, String password) {
    return _authDataSource.signUp(login, password);
  }
}
