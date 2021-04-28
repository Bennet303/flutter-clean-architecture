import 'package:clean_architecture/core/entities/abstract.entity.dart';
import 'package:clean_architecture/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AbstractUseCase<I extends AbstractEntity,
    O extends Future<Either<AbstractError, AbstractEntity>>> {
  const AbstractUseCase();

  O call({I param});
}
