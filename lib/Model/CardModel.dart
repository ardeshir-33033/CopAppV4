class CardModel {
  int? profileId;
  String? cartNo;
  String? accountNumber;
  String? bank;
  String? irAccount;
  int? id;

  CardModel(
      {this.profileId,
        this.cartNo,
        this.accountNumber,
        this.bank,
        this.irAccount,
        this.id});

  CardModel.fromJson(Map<String, dynamic> json) {
    profileId = json['profileId'];
    cartNo = json['cartNo'];
    accountNumber = json['accountNumber'];
    bank = json['bank'];
    irAccount = json['irAccount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = this.profileId;
    data['cartNo'] = this.cartNo;
    data['accountNumber'] = this.accountNumber;
    data['bank'] = this.bank;
    data['irAccount'] = this.irAccount;
    data['id'] = this.id;
    return data;
  }
}