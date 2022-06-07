import 'dart:convert';

import 'package:addresscrud_clean_architecture/core/constants/app_strings.dart';
import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/features/address/data/data_sources/address_remote_data_source.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../fixtures/fixture.reader.dart';

class MockDio extends Mock implements dio.Dio {}

class MockRemoteDataSource extends Mock implements AddressRemoteDataSourceImpl {
}

void main() {
  late MockDio mockDio;
  late AddressRemoteDataSourceImpl addressRemoteDataSource;
  setUp(() {
    mockDio = MockDio();
    addressRemoteDataSource = AddressRemoteDataSourceImpl(dio: mockDio);
  });
  final List<AddressEntity> addressList = [];
  var jsonMap = jsonDecode(fixture('address.json')) as Map<String, dynamic>;
  for (int i = 0; i < (jsonMap['Addresses'] as List).length; i++) {
    addressList.add(
        AddressModel.fromJson(jsonMap['Addresses'][i] as Map<String, dynamic>));
  }
  final address = AddressModel(
      id: 1,
      addressName: "haram street",
      buildingNumber: "2A",
      floorNumber: 3,
      doorNumber: 10,
      latitude: 31.0409,
      longitude: 31.3785);

  void setUpMockDioSuccess200() {
    when(() => mockDio.get("${AppStrings.baseUrl}get_address",
        options: addressRemoteDataSource.addressOptions)).thenAnswer(
      (_) async => dio.Response(
        data: jsonDecode(fixture('address.json')) as Map<String, dynamic>,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: "${AppStrings.baseUrl}get_address",
        ),
      ),
    ); //act
  }

  void setUpMockDioError404() {
    when(() => mockDio.get("${AppStrings.baseUrl}get_address",
        options: addressRemoteDataSource.addressOptions)).thenAnswer(
      (_) async => dio.Response(
        data: {"Something wrong"},
        statusCode: 404,
        requestOptions: RequestOptions(
          path: "${AppStrings.baseUrl}get_address",
        ),
      ),
    );
  }

  group('getAddresses', () {
    test('should return Address List when the response is 200(success)',
        () async {
      //arrange
      setUpMockDioSuccess200();
      final result = await addressRemoteDataSource.getAddresses();
      //assert
      verify(() => mockDio.get("${AppStrings.baseUrl}get_address",
          options: addressRemoteDataSource.addressOptions));
      expect(result, addressList);
      print(result);
      print(addressList);
    });
    test('should return ServerException when the response is 404(fail)',
        () async {
      //arrange
      setUpMockDioError404();
      final result = addressRemoteDataSource.getAddresses();
      //assert
      verify(() => mockDio.get(
            "${AppStrings.baseUrl}get_address",
            options: addressRemoteDataSource.addressOptions,
          ));
      expect(result, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('add Address', () {
    int addressId = 1;
    test(
        'should return address id when the response is 200(added successfully)',
        () async {
      //arrange
      jsonMap = jsonDecode(fixture('addAddress.json')) as Map<String, dynamic>;
      when(() => mockDio.post(
            "${AppStrings.baseUrl}add_address",
            data: address.toJson(),
            options: addressRemoteDataSource.addressOptions,
          )).thenAnswer(
        (_) async => dio.Response(
          data: jsonMap,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}add_address",
          ),
        ),
      );
      final result = await addressRemoteDataSource.addAddress(address);
      print(result);
      //assert
      verify(() => mockDio.post("${AppStrings.baseUrl}add_address",
          data: address.toJson(),
          options: addressRemoteDataSource.addressOptions));
      expect(result, Right(addressId));
    });
    test('should return ServerException when the response is 404(fail)',
        () async {
      //arrange
      when(() => mockDio.post("${AppStrings.baseUrl}add_address",
          data: address.toJson(),
          options: addressRemoteDataSource.addressOptions)).thenAnswer(
        (_) async => dio.Response(
          statusCode: 404,
          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}add_address",
          ),
        ),
      );
      final result = addressRemoteDataSource.addAddress(address);
      //assert
      verify(() => mockDio.post("${AppStrings.baseUrl}add_address",
          data: address.toJson(),
          options: addressRemoteDataSource.addressOptions));
      expect(result, throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('update Address', () {
    test('should return unit when the response is 200(updated successfully)',
        () async {
      //arrange
      when(() => mockDio.post(
            "${AppStrings.baseUrl}update_address",
            data: address.toJson(),
            options: addressRemoteDataSource.addressOptions,
          )).thenAnswer(
        (_) async => dio.Response(
          statusCode: 200,
          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}update_address",
          ),
        ),
      );
      final result = await addressRemoteDataSource.updateAddress(address);
      print(result);
      //assert
      verify(() => mockDio.post(
            "${AppStrings.baseUrl}update_address",
            data: address.toJson(),
            options: addressRemoteDataSource.addressOptions,
          ));
      expect(result, const Right(unit));
    });
    test('should return ServerException when the response is 404(fail)',
        () async {
      //arrange
      when(() => mockDio.post(
            "${AppStrings.baseUrl}update_address",
            data: address.toJson(),
            options: addressRemoteDataSource.addressOptions,
          )).thenAnswer(
        (_) async => dio.Response(
          statusCode: 404,
          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}update_address",
          ),
        ),
      );
      final result = addressRemoteDataSource.updateAddress(address);
      //assert
      verify(() => mockDio.post(
            "${AppStrings.baseUrl}update_address",
            data: address.toJson(),
            options: addressRemoteDataSource.addressOptions,
          ));
      expect(result, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('delete Address', () {
    int addressId = 1;
    test('should return unit when the response is 200(deleted successfully)',
        () async {
      //arrange
      when(() => mockDio.post(
            "${AppStrings.baseUrl}delete_address",
            data: addressId,
            options: addressRemoteDataSource.addressOptions,
          )).thenAnswer(
        (_) async => dio.Response(
          statusCode: 200,
          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}delete_address",
          ),
        ),
      );
      final result = await addressRemoteDataSource.deleteAddress(addressId);
      print(result);
      //assert
      verify(() => mockDio.post(
            "${AppStrings.baseUrl}delete_address",
            data: addressId,
            options: addressRemoteDataSource.addressOptions,
          ));
      expect(result, const Right(unit));
    });
    test('should return ServerException when the response is 404(fail)',
        () async {
      //arrange
      when(() => mockDio.post(
            "${AppStrings.baseUrl}delete_address",
            data: addressId,
            options: addressRemoteDataSource.addressOptions,
          )).thenAnswer(
        (_) async => dio.Response(
          statusCode: 404,
          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}delete_address",
          ),
        ),
      );
      final result = addressRemoteDataSource.deleteAddress(addressId);
      //assert
      verify(() => mockDio.post(
            "${AppStrings.baseUrl}delete_address",
            data: addressId,
            options: addressRemoteDataSource.addressOptions,
          ));
      expect(result, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
