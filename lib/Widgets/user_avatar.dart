import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.imgUrl,
    this.onPress,
  }) : super(key: key);

  final String? imgUrl;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CircleAvatar(
        radius: 25.0,
        backgroundImage: NetworkImage(imgUrl!),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
