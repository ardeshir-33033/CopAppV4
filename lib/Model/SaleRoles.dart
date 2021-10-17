class SaleRoles {
  String? groupId;
  int? multipleQTY;
  SaleRoleType? saleRoleType;
  int? id;

  SaleRoles({this.groupId, this.multipleQTY, this.saleRoleType, this.id});

  SaleRoles.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    multipleQTY = json['multipleQTY'];
    saleRoleType = json['saleRoleType'] != null
        ? new SaleRoleType.fromJson(json['saleRoleType'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['multipleQTY'] = this.multipleQTY;
    if (this.saleRoleType != null) {
      data['saleRoleType'] = this.saleRoleType!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class SaleRoleType {
  String? value;
  int? id;

  SaleRoleType({this.value, this.id});

  SaleRoleType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['id'] = this.id;
    return data;
  }
}