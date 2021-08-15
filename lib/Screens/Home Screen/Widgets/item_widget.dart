import 'package:flutter/material.dart';

import '../../../constants.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    this.icon,
    this.name,
    this.color,
  }) : super(key: key);

  final String? icon;
  final String? name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(defaultPadding / 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon!,
              height: defaultPadding * 3,
            ),
            SizedBox(height: defaultPadding),
            Text(
              name!,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
