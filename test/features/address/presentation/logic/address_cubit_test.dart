import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/usecases/usecase.dart';
import 'package:addresscrud_clean_architecture/core/util/input_converter.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/add_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/delete_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/get_addresses.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/update_address.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/logic/address_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetAddresses extends Mock implements GetAddress {}

class MockAddAddresses extends Mock implements AddAddress {}

class MockUpdateAddresses extends Mock implements UpdateAddress {}

class MockDeleteAddresses extends Mock implements DeleteAddress {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late AddressCubit addressCubit;
  late MockInputConverter inputConverter;
  late MockGetAddresses mockGetAddresses;
  late MockAddAddresses mockAddAddresses;
  late MockUpdateAddresses mockUpdateAddresses;
  late MockDeleteAddresses mockDeleteAddresses;
  setUp(() {
    mockGetAddresses = MockGetAddresses();
    mockAddAddresses = MockAddAddresses();
    mockUpdateAddresses = MockUpdateAddresses();
    mockDeleteAddresses = MockDeleteAddresses();
    inputConverter = MockInputConverter();
    addressCubit = AddressCubit(
      getAddressUseCase: mockGetAddresses,
      addAddressUseCase: mockAddAddresses,
      updateAddressUseCase: mockUpdateAddresses,
      deleteAddressUseCase: mockDeleteAddresses,
      inputConverter: inputConverter,
    );
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
  final addressModel = AddressModel(
      id: 1,
      addressName: "Masr Al Jadidah, Al Matar, El Nozha, Egypt",
      buildingNumber: "55",
      floorNumber: 5,
      doorNumber: 5,
      latitude: 30.112314999999998832436176599003374576568603515625,
      longitude: 31.343850700000000841782821225933730602264404296875);
  group('get addresses', () {
    test('should emit [Loading,success] when data is gotten successfully',
        () async {
      when(() => mockGetAddresses.call(NoParams()))
          .thenAnswer((_) async => Right(addressList));
      final expected = [
        AddressLoading(),
        GetAddressSuccess(addressModel: addressList),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));

      await addressCubit.getAddresses();
    });
    test('should emit [Loading,Error] when data is gotten Fail', () async {
      when(() => mockGetAddresses.call(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        AddressLoading(),
        const AddressError(errorMessage: "Server Failure"),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));

      await addressCubit.getAddresses();
    });
    test('should emit [Loading,Error] when data is gotten empty', () async {
      when(() => mockGetAddresses.call(NoParams()))
          .thenAnswer((_) async => Left(EmptyFailure()));
      final expected = [
        AddressLoading(),
        const AddressError(errorMessage: "Empty Failure"),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));

      await addressCubit.getAddresses();
    });
  });
  group('Add address', () {
    int addressId=1;
    test('should emit [Loading,success] when address added successfully',
        () async {
      when(() => mockAddAddresses
              .call(AddAddressUseCaseParams(addressModel: addressModel)))
          .thenAnswer((_) async => Right(addressId));
      final expected = [
        AddressLoading(),
        AddAddressSuccess(),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));
      await addressCubit.addAddress();
    });
    test('should emit [Loading,Error] when data is gotten Fail', () async {
      when(() => mockAddAddresses
              .call(AddAddressUseCaseParams(addressModel: addressModel)))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        AddressLoading(),
        const AddressError(errorMessage: "Server Failure"),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));

      await addressCubit.addAddress();
    });
  });
  group('Update address', () {
    test('should emit [Loading,success] when address updated successfully',
        () async {
      when(() => mockUpdateAddresses
              .call(UpdateAddressUseCaseParams(addressModel: addressModel)))
          .thenAnswer((_) async => const Right(unit));
      final expected = [
        AddressLoading(),
        UpdateAddressSuccess(),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));
      await addressCubit.updateAddress();
    });
    test('should emit [Loading,Error] when data is gotten Fail', () async {
      when(() => mockUpdateAddresses
              .call(UpdateAddressUseCaseParams(addressModel: addressModel)))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        AddressLoading(),
        const AddressError(errorMessage: "Server Failure"),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));

      await addressCubit.updateAddress();
    });
  });
  group('Delete address', () {
    const int id = 1;
    test('should emit [Loading,success] when address deleted successfully',
        () async {
      when(() => mockDeleteAddresses.call(id))
          .thenAnswer((_) async => const Right(unit));
      final expected = [
        AddressLoading(),
        const DeleteAddressSuccess(),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));
      await addressCubit.deleteAddress(id);
    });
    test('should emit [Loading,Error] when error during deleting address',
        () async {
      when(() => mockDeleteAddresses.call(id))
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        AddressLoading(),
        const AddressError(errorMessage: "Server Failure"),
      ];
      expect(addressCubit.stream, emitsInOrder(expected));

      await addressCubit.deleteAddress(id);
    });
  });
}
