import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Components/General/WhiteButton.dart';
import 'package:copapp/View/Pages/Balance/BalancePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductPageSubMenu extends StatelessWidget {
  List<Part>? items = [];
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ProductPageSubMenu({required this.items, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 5.0,
        ),
        WhiteButton(
          text: "مشاهده انتخاب ها",
          color: Color(0xffff0000),
          onTapCallback: () {
            if (BalanceExtensions().getSelectedPartLength() > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BalancePage(
                    items: BalanceExtensions().getSelectedPart(),
                  ),
                ),
              );
            } else {
              Snacki().GETSnackBar(false, "کالایی انتخاب نشده است.");
            }
          },
        ),
        WhiteButton(
          text: "مشاهده همه",
          color: CBase().textPrimaryColor,
          onTapCallback: () async{
            if (items!.length > 0) {
              // BalanceExtensions().setSelectedPart(items!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BalancePage(
                    items: items,
                  ),
                ),
              );
              // Future.delayed(Duration(seconds: 2), () {
              //   BalanceExtensions().setSelectedPart([]);
              // });
            } else {
              Snacki().GETSnackBar(false, "کالایی وجود ندارد.");
            }
          },
        ),
        SizedBox(
          width: 5.0,
        ),
      ],
    );
  }
}
