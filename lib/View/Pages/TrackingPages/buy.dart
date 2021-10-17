
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/TrackingPages/TrackingComponents/buy_card_widget.dart';
import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'مشتری گرامی پرداخت شما با موفقیت انجام و تأیید شد.',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: CBase().getSubTitlefontSizeByScreen(),
                      color: Color(0xff51EBC1),fontFamily: 'Iransans'),
                ),
              ),
            ],
          ),
          BuyCard(
            bottomRight: 'سام مهرانی',
            bottomLeft: '3198687683',
            bottomRightHeading: 'گیرنده',
            bottomLeftHeading: 'کد پستی',
            phoneNumber: '09121121212',
            center: Padding(
              padding: EdgeInsets.all(20.0),
              child: Wrap(
                children:[
                  Text(
                      'آدرس: خوزستان، اهواز، اهواز کیانپارس خیابان میهن غربی فاز ۲ مجمتع سپید پلاک ۹۱/۲ واحد ۲، پلاک ۹۱/۲، واحد ۲',
                      style: TextStyle(
                          color: Color(0xff808285),
                          fontSize: CBase().getTextfontSizeByScreen(),fontFamily: 'Iransans'),
                    ),]
              ),
            ),
            top: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
