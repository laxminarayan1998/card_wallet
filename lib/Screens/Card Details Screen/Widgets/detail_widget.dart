import 'package:flutter/material.dart';

import '../../../constants.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    this.text,
    this.value,
  }) : super(key: key);

  final String? text;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: TextStyle(
                  fontSize: defaultPadding,
                  color: const Color(0xff565656),
                  height: 1.1,
                ),
              ),
              Text(
                '$value',
                style: TextStyle(
                  fontSize: defaultPadding,
                  color: const Color(0xff1b1b1b),
                  height: 1.1,
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
