class Address {
  String? title;
  String? city;
  String? province;
  String? postalCode;
  String? receiverName;
  String? phoneNumber;
  String? mobileNumber;
  String? completeAddress;
  double? locationLat;
  double? locationLng;
  int? id;

  Address(
      {this.title,
      this.city,
      this.province,
      this.postalCode,
      this.receiverName,
      this.phoneNumber,
      this.mobileNumber,
      this.completeAddress,
      this.locationLat,
      this.locationLng,
      this.id});

  Address.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postalCode'];
    receiverName = json['receiverName'];
    phoneNumber = json['phoneNumber'];
    mobileNumber = json['mobileNumber'];
    completeAddress = json['completeAddress'];
    locationLat = json['locationLat'];
    locationLng = json['locationLng'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['city'] = this.city;
    data['province'] = this.province;
    data['postalCode'] = this.postalCode;
    data['receiverName'] = this.receiverName;
    data['phoneNumber'] = this.phoneNumber;
    data['mobileNumber'] = this.mobileNumber;
    data['completeAddress'] = this.completeAddress;
    data['locationLat'] = this.locationLat;
    data['locationLng'] = this.locationLng;
    data['id'] = this.id;
    return data;
  }

  List<Address> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Address>((ct) {
        return Address.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
