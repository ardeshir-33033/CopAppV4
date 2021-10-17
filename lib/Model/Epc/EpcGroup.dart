class EpcGroup {
  String? name;
  String? englishName;
  String? persianName;
  String? imageName;
  String? imageUrl;
  int? modelSeriesId;
  String? page;
  String? href;
  int? id;
  String? createDm;
  String? createDs;

  EpcGroup(
      {this.name,
      this.englishName,
      this.persianName,
      this.imageName,
      this.imageUrl,
      this.modelSeriesId,
      this.page,
      this.href,
      this.id,
      this.createDm,
      this.createDs});

  EpcGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    englishName = json['englishName'];
    persianName = json['persianName'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    modelSeriesId = json['modelSeriesId'];
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
    data['imageName'] = this.imageName;
    data['imageUrl'] = this.imageUrl;
    data['modelSeriesId'] = this.modelSeriesId;
    data['page'] = this.page;
    data['href'] = this.href;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<EpcGroup>? toList(dynamic jsns) {
     if (jsns != null) {
      return jsns.map<EpcGroup>((ct) {
        return EpcGroup.fromJson(ct);
      }).toList();
    }
    return null;
  }
}
