class EpcPartGroup {
  String? name;
  String? englishName;
  String? persianName;
  int? groupId;
  Group? group;
  String? url;
  String? href;
  String? imageName;
  String? imageUrl;
  String? partCategoryName;
  List<Parts>? parts;
  List<ImageCoordinates>? imageCoordinates;
  int? id;
  String? createDm;
  String? createDs;

  EpcPartGroup(
      {this.name,
      this.englishName,
      this.persianName,
      this.groupId,
      this.group,
      this.url,
      this.href,
      this.imageName,
      this.imageUrl,
      this.partCategoryName,
      this.parts,
      this.imageCoordinates,
      this.id,
      this.createDm,
      this.createDs});
  EpcPartGroup.instance(EpcPartGroup t,
      {List<ImageCoordinates>? imageCoord, List<Parts>? prts}) {
    this.name = t.name;
    this.englishName = t.englishName;
    this.persianName = t.persianName;
    this.groupId = t.groupId;
    this.group = t.group;
    this.url = t.url;
    this.href = t.href;
    this.imageName = t.imageName;
    this.imageUrl = t.imageUrl;
    this.partCategoryName = t.partCategoryName;
    if (prts == null)
      this.parts = t.parts;
    else
      this.parts = prts;
    if (imageCoord == null)
      this.imageCoordinates = t.imageCoordinates;
    else
      this.imageCoordinates = imageCoord;
    this.id = t.id;
    this.createDm = t.createDm;
    this.createDs = t.createDs;
  }

  EpcPartGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    englishName = json['englishName'];
    persianName = json['persianName'];
    groupId = json['groupId'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    url = json['url'];
    href = json['href'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    partCategoryName = json['partCategoryName'];
    if (json['parts'] != null) {
      parts = [];
      json['parts'].forEach((v) {
        parts!.add(new Parts.fromJson(v));
      });
    }
    if (json['imageCoordinates'] != null) {
      imageCoordinates = [];
      json['imageCoordinates'].forEach((v) {
        imageCoordinates!.add(new ImageCoordinates.fromJson(v));
      });
    }
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['persianName'] = this.persianName;
    data['groupId'] = this.groupId;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    data['url'] = this.url;
    data['href'] = this.href;
    data['imageName'] = this.imageName;
    data['imageUrl'] = this.imageUrl;
    data['partCategoryName'] = this.partCategoryName;
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    if (this.imageCoordinates != null) {
      data['imageCoordinates'] =
          this.imageCoordinates!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<EpcPartGroup>? toList(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<EpcPartGroup>((ct) {
        return EpcPartGroup.fromJson(ct);
      }).toList();
    }
    return null;
  }
}

class Group {
  String? name;
  String? englishName;
  String? persianName;
  int? parentId;
  String? imageName;
  String? imageUrl;
  List<PartCategoryValues>? partCategoryValues;
  String? page;
  String? href;
  int? id;
  String? createDm;
  String? createDs;

  Group(
      {this.name,
      this.englishName,
      this.persianName,
      this.parentId,
      this.imageName,
      this.imageUrl,
      this.partCategoryValues,
      this.page,
      this.href,
      this.id,
      this.createDm,
      this.createDs});

  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    englishName = json['englishName'];
    persianName = json['persianName'];
    parentId = json['parentId'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    if (json['partCategoryValues'] != null) {
      partCategoryValues =
          PartCategoryValues().toList(json['partCategoryValues']);
    }
    page = json['page'];
    href = json['href'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['persianName'] = this.persianName;
    data['parentId'] = this.parentId;
    data['imageName'] = this.imageName;
    data['imageUrl'] = this.imageUrl;
    if (this.partCategoryValues != null) {
      data['partCategoryValues'] =
          this.partCategoryValues!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['href'] = this.href;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }
}

class PartCategoryValues {
  String? name;
  String? value;
  int? groupId;
  int? id;
  String? createDm;
  String? createDs;

  PartCategoryValues(
      {this.name,
      this.value,
      this.groupId,
      this.id,
      this.createDm,
      this.createDs});

  PartCategoryValues.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    groupId = json['groupId'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['groupId'] = this.groupId;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<PartCategoryValues> toList(jsns) {
    if (jsns != null) {
      return jsns.map<PartCategoryValues>((ct) {
        return PartCategoryValues.fromJson(ct);
      }).toList();
    }
    return [];
  }
}

class Parts {
  String? persianName;
  String? englishName;
  String? name;
  int? code;
  String? partNumber;
  String? appliedModel;
  String? additionalinformation;
  String? quantity;
  int? partGroupId;
  int? id;
  String? createDm;
  String? createDs;

  Parts(
      {this.persianName,
      this.englishName,
      this.name,
      this.code,
      this.partNumber,
      this.appliedModel,
      this.additionalinformation,
      this.quantity,
      this.partGroupId,
      this.id,
      this.createDm,
      this.createDs});

  Parts.fromJson(Map<String, dynamic> json) {
    persianName = json['persianName'];
    englishName = json['englishName'];
    name = json['name'];
    code = json['code'];
    partNumber = json['partNumber'];
    appliedModel = json['appliedModel'];
    additionalinformation = json['additionalinformation'];
    quantity = json['quantity'].toString();
    partGroupId = json['partGroupId'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['persianName'] = this.persianName;
    data['englishName'] = this.englishName;
    data['name'] = this.name;
    data['code'] = this.code;
    data['partNumber'] = this.partNumber;
    data['appliedModel'] = this.appliedModel;
    data['additionalinformation'] = this.additionalinformation;
    data['quantity'] = this.quantity;
    data['partGroupId'] = this.partGroupId;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<Parts>? toList(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Parts>((ct) {
        return Parts.fromJson(ct);
      }).toList();
    }
    return null;
  }
}

class ImageCoordinates {
  int? code;
  int? srcTop;
  int? srcleft;
  int? srcwidth;
  int? srcheight;
  int? partGroupId;
  int? id;
  String? createDm;
  String? createDs;

  ImageCoordinates(
      {this.code,
      this.srcTop,
      this.srcleft,
      this.srcwidth,
      this.srcheight,
      this.partGroupId,
      this.id,
      this.createDm,
      this.createDs});

  ImageCoordinates.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    srcTop = json['srcTop'];
    srcleft = json['srcleft'];
    srcwidth = json['srcwidth'];
    srcheight = json['srcheight'];
    partGroupId = json['partGroupId'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['srcTop'] = this.srcTop;
    data['srcleft'] = this.srcleft;
    data['srcwidth'] = this.srcwidth;
    data['srcheight'] = this.srcheight;
    data['partGroupId'] = this.partGroupId;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    return data;
  }

  List<ImageCoordinates>? toList(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ImageCoordinates>((ct) {
        return ImageCoordinates.fromJson(ct);
      }).toList();
    }
    return null;
  }
}
