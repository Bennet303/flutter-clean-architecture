import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.concrete.number.trivia.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia extends AbstractGetConcreteNumberTrivia {
  final AbstractNumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<AbstractError, NumberTriviaEntity>> call(
      {NumberTriviaSearchEntity param}) async {
    return await repository.getConcreteNumberTrivia(param);
  }
}
