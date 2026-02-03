import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/profile_entity.dart";

abstract class GetProfileUseCase {
  Future<ResultWrapper<ProfileEntity>> call();
}
