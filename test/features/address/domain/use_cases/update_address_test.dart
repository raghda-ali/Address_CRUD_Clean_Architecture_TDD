import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/update_address.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

void main() {
  late UpdateAddress updateAddressUseCase;
  late MockAddressRepository mockAddressRepository;
  setUp(() {
    mockAddressRepository = MockAddressRepository();
    updateAddressUseCase =
        UpdateAddress(addressRepository: mockAddressRepository);
  });
  const address = AddressEntity(
      id: 1,
      addressName: "Masr Al Jadidah, Al Matar, El Nozha, Egypt",
      buildingNumber: "55",
      floorNumber: 5,
      doorNumber: 5,
      latitude: 30.112314999999998832436176599003374576568603515625,
      longitude: 31.343850700000000841782821225933730602264404296875);
  test('should update address', () async {
    //arrange
    when(() => mockAddressRepository.updateAddress(address))
        .thenAnswer((_) async => const Right(unit));
    //act
    final result = await updateAddressUseCase
        .call(const UpdateAddressUseCaseParams(addressEntity: address));
    expect(result, const Right(unit));
    print(result);
    print(Right(unit));
    //assert
    verify(() => mockAddressRepository.updateAddress(address));
  });
}
