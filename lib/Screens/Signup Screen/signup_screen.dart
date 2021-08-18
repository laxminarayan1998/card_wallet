import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Screens/Login%20Screen/login_screen.dart';
import 'package:card_walet/Widgets/default_btn.dart';

import 'package:card_walet/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({
    Key? key,
    this.phoneNumber,
    this.jwtToken,
  }) : super(key: key);

  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final String? phoneNumber;
  final String? jwtToken;

  @override
  Widget build(BuildContext context) {
    if (phoneNumber != null) phoneController.text = phoneNumber!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Text(
                    'Creat Account!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Text(
                    'Sign Up to get started',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return 'This field cannot be empty!';
                          },
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            labelText: 'First Name',
                            prefixIcon: Icon(
                              Icons.people,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return 'This field cannot be empty!';
                          },
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            labelText: 'Last Name',
                            prefixIcon: Icon(
                              Icons.people,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: (value) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!)) {
                        return null;
                      }
                      return 'Email format is wrong!';
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      }
                      return 'This field cannot be empty!';
                    },
                    readOnly: true,
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      labelText: 'Phone',
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  DefaultButton(
                    color: Color(0xFF1643C4),
                    text: 'Sign Up',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        authController.signUp(
                          phoneNumber: phoneNumber!,
                          jwtToken: jwtToken!,
                          email: emailController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
