import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/network/network.info.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/abstract.number.trivia.local.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/data-source/abstract.number.trivia.remote.data.source.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.search.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:clean_architecture/core/error/errors.dart';
import 'package:clean_architecture/features/number-trivia/get/models/number.trivia.model.dart';
import 'package:meta/meta.dart';
import 'package:clean_architecture/features/number-trivia/get/repository/abstract.number.trivia.repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepository implements AbstractNumberTriviaRepository {
  final AbstractNumberTriviaRemoteDataSource remoteDataSource;
  final AbstractNumberTriviaLocalDataSource localDataSource;
  final AbstractNetworkInfo networkInfo;

  NumberTriviaRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<AbstractError, NumberTriviaEntity>> getConcreteNumberTrivia(
      NumberTriviaSearchEntity searchModel) async {
    return await _getTrivia(
      () => remoteDataSource.getConcreteNumberTrivia(searchModel.number),
    );
  }

  @override
  Future<Either<AbstractError, NumberTriviaEntity>>
      getRandomNumberTrivia() async {
    return await _getTrivia(
      () => remoteDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<AbstractError, NumberTriviaEntity>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      return await _getNumberTriviaRemote(getConcreteOrRandom);
    } else {
      return await _getNumberTriviaLocally();
    }
  }

  Future<Either<AbstractError, NumberTriviaEntity>>
      _getNumberTriviaLocally() async {
    try {
      final localTrivia = await localDataSource.getLastNumberTrivia();
      return Right(NumberTriviaEntity.fromModel(localTrivia));
    } on CacheException {
      return Left(CacheError());
    }
  }

  Future<Either<AbstractError, NumberTriviaEntity>> _getNumberTriviaRemote(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    try {
      final remoteTrivia = await getConcreteOrRandom();
      localDataSource.cacheNumberTrivia(remoteTrivia);
      return Right(NumberTriviaEntity.fromModel(remoteTrivia));
    } on ServerException {
      return Left(ServerError());
    }
  }
}
