class NeshanAddress {
  String? status;
  String? neighbourhood;
  String? municipalityZone;
  String? state;
  String? city;
  bool? inTrafficZone;
  bool? inOddEvenZone;
  List<NeshanAddress>? addresses;
  String? routeName;
  String? routeType;
  String? formattedAddress;

  NeshanAddress(
      {this.status,
      this.neighbourhood,
      this.municipalityZone,
      this.state,
      this.city,
      this.inTrafficZone,
      this.inOddEvenZone,
      this.addresses,
      this.routeName,
      this.routeType,
      this.formattedAddress});

  NeshanAddress.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    neighbourhood = json['neighbourhood'];
    municipalityZone = json['municipality_zone'];
    state = json['state'];
    city = json['city'];
    inTrafficZone = json['in_traffic_zone'];
    inOddEvenZone = json['in_odd_even_zone'];
    if (json['addresses'] != null) {
    List<NeshanAddress>  addresses = [] ;
      json['addresses'].forEach((v) {
        addresses.add(new NeshanAddress.fromJson(v));
      });
    }
    routeName = json['route_name'];
    routeType = json['route_type'];
    formattedAddress = json['formatted_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['neighbourhood'] = this.neighbourhood;
    data['municipality_zone'] = this.municipalityZone;
    data['state'] = this.state;
    data['city'] = this.city;
    data['in_traffic_zone'] = this.inTrafficZone;
    data['in_odd_even_zone'] = this.inOddEvenZone;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['route_name'] = this.routeName;
    data['route_type'] = this.routeType;
    data['formatted_address'] = this.formattedAddress;
    return data;
  }
}
