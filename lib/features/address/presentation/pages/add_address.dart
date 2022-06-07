import 'package:addresscrud_clean_architecture/core/rules/building_no_field.dart';
import 'package:addresscrud_clean_architecture/core/rules/door_no_field.dart';
import 'package:addresscrud_clean_architecture/core/rules/floor_no_field.dart';
import 'package:addresscrud_clean_architecture/core/rules/place_name_field.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/logic/address_cubit.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/pages/address.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/custom_text_field.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/custom_toast_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Form(
        key: key,
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressError) {
              showToastBar(context, state.toString());
            } else if (state is AddressValid) {
              addressCubit.addAddress();
            } else if (state is AddAddressSuccess) {
              showToastBar(context, "Address Added Successfully");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DisplayAddresses()),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  CustomTextFormField(
                    hintText: "Enter Place name",
                    errorText:
                        addressCubit.addressTextFieldForm.placeNameField.invalid
                            ? "please enter your place name"
                            : null,
                    onSave: (v) {
                      addressCubit.addressTextFieldForm.placeNameField =
                          PlaceNameField.dirty(v!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: "Enter building number",
                    errorText: addressCubit
                            .addressTextFieldForm.buildingNumberField.invalid
                        ? "please enter your building number"
                        : null,
                    onSave: (v) {
                      addressCubit.addressTextFieldForm.buildingNumberField =
                          BuildingNumberField.dirty(v!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: "Enter Floor no",
                    errorText: addressCubit
                            .addressTextFieldForm.floorNumberField.invalid
                        ? "please enter your Floor no"
                        : null,
                    onSave: (v) {
                      addressCubit.addressTextFieldForm.floorNumberField =
                          FloorNumberField.dirty(v!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: "Enter Door no",
                    errorText: addressCubit
                            .addressTextFieldForm.doorNumberField.invalid
                        ? "please enter your door no"
                        : null,
                    onSave: (v) {
                      addressCubit.addressTextFieldForm.doorNumberField =
                          DoorNumberField.dirty(v!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      key.currentState!.save();

                      addressCubit.validate();
                    },
                    color: Colors.grey,
                    child: const Text(
                      "Add Address",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DisplayAddresses()),
                      );
                    },
                    color: Colors.grey,
                    child: const Text(
                      "Addresses",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
