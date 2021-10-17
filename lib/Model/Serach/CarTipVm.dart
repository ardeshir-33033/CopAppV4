class CarTipVM {
  String? carTip;
  String? imagePath;
  String? englishName;
  bool? selected;

  CarTipVM({
    this.carTip,
    this.imagePath,
    this.englishName,
    this.selected,
  });

  CarTipVM.fromJson(Map<String, dynamic> json) {
    carTip = json['carTip'];
    imagePath = json['imagePath'];
    englishName = json['englishName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carTip'] = this.carTip;
    data['imagePath'] = this.imagePath;
    data['englishName'] = this.englishName;
    return data;
  }

  List<CarTipVM>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<CarTipVM>((ct) {
        return CarTipVM.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
