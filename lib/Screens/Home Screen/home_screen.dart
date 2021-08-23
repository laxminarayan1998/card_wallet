import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Screens/Profile%20Screen/profile_screen.dart';
import 'package:card_walet/Screens/Search%20Result%20Screen/search_result_screen.dart';
import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'Widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.find();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _result;

  final sportsList = [
    {
      "icon": "assets/icon/cricket.png",
      'name': 'Cricket',
      'color': Color(0xFFFFF6AB),
    },
    {
      "icon": "assets/icon/football.png",
      'name': 'Baseball',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/basketball.png",
      'name': 'Basketball',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/table_tennis.png",
      'name': 'Boxing',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/hockey.png",
      'name': 'Football',
      'color': Color(0xFFFFC6A8),
    },
    {
      "icon": "assets/icon/weightlifting.png",
      'name': 'Golf',
      'color': Color(0xFFFFD064),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                  accountName: Text(
                      "${authController.appUser.value.userDetails!.firstName} ${authController.appUser.value.userDetails!.lastName}"),
                  accountEmail: Text(
                      "${authController.appUser.value.userDetails!.email}"),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      imageUrl: authController
                          .appUser.value.userDetails!.profilePicture!,
                      placeholder: (context, url) =>
                          Container(child: CircularProgressIndicator()),
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Text(
                        "${authController.appUser.value.userDetails!.firstName![0].toUpperCase()}",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  )),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () {
                Navigator.pop(context);
                authController.logOut();
              },
            ),
          ],
        ),
      ),
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
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Image.asset('assets/icon/menu.png'),
                      ),
                      Spacer(),
                      Obx(
                        () => UserAvatar(
                          onPress: () {
                            Get.to(() => ProfilePage());
                          },
                          imgUrl: authController
                              .appUser.value.userDetails!.profilePicture!,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -defaultPadding,
                  left: defaultPadding,
                  right: defaultPadding,
                  child: Container(
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
                      onTap: () async {
                        var result = await showSearch<String>(
                          context: context,
                          delegate: CustomDelegate(),
                        );
                        setState(() => _result = result);
                      },
                      readOnly: true,
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
                    authController.selectedSport.value =
                        sportsList[index]['name']! as String;
                    Get.to(() => SearchResultScreen());
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

class CustomDelegate extends SearchDelegate<String> {
  final AuthController authController = Get.find();

  final sportsList = [
    {
      "icon": "assets/icon/cricket.png",
      'name': 'Cricket',
      'color': Color(0xFFFFF6AB),
    },
    {
      "icon": "assets/icon/football.png",
      'name': 'Baseball',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/basketball.png",
      'name': 'Basketball',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/table_tennis.png",
      'name': 'Boxing',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/hockey.png",
      'name': 'Football',
      'color': Color(0xFFFFC6A8),
    },
    {
      "icon": "assets/icon/weightlifting.png",
      'name': 'Golf',
      'color': Color(0xFFFFD064),
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.chevron_left), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    List<Map<String, Object>> listToShow;
    if (query.isNotEmpty)
      listToShow = sportsList
          .where((e) =>
              e['name']!.toString().toLowerCase().contains(query) &&
              e['name']!.toString().toLowerCase().startsWith(query))
          .toList();
    else
      listToShow = sportsList;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GridView.builder(
        itemCount: listToShow.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, i) {
          var noun = listToShow[i];
          return GestureDetector(
            onTap: () {
              authController.selectedSport.value = noun['name']! as String;
              Get.to(() => SearchResultScreen());
            },
            child: ItemWidget(
              color: noun['color']! as Color,
              icon: noun['icon']! as String,
              name: noun['name']! as String,
            ),
          );
        },
      ),
    );
  }
}
