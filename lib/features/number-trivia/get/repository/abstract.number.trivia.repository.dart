import 'package:clean_architecture/core/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractNumberTriviaRepository {
  Future<Either<AbstractError, NumberTriviaEntity>> getConcreteNumberTrivia(
      int number);
  Future<Either<AbstractError, NumberTriviaEntity>> getRandomNumberTrivia();
}
