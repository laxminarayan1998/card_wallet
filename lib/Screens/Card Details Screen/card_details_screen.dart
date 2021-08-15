import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'Widgets/detail_widget.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'Card Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Transform.scale(
            scale: .7,
            child: UserAvatar(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/img1.png',
              width: double.infinity,
              height: Get.height * .5,
              fit: BoxFit.cover,
            ),
            SizedBox(height: defaultPadding),
            DetailWidget(
              text: 'Player Name',
              value: 'Ashley Williams',
            ),
            DetailWidget(
              text: 'Sport',
              value: 'Football (Soccer)',
            ),
            DetailWidget(
              text: 'Year',
              value: '2016',
            ),
            DetailWidget(
              text: 'Collection',
              value: 'Prizm UEFA EURO',
            ),
            DetailWidget(
              text: 'Base / Insert',
              value: 'Signatures',
            ),
          ],
        ),
      ),
    );
  }
}
