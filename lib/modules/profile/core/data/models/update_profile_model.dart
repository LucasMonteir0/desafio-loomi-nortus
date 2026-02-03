import "../../domain/entities/update_profile_entity.dart";
import "address_model.dart";

class UpdateProfileModel extends UpdateProfileEntity {
  const UpdateProfileModel({
    required super.name,
    required super.email,
    required super.language,
    required super.dateFormat,
    required super.timezone,
    required super.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "language": language,
      "dateFormat": dateFormat,
      "timezone": timezone,
      "address": AddressModel.fromEntity(address).toJson(),
    };
  }

  factory UpdateProfileModel.fromEntity(UpdateProfileEntity entity) {
    return UpdateProfileModel(
      name: entity.name,
      email: entity.email,
      language: entity.language,
      dateFormat: entity.dateFormat,
      timezone: entity.timezone,
      address: entity.address,
    );
  }
}
