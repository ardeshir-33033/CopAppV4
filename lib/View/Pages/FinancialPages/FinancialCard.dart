import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/FinancialPages/OrderNumberWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'CustomInfoWidget.dart';
import 'DoubleWidgetDivider.dart';
import 'VerticalDoubleDivider.dart';

class FinancialCard extends StatelessWidget {
  final int paymentStatus;
  final bool isPaidCommision;
  final String? orderCode,
      orderNumber,
      price,
      points,
      imageTop,
      imageBottom,
      dateBottom,
      dateTop;

  const FinancialCard(
      {Key? key,
      required this.paymentStatus,
      this.orderCode,
      this.orderNumber,
      this.price,
      this.points,
      this.imageTop,
      this.imageBottom,
      this.dateBottom,
      this.dateTop,
      required this.isPaidCommision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.13,
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: OrderNumberWidget(
                  mainCenter: false,
                  top: (orderCode!.toPersianDigit()),
                  main: (orderNumber!.toPersianDigit()),
                  rotated: 'سفارش',
                  topSize: CBase().getTextfontSizeByScreen() * 0.8,
                  rotatedSize: CBase().getTextfontSizeByScreen() * 0.8,
                  mainSize: CBase().getTextfontSizeByScreen() * 0.7,
                  mainColor: paymentStatus == 0
                      ? Color(0xff07B413)
                      : Color(0xffEB5151),
                ),
              ),
              flex: 9,
            ),
            VerticalDoubleDivider(
              color: Color(0xffB3B3B3),
            ),
            Expanded(
              child: Container(
                child: DoubleWidgetDivider(
                  bottom: Container(
                    // width: CBase().getFullWidth(context) / 2,
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: customInfoWidget(
                      main: (price!.toPersianDigit()),
                      mainColor: CBase().textPrimaryColor,
                      mainCenter: true,
                      rotated: 'مبلغ',
                      mainSize: CBase().getTextfontSizeByScreen(),
                      rotatedSize: CBase().getTextfontSizeByScreen() * 0.8,
                    ),
                  ),
                  top: Container(
                    // width: 60,
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: customInfoWidget(
                      main: (points!.toPersianDigit()),
                      mainColor: CBase().textPrimaryColor,
                      mainCenter: true,
                      rotated: 'امتیاز',
                      mainSize: CBase().getTextfontSizeByScreen(),
                      rotatedSize: CBase().getTextfontSizeByScreen() * 0.8,
                    ),
                  ),
                  dividerColor: Color(0xffB3B3B3),
                ),
              ),
              flex: 10,
            ),
            VerticalDoubleDivider(
              color: Color(0xffB3B3B3),
            ),
            Expanded(
              child: Container(
                child: DoubleWidgetDivider(
                  bottom: Container(
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: Image.asset(
                      imageBottom!,
                    ),
                  ),
                  top: Container(
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: SvgPicture.asset(
                      imageTop!,
                    ),
                  ),
                  dividerColor: Color(0xffB3B3B3),
                ),
              ),
              flex: 6,
            ),
            VerticalDoubleDivider(
              color: Color(0xffB3B3B3),
            ),
            Expanded(
              child: Container(
                child: DoubleWidgetDivider(
                  bottom: Container(
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: customInfoWidget(
                      main: paymentStatus == 0
                          ? 'تسویه'
                          : paymentStatus == 1
                              ? 'انتظار پرداخت'
                              : paymentStatus == 2
                                  ? 'لغو شده'
                                  : paymentStatus == 3
                                      ? 'مرجوعی'
                                      : paymentStatus == 4
                                          ? 'ناموفق'
                                          : '',
                      mainColor: paymentStatus == 0
                          ? Color(0xff07B413)
                          : Color(0xffEB5151),
                      mainCenter: true,
                      mainSize: CBase().getTextfontSizeByScreen() * 0.8,
                    ),
                  ),
                  top: Container(
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: customInfoWidget(
                      main: isPaidCommision ? 'تسویه' : 'انتظار پرداخت',
                      mainColor: isPaidCommision
                          ? Color(0xff07B413)
                          : Color(0xffEB5151),
                      mainCenter: true,
                      mainSize: CBase().getTextfontSizeByScreen() * 0.8,
                    ),
                  ),
                  dividerColor: Color(0xffB3B3B3),
                ),
              ),
              flex: 8,
            ),
            VerticalDoubleDivider(
              color: Color(0xffB3B3B3),
            ),
            Expanded(
              child: Container(
                child: DoubleWidgetDivider(
                  bottom: Container(
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: customInfoWidget(
                      main: dateBottom!,
                      mainColor: Color(0xff707070),
                      mainCenter: true,
                      mainSize: CBase().getTextfontSizeByScreen(),
                    ),
                  ),
                  top: Container(
                    height: MediaQuery.of(context).size.height * 0.065 - 5.5,
                    child: customInfoWidget(
                      main: dateTop!,
                      mainColor: Color(0xff707070),
                      mainCenter: true,
                      mainSize: CBase().getTextfontSizeByScreen(),
                    ),
                  ),
                  dividerColor: Color(0xffB3B3B3),
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
