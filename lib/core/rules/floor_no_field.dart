import 'package:formz/formz.dart';

enum FloorNumberValidationError { invalid }

class FloorNumberField
    extends FormzInput<String, FloorNumberValidationError> {
  const FloorNumberField.pure([String value = '']) : super.pure(value);

  const FloorNumberField.dirty([String value = '']) : super.dirty(value);

  @override
  FloorNumberValidationError? validator(String value) {
    return value.isNotEmpty == true && int.tryParse(value) != null
        ? null
        : FloorNumberValidationError.invalid;
  }
}
