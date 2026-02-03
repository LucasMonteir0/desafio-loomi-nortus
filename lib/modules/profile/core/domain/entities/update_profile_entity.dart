import "package:equatable/equatable.dart";

import "address_entity.dart";

class UpdateProfileEntity extends Equatable {
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

  @override
  List<Object> get props => [
    name,
    email,
    language,
    dateFormat,
    timezone,
    address,
  ];
}
