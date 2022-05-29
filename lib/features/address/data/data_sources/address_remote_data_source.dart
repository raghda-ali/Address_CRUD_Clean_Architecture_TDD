import 'package:addresscrud_clean_architecture/core/constants/app_strings.dart';
import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressEntity>> getAddresses();

  Future<Either<Failure, Unit>> addAddress(AddressEntity addressEntity);

  Future<Either<Failure, Unit>> updateAddress(AddressEntity addressEntity);

  Future<Either<Failure, Unit>> deleteAddress(int id);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final Dio dio;

  AddressRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<AddressEntity>> getAddresses() async {
    List<AddressEntity> addressList = [];

    final response = await dio.get("${AppStrings.baseUrl}get_address");
    if (response.statusCode == 200) {
      final jsonList = (response.data as Map<String, dynamic>)['Addresses'];
      for (final category in jsonList) {
        addressList
            .add(AddressModel.fromJson(category as Map<String, dynamic>));
      }
      return addressList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, Unit>> addAddress(AddressEntity addressEntity) async {
    final response = await dio.post("${AppStrings.baseUrl}add_address");
        // data: FormData.fromMap(
        //   addressModel.toJson(),
        // ),
        // options: Options(
        //   headers: {
        //     "authorization": "Bearer $token",
        //   },
        // ));
    if (response.statusCode == 200) {
      return const Right(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(int id) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(AddressEntity addressEntity) {
    // TODO: implement updateAddress
    throw UnimplementedError();
  }
}
