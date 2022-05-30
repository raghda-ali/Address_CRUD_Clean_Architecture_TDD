import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    int? integer = int.tryParse(str);
    try {
      if (integer == null || integer < 0) return Left(InvalidInputFailure());
      return Right(int.parse(str));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, double> stringToDouble(String str) {
    double? d = double.tryParse(str);
    try {
      if (d == null || d < 0) return Left(InvalidInputFailure());
      return Right(double.parse(str));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
