import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/address_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/address_cubit.dart';

class AddressesListView extends StatefulWidget {
  const AddressesListView({Key? key}) : super(key: key);

  @override
  State<AddressesListView> createState() => _AddressesListViewState();
}

class _AddressesListViewState extends State<AddressesListView> {
  static final GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
      if (state is GetAddressSuccess) {
        return SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            primary: true,
            physics: const ClampingScrollPhysics(),
            itemCount: state.addressModel.length,
            itemBuilder: (context, index) => AddressItem(
              index: index,
              doorNumber: state.addressModel[index].doorNumber.toString(),
              floorNumber: state.addressModel[index].floorNumber.toString(),
              buildingNumber: state.addressModel[index].buildingNumber,
              addressName: state.addressModel[index].addressName,
            ),
          ),
        );
      } else if (state is AddressLoading) {
        return const Text("Loading");
      } else {
        return Text(state.toString());
      }
    });
  }
}
