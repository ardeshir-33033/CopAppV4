class Chairs {
  int? userId;
  int? chairId;
  String? dateDm;
  String? dateDs;

  Chairs({this.userId, this.chairId, this.dateDm, this.dateDs});

  Chairs.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    chairId = json['chairId'];
    dateDm = json['dateDm'];
    dateDs = json['dateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['chairId'] = this.chairId;
    data['dateDm'] = this.dateDm;
    data['dateDs'] = this.dateDs;
    return data;
  }
}