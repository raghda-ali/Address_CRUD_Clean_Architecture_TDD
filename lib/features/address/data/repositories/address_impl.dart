import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/platform/network_info.dart';
import 'package:addresscrud_clean_architecture/features/address/data/data_sources/address_remote_data_source.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

class AddressRepositoryImpl implements AddressRepository {
  final NetworkInfo networkInfo;
  final AddressRemoteDataSource addressRemoteDataSource;

  const AddressRepositoryImpl(
      {required this.addressRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async {
    await networkInfo.isConnected;
    try {
      return Right(await addressRemoteDataSource.getAddresses());
    } on ServerException {
      return Left(ServerFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addAddress(AddressEntity addressEntity) async {
    await networkInfo.isConnected;
    try {
      await addressRemoteDataSource.addAddress(addressEntity);
      return const Right(unit);
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAddress(
      AddressEntity addressEntity) async {
    try {
      await addressRemoteDataSource.updateAddress(addressEntity);
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
