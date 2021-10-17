class PersonalInformation {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? telePhoneNumber;
  String? nationalCode;
  String? emailAddress;
  int? yearBirthDate;
  int? monthBirthDate;
  int? dayBirthDate;
  String? imageAddress;
  int? id;

  PersonalInformation({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.telePhoneNumber,
    this.nationalCode,
    this.emailAddress,
    this.yearBirthDate,
    this.monthBirthDate,
    this.dayBirthDate,
    this.imageAddress,
    this.id,
  });

  PersonalInformation.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    telePhoneNumber = json['telePhoneNumber'] ?? "";
    nationalCode = json['nationalCode'] ?? "";
    emailAddress = json['emailAddress'] ?? "";
    yearBirthDate = json['yearBirthDate'] ?? 0;
    monthBirthDate = json['monthBirthDate'] ?? 0;
    dayBirthDate = json['dayBirthDate'] ?? 0;
    imageAddress = json['imageAddress'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['telePhoneNumber'] = this.telePhoneNumber;
    data['nationalCode'] = this.nationalCode;
    data['emailAddress'] = this.emailAddress;
    data['yearBirthDate'] = this.yearBirthDate;
    data['monthBirthDate'] = this.monthBirthDate;
    data['dayBirthDate'] = this.dayBirthDate;
    data['imageAddress'] = this.imageAddress;
    data['id'] = this.id;
    return data;
  }

  List<PersonalInformation> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<PersonalInformation>((ct) {
        return PersonalInformation.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
