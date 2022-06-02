import 'package:addresscrud_clean_architecture/core/rules/building_no_field.dart';
import 'package:addresscrud_clean_architecture/core/rules/door_no_field.dart';
import 'package:addresscrud_clean_architecture/core/rules/floor_no_field.dart';
import 'package:addresscrud_clean_architecture/core/rules/place_name_field.dart';
import 'package:formz/formz.dart';

class AddressTextFieldForm with FormzMixin {
  PlaceNameField placeNameField;
  BuildingNumberField buildingNumberField;
  DoorNumberField doorNumberField;
  FloorNumberField floorNumberField;

  AddressTextFieldForm({
    this.placeNameField = const PlaceNameField.pure(),
    this.buildingNumberField = const BuildingNumberField.pure(),
    this.floorNumberField = const FloorNumberField.pure(),
    this.doorNumberField = const DoorNumberField.pure(),
  });

  @override
  List<FormzInput> get inputs =>
      [placeNameField, buildingNumberField, floorNumberField, doorNumberField];
}
