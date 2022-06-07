import 'package:addresscrud_clean_architecture/core/error/exceptions.dart';
import 'package:addresscrud_clean_architecture/core/error/failures.dart';
import 'package:addresscrud_clean_architecture/core/platform/network_info.dart';
import 'package:addresscrud_clean_architecture/features/address/data/data_sources/address_remote_data_source.dart';
import 'package:addresscrud_clean_architecture/features/address/data/models/address_model.dart';
import 'package:addresscrud_clean_architecture/features/address/data/repositories/address_impl.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/entities/address.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements AddressRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AddressRepositoryImpl addressRepositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    addressRepositoryImpl = AddressRepositoryImpl(
        addressRemoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });
  int id = 1;
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
  final addressEntity = AddressEntity(
      id: 1,
      addressName: "Masr Al Jadidah, Al Matar, El Nozha, Egypt",
      buildingNumber: "55",
      floorNumber: 5,
      doorNumber: 5,
      latitude: 30.112314999999998832436176599003374576568603515625,
      longitude: 31.343850700000000841782821225933730602264404296875);
  final addressModel = AddressModel(
      id: 1,
      addressName: "Masr Al Jadidah, Al Matar, El Nozha, Egypt",
      buildingNumber: "55",
      floorNumber: 5,
      doorNumber: 5,
      latitude: 30.112314999999998832436176599003374576568603515625,
      longitude: 31.343850700000000841782821225933730602264404296875);
  // test('should check the device is online', () {
  //   //arrange
  //   when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  //   when(() => mockRemoteDataSource.getAddresses())
  //       .thenAnswer((_) async => addressList);
  //   //act
  //   addressRepositoryImpl.getAddresses();
  //   verify(() => mockNetworkInfo.isConnected);
  // });

  group('check device is online to get addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return remote data when the call to remote data is success',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAddresses())
          .thenAnswer((_) async => addressList);
      //act
      final result = await addressRepositoryImpl.getAddresses();
      //assert
      verify(() => mockRemoteDataSource.getAddresses());
      expect(result, equals(Right(addressList)));
    });
    test('should return ServerException when the call to remote data is fail',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAddresses())
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.getAddresses();
      //assert
      verify(() => mockRemoteDataSource.getAddresses());
      expect(result, Left(ServerFailure()));
    });
    test(
        'should return EmptyCacheException when the call to remote data is fail',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getAddresses())
          .thenThrow(EmptyCacheException());
      //act
      final result = await addressRepositoryImpl.getAddresses();
      //assert
      verify(() => mockRemoteDataSource.getAddresses());
      expect(result, Left(EmptyFailure()));
    });
  });
  group('check device is offline when get addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('should return ServerException when the call to remote data is fail',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockRemoteDataSource.getAddresses())
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.getAddresses();
      //assert
      verify(() => mockRemoteDataSource.getAddresses());
      expect(result, Left(ServerFailure()));
    });
  });
  group('check device is online to add addresses', () {
    int addressId = 1;
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return address id when added address success', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.addAddress(addressModel))
          .thenAnswer((_) async => Right(addressId));
      //act
      final result = await addressRepositoryImpl.addAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.addAddress(addressModel));
      expect(result, Right(addressId));
    });
    test(
        'should return NoInternetException when no internet to add new address',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.addAddress(addressModel))
          .thenThrow(NoInternetException());
      //act
      final result = await addressRepositoryImpl.addAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.addAddress(addressModel));
      expect(result, Left(NoInternetFailure()));
    });
    test('should return ServerException when fail to add new address',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.addAddress(addressModel))
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.addAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.addAddress(addressModel));
      expect(result, Left(ServerFailure()));
    });
  });
  group('check device is offline when add addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('should return ServerException when no internet when add new address',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockRemoteDataSource.addAddress(addressModel))
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.addAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.addAddress(addressModel));
      expect(result, Left(ServerFailure()));
    });
  });
  group('check device is online to update addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return unit when updated address success', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.updateAddress(addressModel))
          .thenAnswer((_) async => const Right(unit));
      //act
      final result = await addressRepositoryImpl.updateAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.updateAddress(addressModel));
      expect(result, const Right(unit));
    });
    test('should return ServerException when fail to update address', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.updateAddress(addressModel))
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.updateAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.updateAddress(addressModel));
      expect(result, Left(ServerFailure()));
    });
  });
  group('check device is offline when update addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('should return ServerException when fail to update address', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.updateAddress(addressModel))
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.updateAddress(addressModel);
      //assert
      verify(() => mockRemoteDataSource.updateAddress(addressModel));
      expect(result, Left(ServerFailure()));
    });
  });
  group('check device is online to delete addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return unit when deleted address is success', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.deleteAddress(id))
          .thenAnswer((_) async => const Right(unit));
      //act
      final result = await addressRepositoryImpl.deleteAddress(id);
      //assert
      verify(() => mockRemoteDataSource.deleteAddress(id));
      expect(result, equals(const Right(unit)));
    });
    test('should return ServerException when the call to remote data is fail',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.deleteAddress(id))
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.deleteAddress(id);
      //assert
      verify(() => mockRemoteDataSource.deleteAddress(id));
      expect(result, Left(ServerFailure()));
    });
  });
  group('check device is offline when delete addresses', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('should return ServerException when the call to remote data is fail',
        () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockRemoteDataSource.deleteAddress(id))
          .thenThrow(ServerException());
      //act
      final result = await addressRepositoryImpl.deleteAddress(id);
      //assert
      verify(() => mockRemoteDataSource.deleteAddress(id));
      expect(result, Left(ServerFailure()));
    });
  });
}
