import 'package:clean_architecture/core/entities/abstract.entity.dart';
import 'package:meta/meta.dart';

class NumberTriviaEntity extends AbstractEntity {
  final String text;
  final int number;

  const NumberTriviaEntity({@required this.text, @required this.number});

  @override
  List<Object> get props => [this.text, this.number];
}
