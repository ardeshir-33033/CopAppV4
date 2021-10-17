

import 'Cart.dart';
import 'Inquiry.dart';

class CartHeader {
  Cart? cart;
  Inquiry? inquiry;

  CartHeader({this.cart, this.inquiry});

  CartHeader.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    inquiry = json['inquiry'] != null ? new Inquiry.fromJson(json['inquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    if (this.inquiry != null) {
      data['inquiry'] = this.inquiry!.toJson();
    }
    return data;
  }
}
