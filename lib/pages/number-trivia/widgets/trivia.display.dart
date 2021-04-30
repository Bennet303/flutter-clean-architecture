import 'package:clean_architecture/features/number-trivia/get/entities/number.trivia.entity.dart';
import 'package:flutter/cupertino.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTriviaEntity numberTrivia;

  const TriviaDisplay({Key key, @required this.numberTrivia})
      : assert(numberTrivia != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
