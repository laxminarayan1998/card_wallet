import 'package:cached_network_image/cached_network_image.dart';
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
      child: Container(
        width: 40,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10000.0),
          child: CachedNetworkImage(
            imageUrl: imgUrl!,
            placeholder: (context, url) =>
                Container(child: CircularProgressIndicator()),
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(
              Icons.account_circle_rounded,
              size: 40,
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }
}
