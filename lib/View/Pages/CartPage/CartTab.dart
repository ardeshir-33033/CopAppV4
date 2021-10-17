import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Model/CartDetail.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/BrandItems.dart';
import 'package:copapp/View/Pages/HomePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BasketItem.dart';

class CartTab extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffold;

  // Function(dynamic refresh)? refreshCallback;
  List<CartDetail>? cartDetail = [];

  CartTab({
    required this.scaffold,
    // this.refreshCallback,
    this.cartDetail,
  });

  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      padding: EdgeInsets.only(bottom: 5.0),
      child: CartServiceV2().cartHasProduct()
          ? ListView.builder(
              itemCount: cartDetail!.length,
              itemBuilder: (BuildContext context, int index) {
                return BalanceItem(
                  scaffold: scaffold,
                  bal: cartDetail![index].product,
                );
                // BasketItem(
                //   item: cartDetail![index],
                //   cartPageIdentifier: true,
                //   onTapCallback: (result) {
                //     // if (widget.refreshCallback != null)
                //     //   widget.refreshCallback!("");
                //   },
                //   // scaffold: scaffold,
                // );
              },
            )
          : CartServiceV2().getMyCart() != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "خریدی وجود ندارد",
                        style: TextStyle(
                          color: CBase().textPrimaryColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.black12),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.05)),
                        ),
                        child: Text(
                          'افزودن به سبد خرید',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomePageV4()));
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                )),
    );
  }
}
