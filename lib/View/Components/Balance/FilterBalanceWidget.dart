import 'package:copapp/Controller/Controllers/Balance/BalanceController.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FilterBalanceWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  FilterBalanceWidget({required this.scaffoldKey});
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CBase().getFullHeight(context) * 0.06,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: BalanceExtensions().filterLength(),
          itemBuilder: (context, i) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                BalanceController balanceController = Get.find();
                if (!balanceController.isLoadingfilter) {
                  selected = i;
                  balanceController.balanceFilter(
                      scaffoldKey: scaffoldKey,
                      filterId: BalanceExtensions().getFilter()[i].id);
                }
              },
              child: GetBuilder<BalanceController>(
                id: "filter",
                builder: (_) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(
                        right: i == 0 ? 20 : 10,
                        left: i == BalanceExtensions().getFilter().length - 1
                            ? 20
                            : 0),
                    height: CBase().getFullHeight(context) * 0.06 - 3,
                    width: (CBase().getFullWidth(context) - 70) / 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              i == selected ? Color(0xffff0000) : Colors.white,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        BalanceExtensions().getFilter()[i].name ?? "",
                        maxLines: 1,
                        style: TextStyle(
                            color: CBase().textPrimaryColor,
                            fontSize: CBase().getTextfontSizeByScreen() * 1.15),
                      ),
                    )),
                  );
                },
              ),
            );
          }),
    );
  }
}
