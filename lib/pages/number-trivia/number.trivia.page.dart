import 'package:clean_architecture/core/dependency.injector.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.bloc.dart';
import 'package:clean_architecture/pages/number-trivia/states/number.trivia.state.dart';
import 'package:clean_architecture/pages/number-trivia/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(
          context,
        ),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is NumberTriviaInitial) {
                    return MessageDisplay(message: 'Start searching!');
                  } else if (state is GetNumberTriviaLoading) {
                    return LoadingWidget();
                  } else if (state is GetNumberTriviaLoaded) {
                    return TriviaDisplay(numberTrivia: state.numberTrivia);
                  } else if (state is GetNumberTriviaError) {
                    return MessageDisplay(message: state.error.message);
                  }
                  return Container();
                },
              ),
              SizedBox(height: 20),
              TriviaControl(),
            ],
          ),
        ),
      ),
    );
  }
}
