import 'package:card_walet/Utility/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class CustomCardTwo extends StatelessWidget {
  const CustomCardTwo({
    Key? key,
    this.img,
    this.title,
    this.subTitle,
    this.grade,
    this.listingType,
    this.recommendation,
    this.type,
    this.price,
    this.onPress,
    this.btnText = 'BUY NOW',
  }) : super(key: key);

  final String? img;
  final String? title;
  final String? subTitle;
  final String? grade;
  final String? listingType;
  final CardType? type;
  final String? recommendation;
  final String? price;
  final Function()? onPress;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(defaultPadding / 2),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultPadding / 2),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.9),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            img!,
            fit: BoxFit.cover,
            width: Get.width * .2,
            // height: Get.height * .1,
          ),
          SizedBox(width: defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Grade: $grade',
                ),
                if (recommendation != null)
                  Text(
                    'Recommedation: $recommendation',
                  ),
                if (listingType != null)
                  Text(
                    'Listing Type: $listingType',
                  ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding / 2),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(defaultPadding / 2),
                        ),
                      ),
                      child: Text(
                        '﹩$price',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: defaultPadding / 2),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(defaultPadding / 2),
                          ),
                        ),
                      ),
                      onPressed: onPress,
                      child: Text(btnText!),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
