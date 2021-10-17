

class Destinations {
  String? name;
  String? persianName;
  int? provinceNameId;
  // ProvinceName provinceName;
  String? location;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  Destinations(
      {this.name,
        this.persianName,
        this.provinceNameId,
        // this.provinceName,
        this.location,
        this.id,
        this.createDm,
        this.createDs,
        this.lastUpdateDm,
        this.lastUpdateDs});

  Destinations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    persianName = json['persianName'];
    provinceNameId = json['provinceNameId'];
    // provinceName = json['provinceName'];
    location = json['location'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['persianName'] = this.persianName;
    data['provinceNameId'] = this.provinceNameId;
    // data['provinceName'] = this.provinceName;
    data['location'] = this.location;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }
}