import 'package:clean_architecture/features/number-trivia/get/data-source/abstract.number.trivia.remote.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/models/number.trivia.model.dart';

class NumberTriviaRemoteDataSource
    extends AbstractNumberTriviaRemoteDataSource {
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
