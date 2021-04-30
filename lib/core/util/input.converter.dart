import 'package:clean_architecture/core/error/errors.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<AbstractError, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputError());
    }
  }
}

class InvalidInputError extends AbstractError {
  InvalidInputError() : super(message: 'InvalidInputError');
}
