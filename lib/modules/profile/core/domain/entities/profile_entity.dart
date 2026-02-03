import "address_entity.dart";

class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final String language;
  final String dateFormat;
  final String timezone;
  final AddressEntity address;
  final DateTime updatedAt;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.language,
    required this.dateFormat,
    required this.timezone,
    required this.address,
    required this.updatedAt,
  });
}
