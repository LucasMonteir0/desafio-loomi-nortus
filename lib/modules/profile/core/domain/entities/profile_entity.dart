import "package:equatable/equatable.dart";

import "address_entity.dart";

class ProfileEntity extends Equatable {
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

  @override
  List<Object> get props => [
    id,
    name,
    email,
    language,
    dateFormat,
    timezone,
    address,
    updatedAt,
  ];
}
