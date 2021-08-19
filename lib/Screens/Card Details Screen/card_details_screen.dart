import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'Widgets/detail_widget.dart';

class CardDetailsScreen extends StatelessWidget {
  CardDetailsScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: CustomBackButton(),
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
            Image.network(
              authController.selectedCard.value.imageUrl!,
              width: double.infinity,
              height: Get.height * .5,
              fit: BoxFit.cover,
            ),
            SizedBox(height: defaultPadding),
            DetailWidget(
              text: 'Player Name',
              value: '${authController.selectedCard.value.playerName}',
            ),
            DetailWidget(
              text: 'Sport',
              value: '${authController.selectedCard.value.sport}',
            ),
            DetailWidget(
              text: 'Year',
              value: '${authController.selectedCard.value.setYear}',
            ),
            DetailWidget(
              text: 'Collection',
              value: '${authController.selectedCard.value.variation}',
            ),
            DetailWidget(
              text: 'Base / Insert',
              value: '${authController.selectedCard.value.setName}',
            ),
          ],
        ),
      ),
    );
  }
}
