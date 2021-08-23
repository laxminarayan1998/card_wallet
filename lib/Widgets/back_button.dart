import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({
    Key? key,
    this.onPress,
  }) : super(key: key);

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress ??
          () {
            Get.back();
          },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }
}
