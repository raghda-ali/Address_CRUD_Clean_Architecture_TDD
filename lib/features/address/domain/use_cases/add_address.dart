import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddAddress implements UseCase<int, AddAddressUseCaseParams> {
  final AddressRepository addressRepository;

  AddAddress({required this.addressRepository});

  @override
  Future<Either<Failure, int>> call(AddAddressUseCaseParams parameters) {
    return addressRepository.addAddress(parameters.addressModel);
  }
}

class AddAddressUseCaseParams extends Equatable {
  final AddressModel addressModel;

  const AddAddressUseCaseParams({required this.addressModel});

  @override
  List<Object?> get props => [addressModel];
}
