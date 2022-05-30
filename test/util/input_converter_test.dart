import 'package:addresscrud_clean_architecture/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });
  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
            () async {
          //arrange
          const str = '3';
          //act
          final result = inputConverter.stringToUnsignedInteger(str);
          //assert
          expect(result, const Right(3));
        });
    test('should return failure when the string is not an integer', () async {
      //arrange
      const str = 'a';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return failure when the string is negative number', () async {
      //arrange
      const str = '-1';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
  group('stringToDouble', () {
    test(
        'should return an double when the string represents an double',
            () async {
          //arrange
          const str = '1.2';
          //act
          final result = inputConverter.stringToDouble(str);
          //assert
          expect(result, const Right(1.2));
        });
    test('should return failure when the string is not double', () async {
      //arrange
      const str = 'a';
      //act
      final result = inputConverter.stringToDouble(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return failure when the string is negative number', () async {
      //arrange
      const str = '-1';
      //act
      final result = inputConverter.stringToDouble(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
