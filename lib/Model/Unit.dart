class Unit {
  String? name;
  int? id;

  Unit({
    this.name,
    this.id,
  });

  Unit.fromJson(dynamic jsn) {
    this.id = jsn["id"] != null ? int.parse(jsn["id"].toString()) : 0;
    this.name = jsn["name"] ?? "";
  }

  List<Unit>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Unit>((ct) {
        return Unit.fromJson(ct);
      }).toList();
    }

    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data["name"] = this.name;

    return data;
  }
}
