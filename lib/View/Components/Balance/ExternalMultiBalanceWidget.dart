import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/Balance/ExternalMultiBalanceController.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExternalMultiBalanceWidget extends StatelessWidget {
  final Part bal;

  ExternalMultiBalanceWidget({required this.bal});

  final ExternalMultiBalanceController multiBalanceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        multiBalanceController.selectPart(bal);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  nameGenerator(),
                  style: TextStyle(
                    fontSize: 12,
                    color: CBase().textPrimaryColor,
                    letterSpacing: -0.065,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            bal.thumbImagePath != "" && bal.thumbImagePath != null
                ? Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(bal.thumbImagePath!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
                : bal.thumbImagePath != null && bal.thumbImagePath!.length > 0
                ? Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(bal.thumbImagePath!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
                : Expanded(
              flex: 1,
              child: Container(
                // margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/noimageiconsmall.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            GetBuilder<ExternalMultiBalanceController>(
                id: "redBox",
                builder: (_) {
                  return BalanceExtensions().selectedPart(bal.id) == true
                      ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: SvgPicture.asset(
                      "images/checkBoxRed.svg",
                      height: 12,
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: SvgPicture.asset(
                      "images/checkBoxBlank.svg",
                      height: 12,
                    ),
                  );
                }),

            // ),
          ],
        ),
      ),
    );
  }

  String nameGenerator() {
    if (bal.appName == "") {
      return "نام وارد نشده";
    } else {
      return bal.appName ?? "";
    }
  }
}
