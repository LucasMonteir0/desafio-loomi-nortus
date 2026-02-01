import "../../../../../commons/config/dependency_injection.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../repositories/auth_repository.dart";
import "sign_in_use_case.dart";

class SignInUseCaseImpl implements SignInUseCase {
  late final AuthRepository _authRepository;

  SignInUseCaseImpl() {
    _authRepository = getIt<AuthRepository>();
  }

  @override
  Future<ResultWrapper<bool>> call(String login, String password) {
    return _authRepository.signIn(login, password);
  }
}
