class Account {
  int? profileId;
  String? cartNo;
  String? accountNumber;
  String? bank;
  String? irAccount;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  Account(
      {this.profileId,
      this.cartNo,
      this.accountNumber,
      this.bank,
      this.irAccount,
      this.id,
      this.createDm,
      this.createDs,
      this.lastUpdateDm,
      this.lastUpdateDs});

  Account.fromJson(Map<String, dynamic> json) {
    profileId = json['profileId'] ?? 0;
    cartNo = json['cartNo'] ?? "";
    accountNumber = json['accountNumber'] ?? "";
    bank = json['bank'] ?? "";
    irAccount = json['irAccount'] ?? "";
    id = json['id'] ?? 0;
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = this.profileId;
    data['cartNo'] = this.cartNo;
    data['accountNumber'] = this.accountNumber;
    data['bank'] = this.bank;
    data['irAccount'] = this.irAccount;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<Account> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Account>((ct) {
        return Account.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
