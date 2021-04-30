import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/abstract.number.trivia.remote.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/models/number.trivia.model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class NumberTriviaRemoteDataSource
    extends AbstractNumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSource({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getNumberTriviaFromUrl('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getNumberTriviaFromUrl('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _getNumberTriviaFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200)
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    else
      throw ServerException();
  }
}
