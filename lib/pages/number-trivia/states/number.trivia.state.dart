import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaState extends Equatable {}

class NumberTriviaInitial extends NumberTriviaState {
  @override
  List<Object> get props => const [];
}

class GetNumberTriviaLoading extends NumberTriviaState {
  @override
  List<Object> get props => const [];
}

class GetNumberTriviaLoaded extends NumberTriviaState {
  final NumberTriviaEntity numberTrivia;

  GetNumberTriviaLoaded(this.numberTrivia);

  @override
  List<Object> get props => [this.numberTrivia];
}

class GetNumberTriviaError extends NumberTriviaState {
  final AbstractError error;

  GetNumberTriviaError({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [this.error];
}
