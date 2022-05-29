import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:dartz/dartz.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressEntity>> getAddresses();

  Future<Either<Failure, Unit>> addAddress(AddressEntity addressEntity);

  Future<Either<Failure, Unit>> updateAddress(AddressEntity addressEntity);

  Future<Either<Failure, Unit>> deleteAddress(int id);
}
