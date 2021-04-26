import 'dart:convert';

import 'package:clean_architecture/features/number-trivia/get/models/number.trivia.model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(text: 'Test Text', number: 1);

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);

        //assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is regarded as a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('trivia.double.json'));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);

        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });
}
