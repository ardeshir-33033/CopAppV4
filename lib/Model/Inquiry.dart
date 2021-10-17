
import 'InquiryDetaili.dart';

class Inquiry {
  List<InquiryDetail>? inquiryDetails;
  double? decreasePrice;
  double? sumPrice;
  double? finalPrice;
  int? id;

  Inquiry({
    this.inquiryDetails,
    this.decreasePrice,
    this.sumPrice,
    this.finalPrice,
    this.id,
  });

  Inquiry.fromJson(Map<String, dynamic> json) {
    if (json['inquiryDetails'] != null) {
      inquiryDetails = [];
      json['inquiryDetails'].forEach((v) {
        inquiryDetails!.add(new InquiryDetail.fromJson(v));
      });
    }
    decreasePrice = json['decreasePrice'] ?? 0.0;
    sumPrice = json['sumPrice'] ?? 0.0;
    finalPrice = json['finalPrice'] ?? 0.0;
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inquiryDetails != null) {
      data['inquiryDetails'] =
          this.inquiryDetails!.map((v) => v.toJson()).toList();
    }
    data['decreasePrice'] = this.decreasePrice;
    data['sumPrice'] = this.sumPrice;
    data['finalPrice'] = this.finalPrice;
    data['id'] = this.id;
    return data;
  }
}
