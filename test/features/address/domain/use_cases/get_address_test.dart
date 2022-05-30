import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/get_addresses.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

void main() {
  late GetAddress getAddressUseCase;
  late MockAddressRepository mockAddressRepository;
  setUp(() {
    mockAddressRepository = MockAddressRepository();
    getAddressUseCase = GetAddress(mockAddressRepository);
  });
  List<AddressModel> addressList = [
     AddressModel(
        id: 1,
        addressName: "Masr Al Jadidah, Al Matar, El Nozha, Egypt",
        buildingNumber: "55",
        floorNumber: 5,
        doorNumber: 5,
        latitude: 30.112314999999998832436176599003374576568603515625,
        longitude: 31.343850700000000841782821225933730602264404296875)
  ];
  test('should get list of addresses from the repository', () async {
    //arrange
    when(() => mockAddressRepository.getAddresses())
        .thenAnswer((_) async => Right(addressList));
    final result = await getAddressUseCase.call(NoParams());
    expect(result, Right(addressList));
    verify(() => mockAddressRepository.getAddresses());
    verifyNoMoreInteractions(mockAddressRepository);
  });
}
