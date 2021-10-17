class ProvinceCities {
  String? name;
  String? persianName;
  int? provinceNameId;
  String? location;
  int? id;

  ProvinceCities(
      {this.name,
      this.persianName,
      this.provinceNameId,
      this.location,
      this.id});

  ProvinceCities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    persianName = json['persianName'];
    provinceNameId = json['provinceNameId'];
    location = json['location'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['persianName'] = this.persianName;
    data['provinceNameId'] = this.provinceNameId;
    data['location'] = this.location;
    data['id'] = this.id;
    return data;
  }
  List<ProvinceCities> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ProvinceCities>((ct) {
        return ProvinceCities.fromJson(ct);
      }).toList();
    }

    return [];
  }
}