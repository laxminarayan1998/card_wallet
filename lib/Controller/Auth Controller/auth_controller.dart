import 'dart:convert';
import 'dart:developer';

import 'package:card_walet/Screens/OTP%20Screen/otp_screen.dart';
import 'package:card_walet/Screens/Signup%20Screen/signup_screen.dart';
import 'package:card_walet/Services/connect_helper.dart';
import 'package:card_walet/Utility/enums.dart';
import 'package:card_walet/Utility/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _connectHelper = ConnectHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var countryCode = '+91'.obs;
  var phoneNo = ''.obs;
  String? verificationId;

  void signIn(String? smsCode) {
    Utility.showLoader();

    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode!,
    );

    _auth.signInWithCredential(credential).then((user) async {
      final jwtToken = await user.user!.getIdToken();

      final response = await _connectHelper.makeRequest(
        'check/exists',
        Request.POST,
        {
          "countryCode": countryCode.value,
          "phoneNumber": phoneNo.value,
          "token": jwtToken
        },
        true,
        {
          'Content-Type': 'application/json',
        },
      );
      Utility.showLog(msg: response.body);
      final result = json.decode(response.body) as Map<String, dynamic>;

      if (result['newUser'] == false) {
        final response = await _connectHelper.makeRequest(
          'login',
          Request.POST,
          {
            "countryCode": countryCode.value,
            "phoneNumber": phoneNo.value,
            "token": jwtToken
          },
          true,
          {
            'Content-Type': 'application/json',
          },
        );
        Utility.showLog(msg: response.body);
        final result = json.decode(response.body) as Map<String, dynamic>;
        Utility.showLog(msg: result);
      } else {
        Get.to(() => SignupScreen());
        // final response = await _connectHelper.makeRequest(
        //   'signUp',
        //   Request.POST,
        //   {
        //     "firstName": "string",
        //     "lastName": "string",
        //     "email": "string@gmail.com",
        //     "phoneNumber": "9776229989",
        //     "countryCode": "+91",
        //     "gender": "male"
        //   },
        //   true,
        //   {
        //     'Content-Type': 'application/json',
        //     'token': jwtToken,
        //   },
        // );
        // Utility.showLog(msg: response.body);
        // final result = json.decode(response.body) as Map<String, dynamic>;
        // Utility.showLog(msg: result);
      }
    }).catchError((e) {
      Utility.closeLoader();
      Utility.showLog(msg: e);
    });
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    Utility.showLoader();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
      timeout: Duration(seconds: 30),
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    if (authCredential.smsCode != null) {
      Utility.printILog(authCredential.smsCode!);
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
          Utility.showToast(msg: e.code);
          Utility.closeLoader();
        }
      }
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      Utility.printILog("The phone number entered is invalid!");
      Utility.showToast(msg: 'The phone number entered is invalid!');
      Utility.closeLoader();
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    Utility.closeLoader();
    Get.to(() => OtpScreen());
  }

  _onCodeTimeout(String timeout) {
    // Utility.showToast(msg: 'Time out');
    // Utility.closeLoader();
    return null;
  }
}
