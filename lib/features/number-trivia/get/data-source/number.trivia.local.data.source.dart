import 'dart:convert';

import 'package:clean_architecture/core/constants.dart';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/number-trivia/get/models/number.trivia.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

import 'abstract.number.trivia.local.data.source.dart';

class NumberTriviaLocalDataSource
    implements AbstractNumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSource({@required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    final jsonString = jsonEncode(triviaToCache);
    return sharedPreferences.setString(
        Constants.KEY_CACHED_NUMBER_TRIVIA, jsonString);
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString =
        sharedPreferences.getString(Constants.KEY_CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
