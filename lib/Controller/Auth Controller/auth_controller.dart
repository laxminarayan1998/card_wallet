import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:card_walet/Model/PlayerDetail.dart';
import 'package:card_walet/Model/SportModel.dart';
import 'package:card_walet/Model/UserModel.dart';
import 'package:card_walet/Screens/Home%20Screen/home_screen.dart';
import 'package:card_walet/Screens/Login%20Screen/login_screen.dart';
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
  var playersList = <SportModel>[].obs;
  var selectedPlayer = SportModel().obs;
  var selectedSport = ''.obs;
  var totalCount = 0.obs;
  var selectedCard = PlayerDetailModel().obs;

  Future<void> updateUserImg({
    String? selectedCardId,
    String? filePath,
  }) async {
    var postUri =
        Uri.parse('http://3.108.157.65:3000//profile/image/$selectedCardId');
    var request = new http.MultipartRequest("POST", postUri);
    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
      'Authorization': authToken.value,
    };

    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
        'files',
        filePath!,
        contentType: new MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
        final result = json.decode(value) as Map<String, dynamic>;
        appUser.value = UserModel(
          userDetails: UserDetails(
            firstName: appUser.value.userDetails!.firstName,
            email: appUser.value.userDetails!.email,
            lastName: appUser.value.userDetails!.lastName,
            gender: appUser.value.userDetails!.gender,
            countryCode: appUser.value.userDetails!.countryCode,
            id: appUser.value.userDetails!.id,
            phoneNumber: appUser.value.userDetails!.phoneNumber,
            planEnd: appUser.value.userDetails!.planEnd,
            profilePicture: result['profilePicture'],
            userCode: appUser.value.userDetails!.userCode,
          ),
        );
        appUser.refresh();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getSportList({int? limit, int? skip}) async {
    final prefs = await SharedPreferences.getInstance();
    // playersList.clear();
    final uri = json.encode(
      {
        "offset": 0,
        "limit": limit!,
        "skip": skip!,
        "where": {
          "sport": selectedSport.value,
        }
      },
    );
    var encodedUrl = Uri.encodeFull(uri);
    final response = await _connectHelper.makeRequest(
      'player-list?filter=$encodedUrl',
      Request.GET,
      null,
      true,
      {
        'Content-Type': 'application/json',
        'Authorization': authToken.value,
      },
    );

    if (response.statusCode == 200) {
      final players = json.decode(response.body) as List;

      players.forEach((player) => playersList.add(SportModel.fromJson(player)));

      Utility.showLog(msg: players.length);
    } else if (response.statusCode == 401) {
      prefs.clear();
      Get.offAll(() => LoginScreen());
    }
  }

  Future<void> getSportListCount() async {
    final prefs = await SharedPreferences.getInstance();
    playersList.clear();
    final uri = json.encode(
      {
        "sport": selectedSport.value,
      },
    );
    var encodedUrl = Uri.encodeFull(uri);
    final response = await _connectHelper.makeRequest(
      'player-list/count?where=$encodedUrl',
      Request.GET,
      null,
      true,
      {
        'Content-Type': 'application/json',
        'Authorization': authToken.value,
      },
    );

    final res = json.decode(response.body);

    if (response.statusCode == 200) {
      totalCount.value = res['count'];
    } else if (response.statusCode == 401) {
      prefs.clear();
      Get.offAll(() => LoginScreen());
    }

    Utility.showLog(level: Level.warning, msg: totalCount.value);
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
    Get.offAll(() => LoginScreen());
  }

  Future<void> updateUserData(UserDetails user) async {
    final response = await _connectHelper.makeRequest(
      'update/user/${user.id}',
      Request.PATCH,
      {
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "gender": user.gender,
        "dob": 'N/A',
        "banned": true,
        "planEnd": true,
        "deviceId": ["string"]
      },
      true,
      {
        'Content-Type': 'application/json',
        'Authorization': authToken.value,
      },
    );

    final res = json.decode(response.body);

    Utility.showLog(msg: res);

    if (response.statusCode == 200) {
      appUser.value = UserModel(
        userDetails: UserDetails(
          firstName: user.firstName,
          email: user.email,
          lastName: user.lastName,
          gender: user.gender,
          countryCode: user.countryCode,
          id: user.id,
          phoneNumber: user.phoneNumber,
          planEnd: user.planEnd,
          profilePicture: user.profilePicture,
          userCode: user.userCode,
        ),
      );
      appUser.refresh();
      Get.back();
    } else if (response.statusCode == 401) {
      Get.offAll(() => LoginScreen());
    }
  }

  Future<bool> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final _code = prefs.getString('countryCode');
    final _phone = prefs.getString('phone');
    final _token = prefs.getString('token');
    final _uid = prefs.getString('uid');

    log('Code: $_code : Phone: $_phone : Token: $_token : Uid: $_uid');

    if (_token == null || _phone == null || _code == null || _uid == null) {
      return false;
    }

    authToken.value = _token;

    final response = await _connectHelper.makeRequest(
      'getUser/$_uid',
      Request.GET,
      null,
      true,
      {
        'Content-Type': 'application/json',
        'Authorization': _token,
      },
    );

    final result = json.decode(response.body) as Map<String, dynamic>;
    appUser.value = UserModel(userDetails: UserDetails.fromJson(result));
    Utility.showLog(msg: result);

    Get.offAll(() => HomeScreen());

    if (response.statusCode == 200) {
      return true;
    } else {
      prefs.clear();
      return false;
    }
  }

  Future<void> getCardDetaislsByID({String? selectedCardId}) async {
    final response = await _connectHelper.makeRequest(
      'player-details/$selectedCardId',
      Request.GET,
      null,
      true,
      {
        'Content-Type': 'application/json',
        'Authorization': authToken.value,
      },
    );

    final result = json.decode(response.body) as Map<String, dynamic>;

    selectedCard.value = PlayerDetailModel.fromJson(result);

    if (response.statusCode == 200) {
      // Get.back();
    } else if (response.statusCode == 401) {
      Get.offAll(() => LoginScreen());
    }
  }

  // Future<void> checkIfUserLoggedIn() async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     // final jwtToken = await user.getIdTokenResult();
  //     // _auth.signInWithCustomToken(token)
  //     final token = await user.getIdToken();
  //   }
  // }

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
        authToken.value = 'Bearer ${result['token']}';

        Utility.showLog(msg: result);
        log(result.toString());
        Utility.showLog(msg: 'UID : ${result['userDetails']['id']}');

        prefs.setString('countryCode', countryCode.value);
        prefs.setString('phone', phoneNo.value);
        prefs.setString('token', authToken.value);
        prefs.setString('uid', result['userDetails']['id']);

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
    final prefs = await SharedPreferences.getInstance();

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
    final result = json.decode(response.body) as Map<String, dynamic>;

    appUser.value = UserModel.fromJson(result);
    authToken.value = 'Bearer ${result['token']}';

    Utility.showLog(msg: result);

    prefs.setString('countryCode', countryCode.value);
    prefs.setString('phone', phoneNo.value);
    prefs.setString('token', authToken.value);
    prefs.setString('uid', authToken.value);

    Get.offAll(() => HomeScreen());
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
