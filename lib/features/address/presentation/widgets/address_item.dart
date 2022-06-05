import 'package:addresscrud_clean_architecture/features/address/presentation/logic/address_cubit.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/pages/update_address.dart';
import 'package:addresscrud_clean_architecture/features/address/presentation/widgets/custom_toast_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressItem extends StatelessWidget {
  final String buildingNumber;
  final String addressName;
  final String floorNumber;
  final String doorNumber;
  final int? index;
  int? id;

  AddressItem({
    Key? key,
    required this.buildingNumber,
    required this.addressName,
    required this.floorNumber,
    required this.doorNumber,
    this.index,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 5),
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage(
                              'assets/images/Iconawesome-building.png'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(buildingNumber),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 5),
                    child: Text(
                      floorNumber,
                      style: const TextStyle(
                        color: Color(0xFF757575),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      addressName,
                      style: const TextStyle(
                        color: Color(0xFF757575),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateAddressScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.pink[300],
                    )),
                IconButton(
                    onPressed: () {
                      addressCubit.deleteAddress(id!);
                    },
                    icon: Icon(
                      Icons.highlight_remove_rounded,
                      color: Colors.pink[300],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
