import 'package:addresscrud_clean_architecture/features/address/presentation/logic/address_cubit.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/addresses_list_view.dart';
import 'package:addresscrud_clean_architecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayAddresses extends StatelessWidget {
  const DisplayAddresses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddressCubit>()..getAddresses(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: const Text(
            "Addresses",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          backgroundColor: const Color(0xFFFAFAFA),
        ),
        backgroundColor: const Color(0xffFAFAFA),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: const AddressesListView(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
