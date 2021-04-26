import 'package:clean_architecture/core/entities/abstract.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/core/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.random.number.trivia.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia extends AbstractGetRandomNumberTrivia {
  final AbstractNumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<AbstractError, NumberTriviaEntity>> call(
      {AbstractEntity param}) async {
    return await repository.getRandomNumberTrivia();
  }
}
