import 'dart:convert';
import 'dart:developer';

import 'package:card_walet/Model/UserModel.dart';
import 'package:card_walet/Screens/Home%20Screen/home_screen.dart';
import 'package:card_walet/Screens/OTP%20Screen/otp_screen.dart';
import 'package:card_walet/Screens/Signup%20Screen/signup_screen.dart';
import 'package:card_walet/Services/connect_helper.dart';
import 'package:card_walet/Utility/enums.dart';
import 'package:card_walet/Utility/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final _connectHelper = ConnectHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var countryCode = '+91'.obs;
  var phoneNo = ''.obs;
  String? verificationId;
  var appUser = UserModel().obs;
  var authToken = ''.obs;

  Future<void> getSportList(String? sport) async {
    final uri = json.encode({
      "offset": 0,
      "limit": 100,
      "skip": 0,
      "order": "string",
      "where": {"additionalProp1": {}},
      "fields": {
        "active": true,
        "deleted": true,
        "updatedAt": true,
        "createdAt": true,
        "id": true,
        "global_rank": true,
        "rank_score": true,
        "sport_rank": true,
        "player_id": true,
        "player_name": true,
        "set_id": true,
        "set_name": true,
        "set_year": true,
        "variation": true,
        "variation_id": true,
        "sport": true,
        "image_url": true,
        "price_score": true,
        "trend": true,
        "excluded": true
      }
    });
    var encodedUrl = Uri.encodeFull(uri);
    final response = await _connectHelper.makeRequest(
      'player-list?filter?=$encodedUrl',
      Request.GET,
      null,
      true,
      {
        'Content-Type': 'application/json',
        'Authorization': authToken.value,
      },
    );

    log(response.body);
  }

  Future<bool> getUserData() async {
    // Utility.showLoader();
    final prefs = await SharedPreferences.getInstance();
    final _code = prefs.getString('countryCode');
    final _phone = prefs.getString('phone');
    final _token = prefs.getString('token');

    if (_token!.isEmpty || _phone!.isEmpty || _code!.isEmpty) {
      return false;
    }

    final response = await _connectHelper.makeRequest(
      'login',
      Request.POST,
      {
        "countryCode": _code,
        "phoneNumber": _phone,
        "token": _token,
      },
      true,
      {
        'Content-Type': 'application/json',
      },
    );

    final result = json.decode(response.body) as Map<String, dynamic>;
    appUser.value = UserModel.fromJson(result);
    Utility.showLog(msg: result);

    if (response.statusCode == 200) {
      authToken.value = 'Bearer ${result['token']}';
      Get.offAll(() => HomeScreen());
      return true;
    } else {
      prefs.clear();
      return false;
    }
  }

  Future<void> checkIfUserLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final jwtToken = await user.getIdTokenResult();
      // _auth.signInWithCustomToken(token)
      final token = await user.getIdToken();
      log(token);
      print(user.toString());
    }
  }

  void signIn(String? smsCode) async {
    final prefs = await SharedPreferences.getInstance();

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
      final result = json.decode(response.body) as Map<String, dynamic>;

      Utility.showLog(msg: jwtToken);

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

        final result = json.decode(response.body) as Map<String, dynamic>;
        appUser.value = UserModel.fromJson(result);
        Utility.showLog(msg: result);

        prefs.setString('countryCode', countryCode.value);
        prefs.setString('phone', phoneNo.value);
        prefs.setString('token', jwtToken);

        authToken.value = 'Bearer ${result['token']}';
        Get.offAll(() => HomeScreen());
      } else {
        Utility.showLog(msg: jwtToken);
        Get.to(
          () => SignupScreen(
            phoneNumber: countryCode.value + phoneNo.value,
            jwtToken: jwtToken,
          ),
        );
      }
    }).catchError((e) {
      Utility.closeLoader();
      Utility.showLog(msg: e);
      Utility.showToast(msg: 'OTP wrong');
    });
  }

  Future<void> signUp({
    required String phoneNumber,
    required String jwtToken,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
  }) async {
    print(phoneNumber);
    print(jwtToken);
    print(firstName);
    print(lastName);
    print(countryCode);
    print(email);
    print(gender);
    final response = await _connectHelper.makeRequest(
      'signUp',
      Request.POST,
      {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNo.value,
        "countryCode": countryCode.value,
        "gender": "male"
      },
      true,
      {
        'Content-Type': 'application/json',
        'token': jwtToken,
      },
    );
    Utility.showLog(msg: response.body);
    final result = json.decode(response.body) as Map<String, dynamic>;
    Utility.showLog(msg: result);
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
