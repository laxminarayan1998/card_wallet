import 'package:card_walet/Screens/Login%20Screen/login_screen.dart';
import 'package:card_walet/Widgets/default_btn.dart';

import 'package:card_walet/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
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
                      child: TextField(
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
                      child: TextField(
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
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    labelText: 'Phone',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Passsword',
                    labelText: 'Passsword',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .05,
                ),
                DefaultButton(
                  color: Color(0xFF1643C4),
                  text: 'Sign Up',
                  onPress: () {},
                ),
                SizedBox(
                  height: Get.height * .05,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(LoginScreen());
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xff000000),
                          height: 1.7916666666666667,
                        ),
                        children: [
                          TextSpan(
                            text: 'Already have an account?',
                          ),
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: const Color(0xff919191),
                            ),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: const Color(0xff1643c4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
