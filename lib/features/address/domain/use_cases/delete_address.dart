import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAddress extends UseCase<Unit, int> {
  final AddressRepository addressRepository;

  DeleteAddress(this.addressRepository);

  @override
  Future<Either<Failure, Unit>> call(int parameters) async {
    return await addressRepository.deleteAddress(parameters);
  }
}
