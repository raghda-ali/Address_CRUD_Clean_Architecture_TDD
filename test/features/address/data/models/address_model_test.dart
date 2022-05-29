import 'dart:convert';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.reader.dart';

void main() {
  List<AddressModel> addressList = [
    const AddressModel(
        id: 4,
        addressName: "Masr Al Jadidah, Al Matar, El Nozha, Egypt",
        buildingNumber: "55",
        floorNumber: 5,
        doorNumber: 5,
        latitude: 30.112314999999998832436176599003374576568603515625,
        longitude: 31.343850700000000841782821225933730602264404296875),
    const AddressModel(
        id: 7,
        addressName: "haram street",
        buildingNumber: "2A",
        floorNumber: 3,
        doorNumber: 10,
        latitude: 31.04090000000000060254023992456495761871337890625,
        longitude: 31.378499999999998948396751075051724910736083984375),
  ];
  const addressModel = AddressModel(
      id: 7,
      addressName: "haram street",
      buildingNumber: "2A",
      floorNumber: 3,
      doorNumber: 10,
      latitude: 31.04090000000000060254023992456495761871337890625,
      longitude: 31.378499999999998948396751075051724910736083984375);

  test('should be a subclass of entity', () {
    expect(addressModel, isA<AddressEntity>());
  });

  test('should return a valid json model', () {
    final jsonMap = jsonDecode(fixture('address.json')) as Map<String, dynamic>;
    for (int i = 0; i < (jsonMap['Addresses'] as List).length; i++) {
      final result = AddressModel.fromJson(
          jsonMap['Addresses'][i] as Map<String, dynamic>);
      expect(result, addressList[i]);
    }
  });

  test('should return a json map containing data', () {
    const address = {
      "id": 1,
      "addressName": "address_name",
      "buildingNumber": "building_number",
      "floorNumber": 2,
      "doorNumber": 3,
      "latitude": 2222.5,
      "longitude": 33333.5,
    };
    //arrange
    final result = addressModel.toJson();
    expect(result, address);
    print(result);
    print(address);
  });
}
