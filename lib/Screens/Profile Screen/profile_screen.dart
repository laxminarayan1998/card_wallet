import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Model/UserModel.dart';
import 'package:card_walet/Screens/Profile%20Screen/new.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  PickedFile? _imageFile;

  @override
  void initState() {
    super.initState();
    firstNameController.text =
        authController.appUser.value.userDetails!.firstName!;
    lastNameController.text =
        authController.appUser.value.userDetails!.lastName!;
    emailController.text = authController.appUser.value.userDetails!.email!;
    phoneController.text =
        authController.appUser.value.userDetails!.countryCode! +
            authController.appUser.value.userDetails!.phoneNumber!;
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: CustomBackButton(),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 140,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: (_imageFile != null)
                                ? Image.file(File(_imageFile!.path))
                                : CachedNetworkImage(
                                    imageUrl: authController.appUser.value
                                        .userDetails!.profilePicture!,
                                    placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator()),
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.account_circle_rounded,
                                      size: 150,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 90.0, left: 100.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 20.0,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Parsonal Information',
                                  style: TextStyle(
                                    fontSize: defaultPadding,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: TextFormField(
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
                            hintText: 'Email ID',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: TextFormField(
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
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Container(
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text("Save"),
                                textColor: Colors.white,
                                color: Colors.green,
                                onPressed: () async {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    await authController.updateUserData(
                                      UserDetails(
                                        countryCode: authController.appUser
                                            .value.userDetails!.countryCode,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        gender: authController
                                            .appUser.value.userDetails!.gender,
                                        id: authController
                                            .appUser.value.userDetails!.id,
                                        phoneNumber: authController.appUser
                                            .value.userDetails!.phoneNumber,
                                        planEnd: authController
                                            .appUser.value.userDetails!.planEnd,
                                        profilePicture: authController.appUser
                                            .value.userDetails!.profilePicture,
                                        userCode: authController.appUser.value
                                            .userDetails!.userCode,
                                      ),
                                    );
                                    if (_imageFile != null) {
                                      await authController.updateUserImg(
                                        selectedCardId: authController
                                            .appUser.value.userDetails!.id,
                                        filePath: _imageFile!.path,
                                      );
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
}
