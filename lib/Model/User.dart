
import 'package:copapp/Model/Chairs.dart';

class User {
  int? userType;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;
  String? fullName;
  int? age;
  String? gender;
  bool? isActive;
  int? salcustSi;
  String? salcustCu;
  String? salcustTp;
  String? avatar;
  String? lastLoginDate;
  String? nikName;
  String? validCode;
  String? validCodeExpired;
  bool? isPerson;
  // ProfileToken profile;
  // List<Contact> contacts;
  int? accountingUserReferenceId;
  int? id;
  String? userName;
  String? password;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  // bool emailConfirmed;
  List<Chairs>? chairs;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  String? lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;

  User(
      {this.userType,
        this.createDm,
        this.createDs,
        this.lastUpdateDm,
        this.lastUpdateDs,
        this.fullName,
        this.age,
        this.gender,
        this.isActive,
        this.salcustSi,
        this.salcustCu,
        this.salcustTp,
        this.avatar,
        this.chairs,
        this.lastLoginDate,
        this.nikName,
        this.validCode,
        this.validCodeExpired,
        this.isPerson,
        // this.profile,
        // this.contacts,
        this.accountingUserReferenceId,
        this.id,
        this.userName,
        this.normalizedUserName,
        this.email,
        this.normalizedEmail,
        // this.emailConfirmed,
        this.passwordHash,
        this.securityStamp,
        this.concurrencyStamp,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.twoFactorEnabled,
        this.lockoutEnd,
        this.lockoutEnabled,
        this.accessFailedCount});

  User.fromJson(Map<String, dynamic> json) {
    userType = json['userType'] ;
    createDm = json['createDm'] ?? "";
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
    fullName = json['fullName'] ?? "";
    age = json['age'] ?? 0;
    gender = json['gender'] ?? "";
    isActive = json['isActive'] ?? false;
    salcustSi = json['salcustSi'];
    salcustCu = json['salcustCu'];
    salcustTp = json['salcustTp'];
    avatar = json['avatar'] ?? "";
    lastLoginDate = json['lastLoginDate'];
    nikName = json['nikName'] ?? "";
    validCode = json['validCode'] ?? "";
    validCodeExpired = json['validCodeExpired'];
    isPerson = json['isPerson'] ?? false;
    // profile =
    // json['profile'] != null ? new ProfileToken.fromJson(json['profile']) : null;
    // if (json['contacts'] != null) {
    //   contacts = new List<Contact>();
    //   json['contacts'].forEach((v) {
    //     contacts.add(new Contact.fromJson(v));
    //   });
    // }
    accountingUserReferenceId = json['accountingUserReferenceId'];
    id = json['id'] ?? 0;
    userName = json['userName'] ?? "";
    normalizedUserName = json['normalizedUserName'] ?? "";
    email = json['email'] ?? "";
    normalizedEmail = json['normalizedEmail'] ?? "";
    // emailConfirmed = json['emailConfirmed'] ?? "";
    password = json['password'] ?? "";
    passwordHash = json['passwordHash'] ?? "";
    securityStamp = json['securityStamp'] ?? "";
    concurrencyStamp = json['concurrencyStamp'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    if (json['chairs'] != null) {
      chairs = [];
      json['chairs'].forEach((v) {
        chairs!.add(new Chairs.fromJson(v));
      });
    }
    // phoneNumberConfirmed = json['phoneNumberConfirmed'] ?? "";
    // twoFactorEnabled = json['twoFactorEnabled'] ?? false;
    // lockoutEnd = json['lockoutEnd'] ?? "";
    // lockoutEnabled = json['lockoutEnabled'] ?? "";
    // accessFailedCount = json['accessFailedCount'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userType'] = this.userType;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    data['fullName'] = this.fullName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['isActive'] = this.isActive;
    data['salcustSi'] = this.salcustSi;
    data['salcustCu'] = this.salcustCu;
    data['salcustTp'] = this.salcustTp;
    data['avatar'] = this.avatar;
    data['lastLoginDate'] = this.lastLoginDate;
    data['nikName'] = this.nikName;
    data['validCode'] = this.validCode;
    data['validCodeExpired'] = this.validCodeExpired;
    data['isPerson'] = this.isPerson;
    // if (this.profile != null) {
    //   data['profile'] = this.profile.toJson();
    // }
    // if (this.contacts != null) {
    //   data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    // }
    data['accountingUserReferenceId'] = this.accountingUserReferenceId;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['email'] = this.email;
    data['normalizedEmail'] = this.normalizedEmail;
    // data['emailConfirmed'] = this.emailConfirmed;
    data['password'] = this.password;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnd'] = this.lockoutEnd;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['accessFailedCount'] = this.accessFailedCount;
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
