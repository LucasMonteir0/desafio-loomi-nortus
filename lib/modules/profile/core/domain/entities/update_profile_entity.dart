import "address_entity.dart";

class UpdateProfileEntity {
  final String name;
  final String email;
  final String language;
  final String dateFormat;
  final String timezone;
  final AddressEntity address;

  const UpdateProfileEntity({
    required this.name,
    required this.email,
    required this.language,
    required this.dateFormat,
    required this.timezone,
    required this.address,
  });
}
