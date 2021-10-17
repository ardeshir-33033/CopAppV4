import 'Cart.dart';
import 'Inquiry.dart';

class RCartHeader {
  RCart? cart;
  Inquiry? inquiry;

  RCartHeader({this.cart, this.inquiry});

  RCartHeader.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new RCart.fromJson(json['cart']) : null;
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
