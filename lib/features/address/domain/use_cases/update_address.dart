import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateAddress extends UseCase<Unit, UpdateAddressUseCaseParams> {
  final AddressRepository addressRepository;

  UpdateAddress({required this.addressRepository});

  @override
  Future<Either<Failure, Unit>> call(
      UpdateAddressUseCaseParams parameters) async {
    return await addressRepository.updateAddress(parameters.addressModel);
  }
}

class UpdateAddressUseCaseParams extends Equatable {
  final AddressModel addressModel;

  const UpdateAddressUseCaseParams({required this.addressModel});

  @override
  List<Object?> get props => [addressModel];
}
