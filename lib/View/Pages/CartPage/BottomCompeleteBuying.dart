import 'package:copapp/Controller/Controllers/InvoiceController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Model/Order/OrderDetail.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/InvoicePage/InvoicePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomCompeleteBuying extends StatelessWidget {
  BottomCompeleteBuying({
    this.type = 2,
    Key? key,
    this.pendingCart,
    this.orderId
  }) : super(key: key);
  List<OrderDetail>? pendingCart;
  int type = 2;
int? orderId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: CBase().getFullHeight(context) / 12,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تکمیل خرید",
              style: TextStyle(
                fontSize: CBase().getLargefontSizeByScreen(),
                fontFamily: CBase().fontFamily,
                color: Color(0xffff0000),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        InvoiceController invoiceController = Get.put(InvoiceController());
        if (type == 1) {
          invoiceController.cart =
              CartServiceV2().getMyCart()!.details!;
          invoiceController.orderId = null;
        } else {
          invoiceController.cart = OrderDetail().toCartDetail(pendingCart!)!;
          invoiceController.orderId = orderId;
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InvoicePage()));
      },
    );
  }
}
