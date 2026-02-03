import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/profile_entity.dart";
import "../../domain/entities/update_profile_entity.dart";
import "../../domain/repositories/profile_repository.dart";
import "../data_sources/profile_data_source.dart";

class ProfileRepositoryImpl implements ProfileRepository {
  late final ProfileDataSource _dataSource;

  ProfileRepositoryImpl() {
    _dataSource = getIt<ProfileDataSource>();
  }

  @override
  Future<ResultWrapper<ProfileEntity>> getProfile() {
    return _dataSource.getProfile();
  }

  @override
  Future<ResultWrapper<ProfileEntity>> updateProfile(
    UpdateProfileEntity profile,
  ) {
    return _dataSource.updateProfile(profile);
  }
}
