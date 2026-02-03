import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/profile_entity.dart";
import "../../entities/update_profile_entity.dart";

abstract class UpdateProfileUseCase {
  Future<ResultWrapper<ProfileEntity>> call(UpdateProfileEntity profile);
}
