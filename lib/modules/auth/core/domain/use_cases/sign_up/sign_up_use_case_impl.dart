import "../../../../../commons/config/dependency_injection.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../repositories/auth_repository.dart";
import "sign_up_use_case.dart";

class SignUpUseCaseImpl implements SignUpUseCase {
  late final AuthRepository _authRepository;

  SignUpUseCaseImpl() {
    _authRepository = getIt<AuthRepository>();
  }

  @override
  Future<ResultWrapper<bool>> call(String login, String password) {
    return _authRepository.signUp(login, password);
  }
}
