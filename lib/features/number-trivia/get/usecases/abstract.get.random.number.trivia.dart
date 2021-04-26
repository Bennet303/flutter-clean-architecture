import 'package:clean_architecture/core/abstracts/abstract.use.case.dart';
import 'package:clean_architecture/core/entities/abstract.entity.dart';
import 'package:clean_architecture/core/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractGetRandomNumberTrivia extends AbstractUseCase<
    AbstractEntity, Future<Either<AbstractError, NumberTriviaEntity>>> {}
