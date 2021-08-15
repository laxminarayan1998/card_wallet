import 'package:card_walet/Widgets/no_internet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

abstract class Utility {
  static void showLog({Level? level = Level.wtf, dynamic msg}) {
    var logger = Logger();
    logger.log(level!, msg);
  }

  static void showToast({String msg = "Please wait..."}) {
    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      msg: msg,
      backgroundColor: Colors.black,
    );
  }

  static void printDLog(String message) {
    Logger().d('$message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printILog(String message) {
    Logger().i('$message');
  }

  /// Print error log.
  ///
  /// [message] : The message which needed to be print.
  static void printELog(String message) {
    Logger().e('$message');
  }

  /// Returns true if the internet connection is available.
  static Future<bool> isNetworkAvailable() async =>
      await InternetConnectionChecker().hasConnection;

  /// Show no internet dialog if there is no
  /// internet available.
  static void showNoInternetDialog() {
    closeDialog();
    Get.dialog<void>(
      NoInternetWidget(),
      barrierDismissible: false,
    );
  }

  /// Show loader
  static void showLoader() async {
    await Get.dialog(
      const Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }

  /// Close loader
  static void closeLoader() {
    closeDialog();
  }

  // /// Show error dialog from response model
  // static void showInfoDialog(ResponseModel data,
  //     [bool isSuccess = false]) async {
  //   await Get.dialog(
  //     CupertinoAlertDialog(
  //       title: Text(isSuccess ? 'SUCCESS' : 'ERROR'),
  //       content: Text(
  //         jsonDecode(data.data)['message'] as String,
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: Get.back,
  //           child: Text(
  //             'Okay',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }
}
