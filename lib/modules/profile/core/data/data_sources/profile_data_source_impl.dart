import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/config/urls.dart";
import "../../../../commons/core/domain/entities/api/api_error.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../commons/core/domain/services/http_service.dart";
import "../../../../commons/utils/errors/errors.dart";
import "../../../../commons/utils/errors/handle_errors.dart";
import "../../domain/entities/profile_entity.dart";
import "../../domain/entities/update_profile_entity.dart";
import "../models/profile_model.dart";
import "../models/update_profile_model.dart";
import "profile_data_source.dart";

class ProfileDataSourceImpl implements ProfileDataSource {
  late HttpService _http;

  ProfileDataSourceImpl() {
    _http = getIt<HttpService>();
  }

  @override
  Future<ResultWrapper<ProfileEntity>> getProfile() async {
    try {
      final futures = await Future.wait([
        _http.get<Map<String, dynamic>>("${Urls.baseUrl}/user"),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      final response = futures.first;
      final data = response.data!["data"] as Map<String, dynamic>;
      final profile = ProfileModel.fromJson(data);

      return ResultWrapper.success(profile);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(message: "Não foi possível carregar o perfil."),
      );
    }
  }

  @override
  Future<ResultWrapper<ProfileEntity>> updateProfile(
    UpdateProfileEntity profile,
  ) async {
    try {
      final body = UpdateProfileModel.fromEntity(profile).toJson();

      final futures = await Future.wait([
        _http.patch<Map<String, dynamic>>("${Urls.baseUrl}/user", data: body),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      final response = futures.first;
      final data = response.data!["data"] as Map<String, dynamic>;
      final updatedProfile = ProfileModel.fromJson(data);

      return ResultWrapper.success(updatedProfile);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(message: "Não foi possível atualizar o perfil."),
      );
    }
  }
}
