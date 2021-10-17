import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/Balance/MultiBalancePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatItem extends StatelessWidget {
  final Category category;

  const CatItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BalanceExtensions().setFormerCategory(false);
        BalanceServiceV2().setSelectedCategory(category);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBalancePage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
            child: Text(
          category.name ?? "",
          maxLines: 1,
          style: TextStyle(fontSize: CBase().getTextfontSizeByScreen() * 1.2),
        )),
      ),
    );
  }
}
