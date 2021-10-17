import 'JwtSecurityToken.dart';
import 'User.dart';

class AuthModel {
  JwtSecurityToken? jwt;
  User? user;

  AuthModel({
    this.jwt,
    this.user,
  });

  AuthModel fromJson(dynamic jsn) {
    this.jwt = JwtSecurityToken.fromJson(jsn["jwt"]);
    this.user = User.fromJson(jsn["user"]);

    return this;
  }

  Map<String, dynamic> toJson() => {
    'jwt': jwt!.toJson(),
    'user': user!.toJson(),
  };
}
