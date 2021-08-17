import 'dart:convert';
import 'dart:developer';

import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Screens/Search%20Result%20Screen/search_result_screen.dart';
import 'package:card_walet/Utility/utils.dart';
import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'Widgets/item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  final sportsList = [
    {
      "icon": "assets/icon/cricket.png",
      'name': 'Cricket',
      'color': Color(0xFFFFF6AB),
    },
    {
      "icon": "assets/icon/football.png",
      'name': 'Football',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/basketball.png",
      'name': 'Basket Ball',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/table_tennis.png",
      'name': 'Table Tennis',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/hockey.png",
      'name': 'Hockey',
      'color': Color(0xFFFFC6A8),
    },
    {
      "icon": "assets/icon/weightlifting.png",
      'name': 'Weightlifting',
      'color': Color(0xFFFFD064),
    },
  ];

  @override
  Widget build(BuildContext context) {
    print(authController.appUser.value.toJson());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultPadding * 3),
                      bottomRight: Radius.circular(defaultPadding * 3),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment(0.26, 1.0),
                      end: Alignment(-0.26, -1.0),
                      colors: [const Color(0xff0466c8), mainColor],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  right: -defaultPadding * 5,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF).withOpacity(.3),
                    ),
                  ),
                ),
                Positioned(
                  top: -defaultPadding * 5,
                  right: -defaultPadding,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFe0f2f1).withOpacity(.1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding * 2.5,
                    horizontal: defaultPadding,
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/icon/menu.png'),
                      Spacer(),
                      UserAvatar()
                    ],
                  ),
                ),
                Positioned(
                  bottom: -defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding,
                  child: Container(
                    // padding: EdgeInsets.all(defaultPadding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x21000000),
                          offset: Offset(0, 0),
                          blurRadius: 43,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 12),
                        hintText: 'Search your favourite game',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    authController.getSportList('sport');
                    // Get.to(SearchResultScreen());
                  },
                  child: ItemWidget(
                    color: sportsList[index]['color']! as Color,
                    icon: sportsList[index]['icon']! as String,
                    name: sportsList[index]['name']! as String,
                  ),
                ),
                itemCount: sportsList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
