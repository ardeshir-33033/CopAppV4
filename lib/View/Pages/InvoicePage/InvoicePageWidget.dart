import 'package:copapp/AppModel/Cart/CartDetail.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

// ignore: must_be_immutable
class InvoiceWidget extends StatelessWidget {
  InvoiceWidget({this.item, this.id});

  CartDetail? item = CartDetail();
  final int? id;

  final NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: CBase().getFullHeight(context) / 18,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    ('$id').toPersianDigit(),
                    style: TextStyle(
                      fontSize: CBase().getTitlefontSizeByScreen(),
                      color: CBase().textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 4.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: VerticalDivider(
                  color: CBase().borderPrimaryColor,
                  width: 1,
                ),
              ),
              SizedBox(
                width: 4.5,
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${item?.product?.productsName}",
                      style: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen() + 1,
                        color: CBase().textPrimaryColor,
                        letterSpacing: -0.065,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 4.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: VerticalDivider(
                  color: CBase().borderPrimaryColor,
                  width: 1,
                ),
              ),
              SizedBox(
                width: 4.5,
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    item!.product!.detailQTY!.toInt().toString().toPersianDigit(),
                    style: TextStyle(
                      fontSize: CBase().getTitlefontSizeByScreen(),
                      color: CBase().textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: 4.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: VerticalDivider(
                  color: CBase().borderPrimaryColor,
                  width: 1,
                ),
              ),
              SizedBox(
                width: 4.5,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  nf.format(item!.detailFinalPrice!).toString(),
                  style: TextStyle(
                    fontSize: CBase().getTitlefontSizeByScreen(),
                    color: CBase().textPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Divider(
                  color: CBase().borderPrimaryColor,
                  height: 1,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 8,
                child: Divider(
                  color: CBase().borderPrimaryColor,
                  height: 1,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: Divider(
                  color: CBase().borderPrimaryColor,
                  height: 1,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 4,
                child: Divider(
                  color: CBase().borderPrimaryColor,
                  height: 1,
                )),
          ],
        ),
      ],
    );
  }
}
