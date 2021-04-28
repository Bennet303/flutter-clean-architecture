import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepository implements AbstractNumberTriviaRepository {
  @override
  Future<Either<AbstractError, NumberTriviaEntity>> getConcreteNumberTrivia(
      NumberTriviaSearchEntity searchModel) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<AbstractError, NumberTriviaEntity>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
