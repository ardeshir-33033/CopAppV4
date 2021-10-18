import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreFamily extends StatelessWidget {
  final bool vis;
  final int? familyCount;

  MoreFamily({
    required this.vis,
    this.familyCount,
    Key? key,
  }) : super(key: key);
  final SearchProductController searchProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return familyCount != null && familyCount! > 0
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text(
                          "نمایش برندها",
                          // widget.familyCount.toString() + " برند",
                          style: TextStyle(
                            fontSize: CBase().getSubTitlefontSizeByScreen(),
                            color: CBase().textPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    vis == true
                        ? Icon(
                            Icons.expand_less,
                            color: CBase().basePrimaryLightColor,
                          )
                        : Icon(
                            Icons.expand_more_sharp,
                            color: CBase().basePrimaryLightColor,
                          )
                  ],
                ),
              ),
              onTap: () {
                searchProductController.allJoinVis =
                    !searchProductController.allJoinVis;
                searchProductController.update();
              },
            ),
          )
        : SizedBox(
            width: 1.0,
          );
  }
}
