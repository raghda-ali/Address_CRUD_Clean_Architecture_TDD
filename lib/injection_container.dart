import 'package:addresscrud_clean_architecture/features/address/data/data_sources/address_remote_data_source.dart';
import 'package:addresscrud_clean_architecture/features/address/data/repositories/address_impl.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/delete_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/get_addresses.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/update_address.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/platform/network_info.dart';
import 'features/address/domain/repositories/address_repository.dart';
import 'features/address/domain/use_cases/add_address.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  //UserCases
  sl.registerLazySingleton(() => GetAddress(sl()));
  sl.registerLazySingleton(() => AddAddress(addressRepository: sl()));
  sl.registerLazySingleton(() => UpdateAddress(addressRepository: sl()));
  sl.registerLazySingleton(() => DeleteAddress(sl()));
  //Repositories
  sl.registerLazySingleton<AddressRepository>(() =>
      AddressRepositoryImpl(addressRemoteDataSource: sl(), networkInfo: sl()));
  //DataSources
  sl.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSourceImpl(dio: sl()));
  //Core
  //External
  sl.registerLazySingleton<Dio>(() => Dio());
}
