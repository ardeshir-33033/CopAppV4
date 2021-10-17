class RKeyword {
  String? keyWord;
  String? imagePath;
  String? name;
  bool? selected;
  int? id;

  RKeyword({this.keyWord, this.imagePath, this.name, this.selected, this.id});

  RKeyword.fromJson(Map<String, dynamic> json) {
    keyWord = json['keyWord'] ?? "";
    imagePath = json['imagePath'] ?? "";
    name = json['name'] ?? "";
    selected = json['selected'] ?? false;
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyWord'] = this.keyWord;
    data['imagePath'] = this.imagePath;
    data['name'] = this.name;
    data['selected'] = this.selected;
    data['id'] = this.id;
    return data;
  }

  List<RKeyword>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<RKeyword>((ct) {
        return RKeyword.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
