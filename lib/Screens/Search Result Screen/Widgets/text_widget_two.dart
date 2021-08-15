import 'package:flutter/material.dart';

class TextWidgetTwo extends StatelessWidget {
  const TextWidgetTwo({
    Key? key,
    this.text,
    this.value,
  }) : super(key: key);

  final String? text;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 12,
          color: const Color(0xff565656),
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '$text',
          ),
          TextSpan(
            text: ': $value',
            style: TextStyle(
              color: const Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}
