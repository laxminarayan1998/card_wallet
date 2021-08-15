import 'package:card_walet/Screens/Card%20Details%20Screen/card_details_screen.dart';
import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:card_walet/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/custom_card.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'Search Results',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              ...List.generate(
                6,
                (index) => CustomCard(
                  img: 'assets/images/img1.png',
                  baseInsert: 'Base',
                  collection: 'Gala',
                  name: 'LeBorn James',
                  parrallel: '#\'d / 79',
                  printRun: '79',
                  year: '2014',
                  onPress: () {
                    Get.to(() => CardDetailsScreen());
                  },
                ),
              ).toList()
            ],
          ),
        ),
      ),
    );
  }
}
