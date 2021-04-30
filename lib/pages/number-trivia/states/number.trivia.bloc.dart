import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/core/util/input.converter.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.concrete.number.trivia.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.random.number.trivia.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.event.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.state.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final AbstractGetConcreteNumberTrivia getConcreteNumberTrivia;
  final AbstractGetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  })  : assert(getConcreteNumberTrivia != null),
        assert(getRandomNumberTrivia != null),
        assert(inputConverter != null);

  @override
  NumberTriviaState get initialState => NumberTriviaInitial();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (error) async* {
          yield GetNumberTriviaError(error: error);
        },
        (integer) async* {
          yield GetNumberTriviaLoading();
          final errorOrTrivia = await getConcreteNumberTrivia(
            param: NumberTriviaSearchEntity(number: integer),
          );
          yield* _mapErrorOrTriviaToState(errorOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield GetNumberTriviaLoading();
      final errorOrTrivia = await getRandomNumberTrivia();
      yield* _mapErrorOrTriviaToState(errorOrTrivia);
    }
  }

  Stream<NumberTriviaState> _mapErrorOrTriviaToState(
      Either<AbstractError, NumberTriviaEntity> either) async* {
    yield either.fold(
      (error) => GetNumberTriviaError(error: error),
      (trivia) => GetNumberTriviaLoaded(trivia),
    );
  }
}
