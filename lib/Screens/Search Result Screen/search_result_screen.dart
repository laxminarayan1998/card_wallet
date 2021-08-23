import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Screens/Card%20Details%20Screen/card_details_screen.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/custom_card.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({Key? key}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final AuthController authController = Get.find();

  final scrollController = ScrollController();

  int limit = 10;
  int skip = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          skip = limit + skip;
          if (limit <= authController.totalCount.value) {
            authController.getSportList(
              limit: limit,
              skip: skip,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authController.totalCount.value = 0;
    return FutureBuilder(
      future: Future.wait([
        authController.getSportList(
          limit: limit,
          skip: 0,
        ),
        authController.getSportListCount()
      ]),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            leading: CustomBackButton(),
            title: Text(
              'Search Results (${authController.totalCount})',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Obx(
                () => Column(
                  children: [
                    ...List.generate(
                      authController.playersList.length,
                      (index) => CustomCard(
                        img: authController.playersList[index].imageUrl,
                        baseInsert: authController.playersList[index].sport,
                        collection: authController.playersList[index].variation,
                        name: authController.playersList[index].playerName,
                        parrallel: '#\'d / 79',
                        printRun: '79',
                        setName: authController.playersList[index].setName,
                        year: authController.playersList[index].setYear,
                        price: authController.playersList[index].priceScore,
                        onPress: () {
                          authController.selectedPlayer.value =
                              authController.playersList[index];
                          Get.to(
                            () => CardDetailsScreen(
                              id: authController.playersList[index].id!,
                            ),
                          );
                        },
                      ),
                    ).toList()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
