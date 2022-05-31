import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddressItem extends StatelessWidget {
  final String buildingNumber;
  final String addressName;
  final String floorNumber;
  final String doorNumber;
  final bool? isSelected;
  final int? index;
  final int? groupValue;

  const AddressItem({
    Key? key,
    required this.buildingNumber,
    required this.addressName,
    required this.floorNumber,
    required this.doorNumber,
    this.index,
    this.groupValue,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.44,
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (context) {
              },
              backgroundColor: const Color(0xFFE5AF1A),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
            ),
            SlidableAction(
              flex: 2,
              onPressed: (context) {
              },
              backgroundColor: const Color(0xFFAA1515),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete',
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: 130,
          // margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
              ),
            ],
            // border: Border.all(
            //   color: isSelected == true ? AppTheme.primaryColor : AppTheme.grey,
            // ),
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
                              image: AssetImage('assets/images/Iconawesome-building.png'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
