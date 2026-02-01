import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/config/urls.dart";
import "../../../../commons/core/domain/entities/api/api_error.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../commons/core/domain/services/http_service.dart";
import "../../../../commons/utils/errors/errors.dart";
import "../../../../commons/utils/errors/handle_errors.dart";
import "auth_data_source.dart";

class AuthDataSourceImpl implements AuthDataSource {
  late HttpService _http;

  AuthDataSourceImpl() {
    _http = getIt<HttpService>();
  }
  @override
  Future<ResultWrapper<bool>> signIn(String login, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      //Simular como se o usuário não existisse
      if (login != "desafioLoomi" || password != "senha123") {
        return ResultWrapper.error(
          NotFoundError(message: "Login ou senha inválidos."),
        );
      }

      final body = {"login": login, "password": password};
      await _http.post("${Urls.baseUrl}/auth", data: body);

      return ResultWrapper.success(true);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(message: "Login ou senha inválidos."),
      );
    }
  }

  @override
  Future<ResultWrapper<bool>> signUp(String login, String password) async {
    await Future.delayed(const Duration(seconds: 3));

    await Future.delayed(const Duration(seconds: 3));

    //Simular um registro de novo usuário. Validações que deveriam ser feitas pelo lado do backend.
    if (login == "desafioLoomi") {
      return ResultWrapper.error(
        ConflictError(message: "Este login já existe."),
      );
    }

    if (login.isEmpty || password.isEmpty) {
      return ResultWrapper.error(
        BadRequestError(message: "Login e senha devem ser informados."),
      );
    }

    if (password.length < 8 ||
        !password.contains(RegExp(r"[a-zA-Z]")) ||
        !password.contains(RegExp(r"[0-9]"))) {
      return ResultWrapper.error(BadRequestError(message: "Senha inválida."));
    }

    return ResultWrapper.success(true);
  }
}
