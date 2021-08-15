import 'package:card_walet/Screens/Search%20Result%20Screen/Widgets/text_widget_two.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.name,
    this.img,
    this.year,
    this.collection,
    this.baseInsert,
    this.parrallel,
    this.printRun,
    this.price,
    this.onPress,
  }) : super(key: key);

  final String? name;
  final String? img;
  final String? year;
  final String? collection;
  final String? baseInsert;
  final String? parrallel;
  final String? printRun;
  final String? price;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x47d0d0d0),
              offset: Offset(-3.0616169991140216e-16, 5),
              blurRadius: 16,
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(defaultPadding),
                    ),
                  ),
                  child: Image.asset(img!),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$name ',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xff000000),
                          height: 1.1785714285714286,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xff565656),
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: 'Year :',
                            ),
                            TextSpan(
                              text: ' $year  ',
                              style: TextStyle(
                                color: const Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: '|',
                            ),
                            TextSpan(
                              text: '  ',
                              style: TextStyle(
                                color: const Color(0xff000000),
                              ),
                            ),
                            TextSpan(
                              text: 'Collection :',
                            ),
                            TextSpan(
                              text: ' $collection',
                              style: TextStyle(
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextWidgetTwo(
                        text: 'Base/Insert',
                        value: '$baseInsert',
                      ),
                      TextWidgetTwo(
                        text: 'Parallel',
                        value: '$parrallel',
                      ),
                      TextWidgetTwo(
                        text: 'Print Run',
                        value: '$printRun',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding / 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.5),
                  color: const Color(0xffc2e1ff),
                ),
                child: Text(
                  '\$22.15',
                  style: TextStyle(
                    fontSize: 14,
                    color: mainColor,
                    height: 1.1,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
