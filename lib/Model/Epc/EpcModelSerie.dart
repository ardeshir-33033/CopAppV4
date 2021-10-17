class EpcModelSerie {
  String? name;
  String? englishName;
  String? persianName;
   String? image;
  int? modelId;
  String? page;
  String? href;
  int? id;
  String? createDm;
  String? createDs;

  EpcModelSerie(
      {this.name,
      this.englishName,
      this.persianName,
      this.modelId,
      this.page,
      this.href,
      this.image,
      this.id,
      this.createDm,
      this.createDs});

  EpcModelSerie.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    englishName = json['englishName'];
    persianName = json['persianName'];
    image = json['image'];
    modelId = json['modelId'];
    page = json['page'];
    href = json['href'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['persianName'] = this.persianName;
    data['image'] = this.image;
    data['modelId'] = this.modelId;
    data['page'] = this.page;
    data['href'] = this.href;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<EpcModelSerie>? toList(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EpcModelSerie>((ct) {
        return EpcModelSerie.fromJson(ct);
      }).toList();
    }
    return null;
  }
}
