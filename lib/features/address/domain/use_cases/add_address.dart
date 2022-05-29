import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddAddress implements UseCase<Unit, AddAddressUseCaseParams> {
  final AddressRepository addressRepository;

  AddAddress({required this.addressRepository});

  @override
  Future<Either<Failure, Unit>> call(AddAddressUseCaseParams parameters) {
    return addressRepository.addAddress(parameters.addressEntity);
  }
}

class AddAddressUseCaseParams extends Equatable {
  final AddressEntity addressEntity;

  const AddAddressUseCaseParams({required this.addressEntity});

  @override
  List<Object?> get props => [addressEntity];
}
