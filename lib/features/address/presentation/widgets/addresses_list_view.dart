import 'package:addresscrud_clean_architecture/features/address/presentation/pages/address.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/address_item.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/custom_toast_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/address_cubit.dart';

class AddressesListView extends StatefulWidget {
  const AddressesListView({Key? key}) : super(key: key);

  @override
  State<AddressesListView> createState() => _AddressesListViewState();
}

class _AddressesListViewState extends State<AddressesListView> {
  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is DeleteAddressSuccess) {
          showToastBar(context, "Address Deleted Successfully");
        }
      },
      builder: (context, state) {
        if (state is AddressLoading) {
          return const Text("Loading...");
        } else if (state is AddressError) {
          return const Text("Error");
        } else {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              primary: true,
              physics: const ClampingScrollPhysics(),
              itemCount: addressCubit.addressList.length,
              itemBuilder: (context, index) => AddressItem(
                index: index,
                id: addressCubit.addressList[index].id,
                doorNumber:
                    addressCubit.addressList[index].doorNumber.toString(),
                floorNumber:
                    addressCubit.addressList[index].floorNumber.toString(),
                buildingNumber: addressCubit.addressList[index].buildingNumber,
                addressName: addressCubit.addressList[index].addressName,
              ),
            ),
          );
        }
      },
    );
  }
}
