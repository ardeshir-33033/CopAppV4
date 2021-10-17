class Buyer {
  String? firstName;
  String? lastName;
  int? phoneNumberId;
  PhoneNumber? phoneNumber;
  String? telePhoneNumber;
  String? imageAddress;
  int? points;

  Buyer(
      {this.firstName,
        this.lastName,
        this.phoneNumberId,
        this.phoneNumber,
        this.telePhoneNumber,
        this.imageAddress,
        this.points});

  Buyer.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumberId = json['phoneNumberId'];
    phoneNumber = json['phoneNumber'] != null
        ? new PhoneNumber.fromJson(json['phoneNumber'])
        : null;
    telePhoneNumber = json['telePhoneNumber'];
    imageAddress = json['imageAddress'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumberId'] = this.phoneNumberId;
    if (this.phoneNumber != null) {
      data['phoneNumber'] = this.phoneNumber!.toJson();
    }
    data['telePhoneNumber'] = this.telePhoneNumber;
    data['imageAddress'] = this.imageAddress;
    data['points'] = this.points;
    return data;
  }
}
class PhoneNumber {
  String? phoneNumberTypeId;
  String? number;

  PhoneNumber({this.phoneNumberTypeId, this.number});

  PhoneNumber.fromJson(Map<String, dynamic> json) {
    phoneNumberTypeId = json['phoneNumberTypeId'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumberTypeId'] = this.phoneNumberTypeId;
    data['number'] = this.number;
    return data;
  }
}