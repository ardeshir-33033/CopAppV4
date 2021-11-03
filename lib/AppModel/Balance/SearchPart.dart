class SearchPart {
  String? partName;
  String? partNumber;
  String? categoriesName;
  String? vehicleId;
  String? keyWord;
  String? keywordsName;
  int? categoriesId;
  int? partId;
  int? keyWordId;

  SearchPart(
      {this.partName,
      this.partNumber,
      this.categoriesName,
      this.categoriesId,
      this.partId,
      this.vehicleId,
      this.keyWord,
      this.keyWordId,
      this.keywordsName});

  SearchPart.fromJson(Map<String, dynamic> json) {
    partName = json['partName'];
    partNumber = json['partNumber'];
    categoriesName = json['categoriesName'];
    categoriesId = json['categoriesId'];
    partId = json['partId'];
    vehicleId = json['vehicleId'];
    keyWord = json['keyWord'];
    keyWordId = json['keyWordId'];
    keywordsName = json['keywordsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partName'] = this.partName;
    data['partNumber'] = this.partNumber;
    data['categoriesName'] = this.categoriesName;
    data['categoriesId'] = this.categoriesId;
    data['partId'] = this.partId;
    data['vehicleId'] = this.vehicleId;
    data['keyWord'] = this.keyWord;
    data['keyWordId'] = this.keyWordId;
    data['keywordsName'] = this.keywordsName;
    return data;
  }

  List<SearchPart>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<SearchPart>((ct) {
        return SearchPart.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
