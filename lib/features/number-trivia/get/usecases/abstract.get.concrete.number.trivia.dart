import 'package:clean_architecture/core/abstracts/abstract.use.case.dart';
import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractGetConcreteNumberTrivia extends AbstractUseCase<
    NumberTriviaSearchEntity,
    Future<Either<AbstractError, NumberTriviaEntity>>> {
  @override
  Future<Either<AbstractError, NumberTriviaEntity>> call(
      {NumberTriviaSearchEntity param});
}
