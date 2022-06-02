import 'package:formz/formz.dart';

enum PlaceNameValidationError { invalid }

class PlaceNameField extends FormzInput<String, PlaceNameValidationError> {
  const PlaceNameField.pure([String value = '']) : super.pure(value);

  const PlaceNameField.dirty([String value = '']) : super.dirty(value);

  @override
  PlaceNameValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : PlaceNameValidationError.invalid;
  }
}
