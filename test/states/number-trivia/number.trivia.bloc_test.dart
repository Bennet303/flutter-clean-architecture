import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/core/util/input.converter.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.concrete.number.trivia.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.random.number.trivia.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.bloc.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.event.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockGetConcreteNumberTrivia extends Mock
    implements AbstractGetConcreteNumberTrivia {}

// ignore: must_be_immutable
class MockGetRandomNumberTrivia extends Mock
    implements AbstractGetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState shoud be Empty', () {
    expect(bloc.initialState, equals(NumberTriviaInitial()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);
    final tNumberTrivia = NumberTriviaEntity(text: 'test trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

        // act
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test('should emit [GetNumberTriviaError] when input is invalid', () {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputError()));

      // assert later
      final expected = [
        NumberTriviaInitial(),
        GetNumberTriviaError(error: InvalidInputError()),
      ];

      expectLater(bloc.state, emitsInOrder(expected));

      // act
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
      'should get data from concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(param: anyNamed('param')))
            .thenAnswer((_) async => Right(tNumberTrivia));

        // act
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(
            mockGetConcreteNumberTrivia(param: anyNamed('param')));

        // assert
        verify(mockGetConcreteNumberTrivia(
          param: NumberTriviaSearchEntity(number: tNumberParsed),
        ));
      },
    );

    test(
      'should emit [GetNumberTriviaLoading, GetNumberTriviaLoaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(param: anyNamed('param')))
            .thenAnswer((_) async => Right(tNumberTrivia));

        // assert later
        final expected = [
          NumberTriviaInitial(),
          GetNumberTriviaLoading(),
          GetNumberTriviaLoaded(tNumberTrivia),
        ];
        expectLater(bloc.state, emitsInOrder(expected));

        // act
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'should emit [GetNumberTriviaLoading, GetNumberTriviaError] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(param: anyNamed('param')))
            .thenAnswer((_) async => Left(ServerError()));

        // assert later
        final expected = [
          NumberTriviaInitial(),
          GetNumberTriviaLoading(),
          GetNumberTriviaError(error: ServerError()),
        ];
        expectLater(bloc.state, emitsInOrder(expected));

        // act
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTriviaEntity(number: 1, text: 'test trivia');
    test('should get data from the random use case', () async {
      // arrange
      when(mockGetConcreteNumberTrivia(param: anyNamed('param')))
          .thenAnswer((_) async => Right(tNumberTrivia));

      // act
      bloc.dispatch(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(param: anyNamed('param')));

      // assert
      verify(mockGetRandomNumberTrivia());
    });

    test(
      'should emit [GetNumberTriviaLoading, GetNumberTriviaLoaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(param: anyNamed('param')))
            .thenAnswer((_) async => Right(tNumberTrivia));

        // assert later
        final expected = [
          NumberTriviaInitial(),
          GetNumberTriviaLoading(),
          GetNumberTriviaLoaded(tNumberTrivia),
        ];
        expectLater(bloc.state, emitsInOrder(expected));

        // act
        bloc.dispatch(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [GetNumberTriviaLoading, GetNumberTriviaError] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(param: anyNamed('param')))
            .thenAnswer((_) async => Left(ServerError()));

        // assert later
        final expected = [
          NumberTriviaInitial(),
          GetNumberTriviaLoading(),
          GetNumberTriviaError(error: ServerError()),
        ];
        expectLater(bloc.state, emitsInOrder(expected));

        // act
        bloc.dispatch(GetTriviaForRandomNumber());
      },
    );
  });
}
