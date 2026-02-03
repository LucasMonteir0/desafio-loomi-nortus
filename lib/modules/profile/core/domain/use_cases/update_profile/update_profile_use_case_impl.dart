import "../../../../../commons/config/dependency_injection.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/profile_entity.dart";
import "../../entities/update_profile_entity.dart";
import "../../repositories/profile_repository.dart";
import "update_profile_use_case.dart";

class UpdateProfileUseCaseImpl implements UpdateProfileUseCase {
  late final ProfileRepository _repository;

  UpdateProfileUseCaseImpl() {
    _repository = getIt<ProfileRepository>();
  }

  @override
  Future<ResultWrapper<ProfileEntity>> call(UpdateProfileEntity profile) {
    return _repository.updateProfile(profile);
  }
}
