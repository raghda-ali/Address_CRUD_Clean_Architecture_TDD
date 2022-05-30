import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressModel>>> getAddresses();

  Future<Either<Failure, Unit>> addAddress(AddressModel addressModel);

  Future<Either<Failure, Unit>> updateAddress(AddressModel addressModel);

  Future<Either<Failure, Unit>> deleteAddress(int id);
}
