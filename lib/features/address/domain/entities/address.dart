import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  int? id;
  final String addressName;
  final String buildingNumber;
  final int floorNumber;
  final int doorNumber;
  final double latitude;
  final double longitude;

  AddressEntity({
    this.id,
    required this.addressName,
    required this.buildingNumber,
    required this.floorNumber,
    required this.doorNumber,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        id,
        addressName,
        buildingNumber,
        floorNumber,
        doorNumber,
        latitude,
        longitude
      ];
}
