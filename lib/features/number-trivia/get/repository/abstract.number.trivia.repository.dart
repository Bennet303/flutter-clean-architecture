import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractNumberTriviaRepository {
  Future<Either<AbstractError, NumberTriviaEntity>> getConcreteNumberTrivia(
      NumberTriviaSearchEntity searchModel);
  Future<Either<AbstractError, NumberTriviaEntity>> getRandomNumberTrivia();
}
