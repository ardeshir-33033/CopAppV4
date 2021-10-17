class Keyword {
  String? keyWord;
  String? imagePath;
  String? name;
  bool? selected;
  int? id;

  Keyword({this.keyWord, this.imagePath, this.name, this.selected, this.id});

  Keyword.fromJson(Map<String, dynamic> json) {
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

  List<Keyword>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Keyword>((ct) {
        return Keyword.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
