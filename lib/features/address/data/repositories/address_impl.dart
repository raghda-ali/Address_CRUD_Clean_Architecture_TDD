import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/platform/network_info.dart';
import 'package:addresscrud_clean_architecture/features/address/data/data_sources/address_remote_data_source.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

class AddressRepositoryImpl implements AddressRepository {
  final NetworkInfo networkInfo;
  final AddressRemoteDataSource addressRemoteDataSource;

  const AddressRepositoryImpl(
      {required this.addressRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    await networkInfo.isConnected;
    try {
      return Right(await addressRemoteDataSource.getAddresses());
    } on ServerException {
      return Left(ServerFailure());
    } on EmptyCacheException {
      return Left(EmptyFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addAddress(AddressModel addressModel) async {
    await networkInfo.isConnected;
    try {
      await addressRemoteDataSource.addAddress(addressModel);
      return  const Right(1);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(
      AddressModel addressModel) async {
    try {
      await addressRemoteDataSource.updateAddress(addressModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(int id) async{
    try {
      await addressRemoteDataSource.deleteAddress(id);
      return const Right(unit);
    }on ServerException{
      return Left(ServerFailure());
    }
  }
}
