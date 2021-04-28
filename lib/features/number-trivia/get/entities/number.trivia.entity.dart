import 'package:clean_architecture/core/entities/abstract.entity.dart';
import 'package:clean_architecture/features/number-trivia/get/models/number.trivia.model.dart';
import 'package:meta/meta.dart';

class NumberTriviaEntity extends AbstractEntity {
  final String text;
  final int number;

  const NumberTriviaEntity({@required this.text, @required this.number});

  factory NumberTriviaEntity.fromModel(NumberTriviaModel model) =>
      NumberTriviaEntity(text: model.text, number: model.number);

  @override
  List<Object> get props => [this.text, this.number];
}
