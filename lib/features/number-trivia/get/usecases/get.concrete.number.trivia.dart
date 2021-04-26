import 'package:clean_architecture/core/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetConcreteNumberTrivia {
  final AbstractNumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<AbstractError, NumberTriviaEntity>> execute({
    @required int number,
  }) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
