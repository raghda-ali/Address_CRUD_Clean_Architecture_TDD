import 'package:formz/formz.dart';

enum BuildingNumberValidationError { invalid }

class BuildingNumberField
    extends FormzInput<String, BuildingNumberValidationError> {
  const BuildingNumberField.pure([String value = '']) : super.pure(value);

  const BuildingNumberField.dirty([String value = '']) : super.dirty(value);

  @override
  BuildingNumberValidationError? validator(String value) {
    return value.isNotEmpty == true
        ? null
        : BuildingNumberValidationError.invalid;
  }
}
