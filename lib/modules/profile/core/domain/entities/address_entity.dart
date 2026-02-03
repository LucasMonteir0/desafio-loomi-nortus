import "package:equatable/equatable.dart";

class AddressEntity extends Equatable {
  final String zipCode;
  final String country;
  final String street;
  final String number;
  final String complement;
  final String neighborhood;
  final String city;
  final String state;

  const AddressEntity({
    required this.zipCode,
    required this.country,
    required this.street,
    required this.number,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  @override
  List<Object> get props => [
    zipCode,
    country,
    street,
    number,
    complement,
    neighborhood,
    city,
    state,
  ];
}
