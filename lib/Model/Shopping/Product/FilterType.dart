class FilterType {
  String? name;
  int? id;

  FilterType({
    this.name,
    this.id,
  });

  FilterType.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }

  List<FilterType>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<FilterType>((ct) {
        return FilterType.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
