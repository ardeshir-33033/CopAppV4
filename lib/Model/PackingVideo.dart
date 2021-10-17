class PackingVideo {
  int? orderId;
  String? path;
  int? duration;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  PackingVideo({
    this.orderId,
    this.path,
    this.duration,
    this.id,
    this.createDm,
    this.createDs,
    this.lastUpdateDm,
    this.lastUpdateDs,
  });

  PackingVideo.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'] ?? 0;
    path = json['path'] ?? "";
    duration = json['duration'] ?? 0;
    id = json['id'] ?? 0;
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['path'] = this.path;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<PackingVideo> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<PackingVideo>((ct) {
        return PackingVideo.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
