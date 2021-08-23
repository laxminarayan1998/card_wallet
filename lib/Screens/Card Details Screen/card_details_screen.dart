import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Model/PlayerDetail.dart';
import 'package:card_walet/Utility/enums.dart';
import 'package:card_walet/Utility/utils.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/Widgets/cutom_card_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import 'Widgets/detail_widget.dart';

class CardDetailsScreen extends StatelessWidget {
  CardDetailsScreen({Key? key, this.id}) : super(key: key);

  final AuthController authController = Get.find();

  final String? id;

  @override
  Widget build(BuildContext context) {
    Utility.showLog(level: Level.info, msg: 'ID: $id');
    return FutureBuilder(
      future: authController.getCardDetaislsByID(selectedCardId: id),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            leading: CustomBackButton(
              onPress: () {
                authController.selectedCard.value = PlayerDetailModel();
                Get.back();
              },
            ),
            title: Text(
              'Card Details',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              authController.selectedCard.value = PlayerDetailModel();
              return true;
            },
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: mainColor,
                    child: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: 'DETAILS',
                        ),
                        Tab(
                          text: 'BUY NOW',
                        ),
                        Tab(
                          text: 'RECENT SALES',
                        ),
                        Tab(
                          text: 'CHARTS',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TabOne(),
                        (authController.selectedCard.value.buyNow == null ||
                                authController
                                    .selectedCard.value.buyNow!.isEmpty)
                            ? Center(
                                child: Text('No Card Data Available!'),
                              )
                            : TabTwo(),
                        (authController.selectedCard.value.recentSales ==
                                    null ||
                                authController
                                    .selectedCard.value.recentSales!.isEmpty)
                            ? Center(
                                child: Text('No Card Data Available!'),
                              )
                            : TabThree(),
                        (authController.selectedCard.value.charts == null ||
                                authController
                                    .selectedCard.value.charts!.isEmpty)
                            ? Center(
                                child: Text('No Card Data Available!'),
                              )
                            : TabFour(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TabFour extends StatefulWidget {
  TabFour({
    Key? key,
  }) : super(key: key);

  @override
  _TabFourState createState() => _TabFourState();
}

class _TabFourState extends State<TabFour> {
  final AuthController authController = Get.find();

  final DateFormat formatter = DateFormat('dd/MM');

  var selectedGraph;
  Charts? chart;

  @override
  void initState() {
    selectedGraph = authController.selectedCard.value.grades![0];
    chart = authController.selectedCard.value.charts!.firstWhere(
      (element) => element.grade == selectedGraph,
      orElse: () => Charts(grade: '', series: [], title: ''),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              authController.selectedCard.value.grades!.length,
              (index) => GestureDetector(
                onTap: () {
                  selectedGraph =
                      authController.selectedCard.value.grades![index];
                  chart = authController.selectedCard.value.charts!.firstWhere(
                    (element) => element.grade == selectedGraph,
                    orElse: () => Charts(grade: '', series: [], title: ''),
                  );
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: defaultPadding / 2),
                  child: Chip(
                    backgroundColor: selectedGraph ==
                            authController.selectedCard.value.grades![index]
                        ? mainColor
                        : null,
                    labelStyle: TextStyle(
                      color: selectedGraph ==
                              authController.selectedCard.value.grades![index]
                          ? Colors.white
                          : null,
                    ),
                    label: Text(
                      authController.selectedCard.value.grades![index],
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
        if (chart != null)
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  dataSource: List.generate(
                    chart!.series!.length,
                    (index) {
                      final date = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(chart!.series![index].day!) * 1000);
                      return SalesData(
                        formatter.format(date),
                        double.parse(
                            chart!.series![index].price!.toStringAsFixed(2)),
                      );
                    },
                  ),
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class TabTwo extends StatelessWidget {
  TabTwo({
    Key? key,
  }) : super(key: key);

  final AuthController authController = Get.find();

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          authController.selectedCard.value.buyNow!.length,
          (index) => CustomCardTwo(
            img: authController.selectedCard.value.buyNow![index].thumbnail!,
            title: authController.selectedCard.value.buyNow![index].title!,
            grade: authController.selectedCard.value.buyNow![index].grade!,
            listingType:
                authController.selectedCard.value.buyNow![index].listingType!,
            price: authController.selectedCard.value.buyNow![index].listPrice!
                .toString(),
            type: CardType.BUYNOW,
            recommendation: authController
                .selectedCard.value.buyNow![index].recommendation!,
            onPress: () {
              _launchURL(
                authController.selectedCard.value.buyNow![index].auctionUrl!,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TabThree extends StatelessWidget {
  TabThree({
    Key? key,
  }) : super(key: key);

  final AuthController authController = Get.find();

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          authController.selectedCard.value.recentSales!.length,
          (index) => CustomCardTwo(
            img: authController
                .selectedCard.value.recentSales![index].thumbnail!,
            title: authController.selectedCard.value.recentSales![index].title!,
            grade: authController.selectedCard.value.recentSales![index].grade!,
            listingType: authController
                .selectedCard.value.recentSales![index].listingType!,
            price: authController
                .selectedCard.value.recentSales![index].listPrice!
                .toString(),
            type: CardType.RECENTSALES,
            onPress: () async {
              _launchURL(
                authController
                    .selectedCard.value.recentSales![index].auctionUrl!,
              );
            },
            btnText: 'SEE DETAILS',
          ),
        ),
      ),
    );
  }
}

class TabOne extends StatelessWidget {
  TabOne({
    Key? key,
  }) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: defaultPadding),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: CachedNetworkImage(
              height: Get.height * .4,
              imageUrl: authController.selectedPlayer.value.imageUrl!,
              placeholder: (context, url) => Container(
                child: Center(child: CircularProgressIndicator()),
              ),
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => Icon(
                Icons.account_circle_rounded,
                size: 150,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          DetailWidget(
            text: 'Player Name',
            value: '${authController.selectedPlayer.value.playerName!}',
          ),
          DetailWidget(
            text: 'Sport',
            value: '${authController.selectedPlayer.value.sport!}',
          ),
          DetailWidget(
            text: 'Year',
            value: '${authController.selectedPlayer.value.setYear}',
          ),
          DetailWidget(
            text: 'Collection',
            value: '${authController.selectedPlayer.value.variation}',
          ),
          DetailWidget(
            text: 'Base / Insert',
            value: '${authController.selectedPlayer.value.rankScore!}',
          ),
        ],
      ),
    );
  }
}
