import "../../domain/entities/profile_entity.dart";
import "address_model.dart";

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.language,
    required super.dateFormat,
    required super.timezone,
    required super.address,
    required super.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      language: json["language"] as String,
      dateFormat: json["dateFormat"] as String,
      timezone: json["timezone"] as String,
      address: AddressModel.fromJson(json["address"] as Map<String, dynamic>),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "language": language,
      "dateFormat": dateFormat,
      "timezone": timezone,
      "address": (address as AddressModel).toJson(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity profile) {
    return ProfileModel(
      id: profile.id,
      name: profile.name,
      email: profile.email,
      language: profile.language,
      dateFormat: profile.dateFormat,
      timezone: profile.timezone,
      address: AddressModel.fromEntity(profile.address),
      updatedAt: profile.updatedAt,
    );
  }
}
