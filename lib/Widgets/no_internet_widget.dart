import 'package:flutter/material.dart';

/// A no internet widget which will be shown if network connection is not
/// available.
class NoInternetWidget extends StatelessWidget {
  NoInternetWidget({Key? key}) : super(key: key);
  static const noInternetWidgetKey = Key('no-internet-widget-key');
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Internet',
                textAlign: TextAlign.center,
                // style: Styles.lightGrey14,
              ),
            ],
          ),
        ),
      );
}
