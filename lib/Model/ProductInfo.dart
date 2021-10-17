class ProductInfo {
  double? qty;
  double? price;
  double? sumSale;
  double? score;
  double? lastMarketPrice;
  bool? warranty;

  ProductInfo({
    this.qty,
    this.price,
    this.sumSale,
    this.score,
    this.warranty,
    this.lastMarketPrice,
  });

  ProductInfo.fromJson(Map<String, dynamic> json) {
    qty = json['qty'] ?? 0.0;
    price = json['price'] ?? 0.0;
    sumSale = json['sumSale'] ?? 0.0;
    score = json['score'] ?? 0.0;
    warranty = json['warranty'] ?? false;
    lastMarketPrice = json['lastMarketPrice'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['sumSale'] = this.sumSale;
    data['score'] = this.score;
    data['warranty'] = this.warranty;
    data['lastMarketPrice'] = this.lastMarketPrice;
    return data;
  }

  List<ProductInfo>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ProductInfo>((ct) {
        return ProductInfo.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
