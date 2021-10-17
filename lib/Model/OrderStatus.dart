class OrderStatus {
  String? description;
  String? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  OrderStatus({
    this.description,
    this.id,
    this.createDm,
    this.createDs,
    this.lastUpdateDm,
    this.lastUpdateDs,
  });

  OrderStatus.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? "";
    id = json['id'] ?? 0;
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<OrderStatus> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<OrderStatus>((ct) {
        return OrderStatus.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
