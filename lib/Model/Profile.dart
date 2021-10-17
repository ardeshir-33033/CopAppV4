

import 'Account.dart';
import 'Address.dart';
import 'CartHeader.dart';
import 'FavoriteProduct.dart';
import 'OrderHeader.dart';

class Profile {
  int? userId;
  String? firstName;
  String ?lastName;
  int ?phoneNumberId;
  String? phoneNumber;
  String ?telePhoneNumber;
  // PhoneNumber phoneNumber;
  String? nationalCode;
  String ?emailAddress;
  int? yearBirthDate;
  int? monthBirthDate;
  int? dayBirthDate;
   String ?imageAddress;
  int? points;
  String? bankCarNo;
  List<Address>? addresses;
  List<FavoriteProduct>? favoriteProducts;
  List<OrderHeader> ?orderHeaders;
  List<RCartHeader> ?cartHeaders;
  //Wallet wallet;
  Account? account;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  Profile(
      {this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumberId,
      this.phoneNumber,
      this.nationalCode,
      this.emailAddress,
      this.yearBirthDate,
      this.monthBirthDate,
      this.dayBirthDate,
      this.imageAddress = "",
      this.points,
      this.bankCarNo,
      this.addresses,
      this.favoriteProducts,
      this.orderHeaders,
      this.cartHeaders,
      //this.wallet,
      this.account,
      this.id,
      this.createDm,
      this.createDs,
      this.lastUpdateDm,
      this.lastUpdateDs,
      this.telePhoneNumber});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumberId = json['phoneNumberId'];
    phoneNumber = json['phoneNumber'];
    telePhoneNumber = json['telePhoneNumber'];
    // phoneNumber = json['phoneNumber'] != null
    //     ? PhoneNumber.fromJson(json['phoneNumber'])
    //     : null;
    nationalCode = json['nationalCode'];
    emailAddress = json['emailAddress'];
    yearBirthDate = json['yearBirthDate'];
    monthBirthDate = json['monthBirthDate'];
    dayBirthDate = json['dayBirthDate'];
    imageAddress = json['imageAddress'];
    points = json['points'];
    bankCarNo = json['bankCarNo'];
    if (json['addresses'] != null) {
     List<Address> addresses =[];
      json['addresses'].forEach((v) {
        addresses.add(Address.fromJson(v));
      });
    }
    if (json['favoriteProducts'] != null) {
     List<FavoriteProduct> favoriteProducts = [];
      json['favoriteProducts'].forEach((v) {
        favoriteProducts.add(FavoriteProduct.fromJson(v));
      });
    }
    if (json['orderHeaders'] != null) {
     List<OrderHeader> orderHeaders = [];
      json['orderHeaders'].forEach((v) {
        orderHeaders.add(OrderHeader.fromJson(v));
      });
    }
    if (json['cartHeaders'] != null) {
     List<RCartHeader> cartHeaders = [];
      json['cartHeaders'].forEach((v) {
        cartHeaders.add(RCartHeader.fromJson(v));
      });
    }
    //wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumberId'] = this.phoneNumberId;
    if (this.phoneNumber != null) {
      data['phoneNumber'] = this.phoneNumber;
    }
    data['telePhoneNumber'] = this.telePhoneNumber;
    data['nationalCode'] = this.nationalCode;
    data['emailAddress'] = this.emailAddress;
    data['yearBirthDate'] = this.yearBirthDate;
    data['monthBirthDate'] = this.monthBirthDate;
    data['dayBirthDate'] = this.dayBirthDate;
    data['imageAddress'] = this.imageAddress;
    data['points'] = this.points;
    data['bankCarNo'] = this.bankCarNo;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    if (this.favoriteProducts != null) {
      data['favoriteProducts'] =
          this.favoriteProducts!.map((v) => v.toJson()).toList();
    }
    if (this.orderHeaders != null) {
      data['orderHeaders'] = this.orderHeaders!.map((v) => v.toJson()).toList();
    }
    if (this.cartHeaders != null) {
      data['cartHeaders'] = this.cartHeaders!.map((v) => v.toJson()).toList();
    }
    //if (this.wallet != null) {
    //  data['wallet'] = this.wallet.toJson();
    //}
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<Profile> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Profile>((ct) {
        return Profile.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
