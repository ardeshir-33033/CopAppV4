class Car {
  String? engName;
  String? imagePath;
  String? name;
  bool? selected;
  int? id;

  Car({this.engName, this.imagePath, this.name, this.selected, this.id});

  Car.fromJson(Map<String, dynamic> json) {
    engName = json['keyWord'] ?? "";
    imagePath = json['imagePath'] ?? "";
    name = json['name'] ?? "";
    selected = json['selected'] ?? false;
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyWord'] = this.engName;
    data['imagePath'] = this.imagePath;
    data['name'] = this.name;
    data['selected'] = this.selected;
    data['id'] = this.id;
    return data;
  }

  List<Car>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Car>((ct) {
        return Car.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
