import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/profile_entity.dart";
import "../../domain/entities/update_profile_entity.dart";

abstract class ProfileDataSource {
  Future<ResultWrapper<ProfileEntity>> getProfile();
  Future<ResultWrapper<ProfileEntity>> updateProfile(
    UpdateProfileEntity profile,
  );
}
