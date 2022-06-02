import 'package:addresscrud_clean_architecture/core/constants/app_strings.dart';
import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();

  Future<Either<Failure, Unit>> addAddress(AddressModel addressModel);

  Future<Either<Failure, Unit>> updateAddress(AddressModel addressModel);

  Future<Either<Failure, Unit>> deleteAddress(int id);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final Dio dio;

  AddressRemoteDataSourceImpl({required this.dio});

  AddressModel? addressModel;

  @override
  Future<List<AddressModel>> getAddresses() async {
    List<AddressModel> addressList = [];

    final response = await dio.get("${AppStrings.baseUrl}get_address");
    if (response.statusCode == 200) {
      final jsonList = (response.data as Map<String, dynamic>)['Addresses'];
      for (final address in jsonList) {
        addressList.add(AddressModel.fromJson(address as Map<String, dynamic>));
      }
      return addressList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, Unit>> addAddress(AddressModel addressModel) async {
    const url = "${AppStrings.baseUrl}add_address";
    // const token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGEzYWxhcHAuY29tXC90YTNhbFwvQXBpXC9jdXN0b21lclwvbG9naW4iLCJpYXQiOjE2NDk4Mzc2ODIsImV4cCI6MjI0OTgzNzY4MiwibmJmIjoxNjQ5ODM3NjgyLCJqdGkiOiJlZE9WS1RzTHZiZXM3R1hVIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.g6I7XPoPimH_WMqzdtvatQDiVgCNyIpFCkVRORBDBZ4';
    final response = await dio.post(
      url,

      data: addressModel.toJson(),
      // options: Options(
      //   headers: {
      //     "authorization": "Bearer $token",
      //   },
      // ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(const Right(unit));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(int id) async {
    const url = "${AppStrings.baseUrl}delete_address";
    final response = await dio.post(
      url,
      data: id,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(const Right(unit));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(AddressModel addressModel) async {
    const url = "${AppStrings.baseUrl}update_address";
    final response = await dio.post(
      url,
      data: addressModel.toJson(),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(const Right(unit));
    } else {
      throw ServerException();
    }
  }
}
