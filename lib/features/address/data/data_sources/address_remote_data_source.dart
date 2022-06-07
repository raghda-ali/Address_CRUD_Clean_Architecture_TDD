import 'package:addresscrud_clean_architecture/core/constants/app_strings.dart';
import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();

  Future<Either<Failure, int>> addAddress(AddressModel addressModel);

  Future<Either<Failure, Unit>> updateAddress(AddressModel addressModel);

  Future<Either<Failure, Unit>> deleteAddress(int id);
}

const token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGEzYWxhcHAuY29tXC90YTNhbFwvQXBpXC9jdXN0b21lclwvbG9naW4iLCJpYXQiOjE2NTQwODYzNjksImV4cCI6MjI1NDA4NjM2OSwibmJmIjoxNjU0MDg2MzY5LCJqdGkiOiJIZ3M3ZjdKeEVxS2ZzWDM3Iiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.4FrmCy7qR320lJEhk0iLTt6d80axLKldYJzoGlUpfRY";

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final Dio dio;

  AddressRemoteDataSourceImpl({required this.dio});

  final addressOptions = Options(
    headers: {
      "authorization": "Bearer $token",
    },
  );

  @override
  Future<List<AddressModel>> getAddresses() async {
    addressOptions.copyWith();
    List<AddressModel> addressList = [];
    final response = await dio.get(
      "${AppStrings.baseUrl}get_address",
      options: addressOptions,
    );
    print(response);
    if (response.statusCode == 200) {
      print(response.data);
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
  Future<Either<Failure, int>> addAddress(AddressModel addressModel) async {
    const url = "${AppStrings.baseUrl}add_address";
    final response = await dio.post(
      url,
      data: addressModel.toJson(),
      options: addressOptions,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(Right(response.data["address_id"]));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(int addressId) async {
    const url = "${AppStrings.baseUrl}delete_address";
    final response = await dio.post(
      url,
      data: addressId,
      // FormData.fromMap({
      //   "address_id": addressId,
      // }),
      options: addressOptions,
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
      options: addressOptions,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(const Right(unit));
    } else {
      throw ServerException();
    }
  }
}
