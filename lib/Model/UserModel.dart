class UserModel {
  String? token;
  List<dynamic>? roles;
  String? refreshToken;
  UserDetails? userDetails;

  UserModel({this.token, this.roles, this.refreshToken, this.userDetails});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.token = json["token"];
    this.roles =
        json["roles"] == null ? null : List<dynamic>.from(json["roles"]);
    this.refreshToken = json["refreshToken"];
    this.userDetails = json["userDetails"] == null
        ? null
        : UserDetails.fromJson(json["userDetails"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["token"] = this.token;
    if (this.roles != null) data["roles"] = this.roles;
    data["refreshToken"] = this.refreshToken;
    if (this.userDetails != null)
      data["userDetails"] = this.userDetails?.toJson();
    return data;
  }
}

class UserDetails {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? countryCode;
  String? phoneNumber;
  String? profilePicture;
  String? userCode;
  bool? planEnd;

  UserDetails(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.countryCode,
      this.phoneNumber,
      this.profilePicture,
      this.userCode,
      this.planEnd});

  UserDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.email = json["email"];
    this.gender = json["gender"];
    this.countryCode = json["countryCode"];
    this.phoneNumber = json["phoneNumber"];
    this.profilePicture = json["profilePicture"];
    this.userCode = json["userCode"];
    this.planEnd = json["planEnd"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["firstName"] = this.firstName;
    data["lastName"] = this.lastName;
    data["email"] = this.email;
    data["gender"] = this.gender;
    data["countryCode"] = this.countryCode;
    data["phoneNumber"] = this.phoneNumber;
    data["profilePicture"] = this.profilePicture;
    data["userCode"] = this.userCode;
    data["planEnd"] = this.planEnd;
    return data;
  }
}
