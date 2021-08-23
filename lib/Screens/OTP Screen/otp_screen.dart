import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Utility/utils.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/Widgets/default_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  final otpController = TextEditingController();

  Future<String?> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "123456") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    // Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => SuccessfulOtpScreen()));
  }

  void onSmsDone(String code) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'OTP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: CustomBackButton(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Phone Number Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Obx(() => Text(
                  'Enter your code sent to ${authController.countryCode} ${authController.phoneNo}')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: PinCodeTextField(
              controller: otpController,
              appContext: context,
              length: 6,
              obscureText: false,
              obscuringCharacter: '*',
              animationType: AnimationType.none,
              validator: (v) {},
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 60,
                fieldWidth: 50,
                inactiveFillColor: Colors.transparent,
                selectedFillColor: Colors.amber.withOpacity(.5),
                activeFillColor: Colors.white,
                activeColor: Colors.black12,
                disabledColor: Colors.black12,
                inactiveColor: Colors.black12,
                selectedColor: Colors.black12,
                errorBorderColor: Colors.red,
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              textStyle: TextStyle(fontSize: 20, height: 1.6),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              // onCompleted: (v) {
              //   print(v);
              // },
              onChanged: (value) {},
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              print(authController.countryCode.value +
                  authController.phoneNo.value);
              authController.phoneSignIn(
                  phoneNumber: authController.countryCode.value +
                      authController.phoneNo.value);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Didn\'t receive the code?'),
                Text(
                  ' RESEND',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: DefaultButton(
              color: mainColor,
              onPress: () {
                if (otpController.text.isNotEmpty) {
                  if (otpController.text.length == 6) {
                    authController.signIn(otpController.text);
                  } else {
                    Utility.showToast(msg: 'Fill the OTP field');
                  }
                }
              },
              text: 'VERIFY',
            ),
          )
        ],
      ),
    );
  }
}
