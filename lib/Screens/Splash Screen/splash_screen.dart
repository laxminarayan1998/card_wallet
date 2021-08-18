import 'dart:async';

import 'package:card_walet/Screens/Login%20Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () => Get.off(LoginScreen()));

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash 1000x2500.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              'THE CARD WALET',
              style: GoogleFonts.bebasNeue(
                fontSize: 42,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
