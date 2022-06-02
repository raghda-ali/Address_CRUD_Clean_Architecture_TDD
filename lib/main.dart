import 'package:addresscrud_clean_architecture/core/platform/network_info.dart';
import 'package:addresscrud_clean_architecture/core/util/input_converter.dart';
import 'package:addresscrud_clean_architecture/features/address/data/data_sources/address_remote_data_source.dart';
import 'package:addresscrud_clean_architecture/features/address/data/repositories/address_impl.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/repositories/address_repository.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/add_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/delete_address.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/get_addresses.dart';
import 'package:addresscrud_clean_architecture/features/address/domain/use_cases/update_address.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/logic/address_cubit.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'package:addresscrud_clean_architecture/features/address/presentation/pages/address.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        // create: (context) => AddressCubit(
        //     getAddressUseCase: GetAddress(AddressRepositoryImpl(
        //       addressRemoteDataSource: AddressRemoteDataSourceImpl(dio: Dio()),
        //       networkInfo:
        //           NetworkInfoImpl(dataConnectionChecker: DataConnectionChecker()),
        //     )),
        //     addAddressUseCase: AddAddress(
        //         addressRepository: AddressRepositoryImpl(
        //       addressRemoteDataSource: AddressRemoteDataSourceImpl(dio: Dio()),
        //       networkInfo:
        //           NetworkInfoImpl(dataConnectionChecker: DataConnectionChecker()),
        //     )),
        //     updateAddressUseCase: UpdateAddress(
        //         addressRepository: AddressRepositoryImpl(
        //       addressRemoteDataSource: AddressRemoteDataSourceImpl(dio: Dio()),
        //       networkInfo:
        //           NetworkInfoImpl(dataConnectionChecker: DataConnectionChecker()),
        //     )),
        //     deleteAddressUseCase: DeleteAddress(AddressRepositoryImpl(
        //         addressRemoteDataSource: AddressRemoteDataSourceImpl(dio: Dio()),
        //         networkInfo: NetworkInfoImpl(
        //             dataConnectionChecker: DataConnectionChecker()))),
        //     inputConverter: InputConverter()),
        // child:
        MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DisplayAddresses(),
    );
  }
}
