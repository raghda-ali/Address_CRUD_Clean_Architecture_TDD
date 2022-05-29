import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/delete_address.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

void main() {
  late DeleteAddress deleteAddressUseCase;
  late MockAddressRepository mockAddressRepository;
  setUp(() {
    mockAddressRepository = MockAddressRepository();
    deleteAddressUseCase = DeleteAddress(mockAddressRepository);
  });
  int id = 1;
  test('should delete address by id', () async {
    //arrange
    when(() => mockAddressRepository.deleteAddress(id))
        .thenAnswer((_) async => const Right(unit));
    //act
    final result = await deleteAddressUseCase.call(id);
    expect(result, const Right(unit));
    print(result);
    print(Right(unit));
    //assert
    verify(() => mockAddressRepository.deleteAddress(id));
  });
}
