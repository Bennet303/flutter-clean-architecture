import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/get.random.number.trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements AbstractNumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTriviaEntity(number: 1, text: 'test');

  test(
    'should get trivia for random number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tNumberTrivia));

      verify(mockNumberTriviaRepository.getRandomNumberTrivia());

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
