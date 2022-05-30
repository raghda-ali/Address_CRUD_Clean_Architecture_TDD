import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

class GetAddress extends UseCase<List<AddressModel>, NoParams> {
  final AddressRepository addressRepository;

  GetAddress(this.addressRepository);

  @override
  Future<Either<Failure, List<AddressModel>>> call(NoParams parameters) async {
    return await addressRepository.getAddresses();
  }
}
