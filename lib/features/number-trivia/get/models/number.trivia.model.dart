import 'package:clean_architecture/core/models/abstract.model.dart';
import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:meta/meta.dart';

class NumberTriviaModel extends AbstractModel {
  final String text;
  final int number;

  const NumberTriviaModel({@required this.text, @required this.number});

  factory NumberTriviaModel.fromEntity(NumberTriviaEntity entity) =>
      NumberTriviaModel(text: entity.text, number: entity.number);

  @override
  List<Object> get props => [this.text, this.number];
}
