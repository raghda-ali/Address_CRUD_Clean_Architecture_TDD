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
class MockRemoteDataSource extends Mock implements AddressRemoteDataSourceImpl{}
void main() {
  late MockDio mockDio;
  late AddressRemoteDataSourceImpl addressRemoteDataSource;
  setUp(() {
    mockDio = MockDio();
    addressRemoteDataSource = AddressRemoteDataSourceImpl(dio: mockDio);
  });
  void setUpMockDioSuccess200() {
    when(() => mockDio.get(
          "${AppStrings.baseUrl}get_address",
        )).thenAnswer(
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
    when(() => mockDio.get(
          "${AppStrings.baseUrl}get_address",
        )).thenAnswer(
      (_) async => dio.Response(
        data: {"Something wrong"},
        statusCode: 404,
        requestOptions: RequestOptions(
          path: "${AppStrings.baseUrl}get_address",
        ),
      ),
    );
  }

  final List<AddressEntity> addressList = [];
  var jsonMap = jsonDecode(fixture('address.json')) as Map<String, dynamic>;
  for (int i = 0; i < (jsonMap['Addresses'] as List).length; i++) {
    addressList.add(
        AddressModel.fromJson(jsonMap['Addresses'][i] as Map<String, dynamic>));
  }
  group('getAddresses', () {
    test('should return Address List when the response is 200(success)',
        () async {
      //arrange
      setUpMockDioSuccess200();
      final result = await addressRemoteDataSource.getAddresses();
      //assert
      verify(() => mockDio.get(
            "${AppStrings.baseUrl}get_address",
          ));
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
          ));
      expect(result, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('add Address', () {
    final address = AddressModel(
        id: 1,
        addressName: "haram street",
        buildingNumber: "2A",
        floorNumber: 3,
        doorNumber: 10,
        latitude: 31.0409,
        longitude: 31.3785);
    test('should return unit when the response is 200(added successfully)',
        () async {
      //arrange
      jsonMap = jsonDecode(fixture('addAddress.json')) as Map<String, dynamic>;
      when(() => mockDio.post(
            "${AppStrings.baseUrl}add_address",
            data: address.toJson(),
          )).thenAnswer(
        (_) async => dio.Response(
          data: jsonMap['Message'].toString(),
          statusCode: 200,

          requestOptions: RequestOptions(
            path: "${AppStrings.baseUrl}add_address",
          ),
        ),
      );
      final result = await addressRemoteDataSource.addAddress(address);
      print(result);
      //assert
      verify(() =>
          mockDio.post("${AppStrings.baseUrl}add_address", data: address.toJson()));
      expect(result, Right(unit));
    });
    // test('should return ServerException when the response is 404(fail)',
    //     () async {
    //   //arrange
    //   when(() => mockDio.post(
    //         "${AppStrings.baseUrl}add_address",
    //       )).thenAnswer(
    //     (_) async => dio.Response(
    //       statusCode: 404,
    //       requestOptions: RequestOptions(
    //         path: "${AppStrings.baseUrl}add_address",
    //       ),
    //     ),
    //   );
    //   final result = addressRemoteDataSource.addAddress(address);
    //   //assert
    //   verify(() => mockDio.post(
    //         "${AppStrings.baseUrl}add_address",
    //       ));
    //   expect(result, throwsA(isInstanceOf<ServerException>()));
    // });
  });
}
