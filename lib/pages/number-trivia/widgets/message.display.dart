import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({Key key, @required this.message})
      : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: Text(message),
      ),
    );
  }
}
