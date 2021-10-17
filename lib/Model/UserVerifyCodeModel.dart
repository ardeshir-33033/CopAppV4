class userVerifyCodeModel {
  String? phoneNumber;
  String? code;

  userVerifyCodeModel({this.phoneNumber, this.code});

  userVerifyCodeModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['code'] = this.code;
    return data;
  }
}

class ValidationModel {
  String? phoneNumber;
  String? password;

  ValidationModel({this.phoneNumber, this.password});

  ValidationModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    return data;
  }
}
