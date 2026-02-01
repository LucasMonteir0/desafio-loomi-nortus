import "../../../../commons/core/domain/entities/result_wrapper.dart";

abstract class AuthRepository {
  Future<ResultWrapper<bool>> signUp(String login, String password);
  Future<ResultWrapper<bool>> signIn(String login, String password);
}
