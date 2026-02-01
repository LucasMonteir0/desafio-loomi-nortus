import "../../../../../commons/core/domain/entities/result_wrapper.dart";

abstract class SignUpUseCase {
  Future<ResultWrapper<bool>> call(String login, String password);
}
