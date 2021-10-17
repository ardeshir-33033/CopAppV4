class EpcSubGroup {
  String? name;
  String? englishName;
  String? persianName;
  String ?code;
  int? parentId;
  String? imageName;
  String? imageUrl;
  String? page;
  String? href;
  int? id;
  String? createDm;
  String? createDs;

  EpcSubGroup(
      {this.name,
      this.englishName,
      this.persianName,
      this.parentId,
      this.imageName,
      this.imageUrl,
      this.page,
      this.href,
      this.id,
      this.code,
      this.createDm,
      this.createDs});

  EpcSubGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    englishName = json['englishName'];
    persianName = json['persianName'];
    parentId = json['parentId'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    page = json['page'];
    code = json['code'];
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
    data['parentId'] = this.parentId;
    data['imageName'] = this.imageName;
    data['imageUrl'] = this.imageUrl;
    data['page'] = this.page;
    data['code'] = this.code;
    data['href'] = this.href;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<EpcSubGroup>? toList(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EpcSubGroup>((ct) {
        return EpcSubGroup.fromJson(ct);
      }).toList();
    }
    return null;
  }
}
