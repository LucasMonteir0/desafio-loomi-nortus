import "../../domain/entities/address_entity.dart";

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.zipCode,
    required super.country,
    required super.street,
    required super.number,
    required super.complement,
    required super.neighborhood,
    required super.city,
    required super.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      zipCode: json["zipCode"] as String,
      country: json["country"] as String,
      street: json["street"] as String,
      number: json["number"] as String,
      complement: json["complement"] as String,
      neighborhood: json["neighborhood"] as String,
      city: json["city"] as String,
      state: json["state"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "zipCode": zipCode,
      "country": country,
      "street": street,
      "number": number,
      "complement": complement,
      "neighborhood": neighborhood,
      "city": city,
      "state": state,
    };
  }

  factory AddressModel.fromEntity(AddressEntity address) {
    return AddressModel(
      zipCode: address.zipCode,
      country: address.country,
      street: address.street,
      number: address.number,
      complement: address.complement,
      neighborhood: address.neighborhood,
      city: address.city,
      state: address.state,
    );
  }
}
