import 'package:copapp/Model/Chairs.dart';

class User {
  String? fullName;
  int? id;
  String? userName;
  String? password;
  List<Chairs>? chairs;

  User({
    this.fullName,
    this.chairs,
    this.id,
    this.userName,
  });

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] ?? "";
    id = json['id'] ?? 0;
    userName = json['userName'] ?? "";
    password = json['password'] ?? "";
    if (json['chairs'] != null) {
      chairs = [];
      json['chairs'].forEach((v) {
        chairs!.add(new Chairs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['password'] = this.password;
    if (this.chairs != null) {
      data['chairs'] = this.chairs!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<User>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<User>((ct) {
        return User.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
