import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/TrackingPages/TrackingComponents/buy_card_widget.dart';
import 'package:copapp/View/Pages/TrackingPages/TrackingComponents/packing_card_widget.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Packing extends StatelessWidget {
  Packing({this.order});

  OrderHeader? order = OrderHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          PackingCard(
            title: 'اجناس شما در حال بسته بندی است',
            detail: 'زمان اتمام بسته بندی اجناس 30 : 1 دقیقه',
          ),
          BuyCard(
            bottomRight: 'سام مهرانی',
            bottomLeft: '3198687683',
            bottomRightHeading: 'گیرنده',
            bottomLeftHeading: 'کد پستی',
            center: Padding(
              padding: EdgeInsets.all(20.0),
              child: Wrap(children: [
                Text(
                  '${order!.deliveryAddress}',
                  style: TextStyle(
                      color: Color(0xff808285),
                      fontSize: CBase().getTextfontSizeByScreen(),
                      fontFamily: 'Iransans'),
                ),
              ]),
            ),
            top: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  child: Text(
                    'نوع ارسال باربری',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color(0xff808285),
                        fontSize: CBase().getTextfontSizeByScreen(),
                        fontFamily: 'Iransans'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
