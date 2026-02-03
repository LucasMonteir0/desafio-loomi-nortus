import "../../../../../commons/config/dependency_injection.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/profile_entity.dart";
import "../../repositories/profile_repository.dart";
import "get_profile_use_case.dart";

class GetProfileUseCaseImpl implements GetProfileUseCase {
  late final ProfileRepository _repository;

  GetProfileUseCaseImpl() {
    _repository = getIt<ProfileRepository>();
  }

  @override
  Future<ResultWrapper<ProfileEntity>> call() {
    return _repository.getProfile();
  }
}
