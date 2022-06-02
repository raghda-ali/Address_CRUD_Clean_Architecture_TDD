import 'package:formz/formz.dart';

enum DoorNumberValidationError { invalid }

class DoorNumberField
    extends FormzInput<String, DoorNumberValidationError> {
  const DoorNumberField.pure([String value = '']) : super.pure(value);

  const DoorNumberField.dirty([String value = '']) : super.dirty(value);

  @override
  DoorNumberValidationError? validator(String value) {
    return value.isNotEmpty == true && int.tryParse(value) != null
        ? null
        : DoorNumberValidationError.invalid;
  }
}
