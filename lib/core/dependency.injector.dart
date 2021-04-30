import 'package:clean_architecture/core/network/network.info.dart';
import 'package:clean_architecture/core/util/input.converter.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/abstract.number.trivia.local.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/abstract.number.trivia.remote.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/number.trivia.local.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/number.trivia.remote.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/number.trivia.repository.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.concrete.number.trivia.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/abstract.get.random.number.trivia.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/get.concrete.number.trivia.dart';
import 'package:clean_architecture/features/number-trivia/get/usecases/get.random.number.trivia.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;
Future<void> init() async {
  //! Feature: GetTrivia
  //* State
  injector.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: injector(),
      getRandomNumberTrivia: injector(),
      inputConverter: injector(),
    ),
  );
  //* Use Case
  injector.registerLazySingleton<AbstractGetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(injector()));
  injector.registerLazySingleton<AbstractGetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(injector()));

  //* Repository
  injector.registerLazySingleton<AbstractNumberTriviaRepository>(
    () => NumberTriviaRepository(
      remoteDataSource: injector(),
      localDataSource: injector(),
      networkInfo: injector(),
    ),
  );

  //* Data sources
  injector.registerLazySingleton<AbstractNumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSource(
      client: injector(),
    ),
  );

  injector.registerLazySingleton<AbstractNumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSource(
      sharedPreferences: injector(),
    ),
  );

  //! Core
  injector.registerLazySingleton(() => InputConverter());
  injector.registerLazySingleton<AbstractNetworkInfo>(
    () => NetworkInfo(
      injector(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => sharedPreferences);
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => DataConnectionChecker());
}
