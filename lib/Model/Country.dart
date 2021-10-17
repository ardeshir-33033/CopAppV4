class Country {
  String name = "";
  int? id;

  Country({
    required this.name,
    this.id,
  });

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }

  List<Country>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Country>((ct) {
        return Country.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
