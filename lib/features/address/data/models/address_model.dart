import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required int id,
    required String addressName,
    required String buildingNumber,
    required int floorNumber,
    required int doorNumber,
    required double latitude,
    required double longitude,
  }) : super(
          id: id,
          addressName: addressName,
          buildingNumber: buildingNumber,
          floorNumber: floorNumber,
          doorNumber: doorNumber,
          latitude: latitude,
          longitude: longitude,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      addressName: json['address_name'],
      buildingNumber: json['building_no'],
      floorNumber: json['floor_no'],
      doorNumber: json['door_no'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": 1,
      "addressName": "address_name",
      "buildingNumber": "building_number",
      "floorNumber": 2,
      "doorNumber": 3,
      "latitude": 2222.5,
      "longitude": 33333.5,
    };
  }
}
