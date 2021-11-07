import 'package:copapp/Model/Order/OrderDetail.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class BottomCompleteBuying extends StatelessWidget {
  BottomCompleteBuying(
      {Key? key, this.pendingCart, this.orderId, required this.onTap})
      : super(key: key);
  final List<OrderDetail>? pendingCart;

  final int? orderId;
  final Function() onTap;

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
        onTap();
      },
    );
  }
}
