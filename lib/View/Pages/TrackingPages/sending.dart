
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/TrackingPages/TrackingComponents/buy_card_widget.dart';
import 'package:copapp/View/Pages/TrackingPages/TrackingComponents/packing_card_widget.dart';
import 'package:flutter/material.dart';

import 'TrackingComponents/plate_widget.dart';


class Sending extends StatelessWidget {

  Sending({this.order});
  OrderHeader? order = OrderHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            PackingCard(
              title: 'اجناس شما حال ارسال است',
              detail: 'نوع پیک: وانت باری',
            ),
            BuyCard(
              top: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Text(
                      'مشخصات راننده پیک',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(0xff808285),
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ],
              ),
              bottomRight: 'سام مهرانی',
              bottomRightHeading: 'نام راننده',
              bottomLeft: '3198687683',
              bottomLeftHeading: 'شماره تلفن',
              center: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'نوع ماشین: پیکان وانت',
                        style: TextStyle(
                            color: Color(0xff808285),
                            fontSize: CBase().getTextfontSizeByScreen(),
                            fontFamily: 'Iransans'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'پلاک وسیله نقلیه :',
                          style: TextStyle(
                              color: Color(0xff808285),
                              fontSize:
                                  CBase().getTextfontSizeByScreen(),
                              fontFamily: 'Iransans'),
                        ),
                        PlateWidget(),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
