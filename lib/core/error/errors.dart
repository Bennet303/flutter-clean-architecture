import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AbstractError extends Equatable {
  final String message;

  const AbstractError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class ServerError extends AbstractError {
  ServerError() : super(message: 'ServerError');
}

class CacheError extends AbstractError {
  CacheError() : super(message: 'CacheError');
}
