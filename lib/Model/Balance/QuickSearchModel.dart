class QuickSearchModel {
  int? id;
  String? tableName;
  String? search;
  String? categoriesName;
  String? categoriesId;
  int? keyWordId;
  String? keyWord;
  String? keywordsName;
  String? partNumber;

  QuickSearchModel(
      {this.id,
        this.tableName,
        this.search,
        this.categoriesName,
        this.categoriesId,
        this.keyWordId,
        this.keyWord,
        this.keywordsName,
        this.partNumber});

  QuickSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableName = json['tableName'];
    search = json['search'];
    categoriesName = json['categoriesName'];
    categoriesId = json['categoriesId'];
    keyWordId = json['keyWordId'];
    keyWord = json['keyWord'];
    keywordsName = json['keywordsName'];
    partNumber = json['partNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tableName'] = this.tableName;
    data['search'] = this.search;
    data['categoriesName'] = this.categoriesName;
    data['categoriesId'] = this.categoriesId;
    data['keyWordId'] = this.keyWordId;
    data['keyWord'] = this.keyWord;
    data['keywordsName'] = this.keywordsName;
    data['partNumber'] = this.partNumber;
    return data;
  }

  List<QuickSearchModel>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<QuickSearchModel>((ct) {
        return QuickSearchModel.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
