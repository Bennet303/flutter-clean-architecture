import 'package:clean_architecture/core/entities/abstract.entity.dart';
import 'package:flutter/cupertino.dart';

class NumberTriviaSearchEntity extends AbstractEntity {
  final int number;

  NumberTriviaSearchEntity({@required this.number});

  @override
  List<Object> get props => [number];
}
