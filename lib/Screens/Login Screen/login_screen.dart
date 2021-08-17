import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Widgets/default_btn.dart';
import 'package:card_walet/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final phoneTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: authController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          return !snapshot.data!
              ? SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Enter you credentials to continue',
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            CountryCodePicker(
                              onChanged: (code) {
                                authController.countryCode.value =
                                    code.dialCode!;
                              },
                              initialSelection: 'IN',
                              favorite: ['+91', 'IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter you phone number!';
                                    } else if (value.length < 10) {
                                      return 'Please enter 10-digit phone number!';
                                    }
                                  },
                                  controller: phoneTextController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Phone',
                                    hintStyle: TextStyle(fontSize: 12),
                                    prefixIcon: Icon(
                                      Icons.call,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        DefaultButton(
                          color: Color(0xFF1643C4),
                          text: 'Login',
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              print(authController.countryCode.value +
                                  ' ' +
                                  phoneTextController.text);
                              authController.phoneNo.value =
                                  phoneTextController.text;
                              authController.phoneSignIn(
                                  phoneNumber:
                                      authController.countryCode.value +
                                          phoneTextController.text);
                            }
                            // Get.to(() => HomeScreen());
                          },
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
