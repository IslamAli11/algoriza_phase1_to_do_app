
import 'package:flutter/cupertino.dart';

class DefaultText extends StatelessWidget {
  final String text;

  const DefaultText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}