import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as lc;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ScorePriceOrderDetail extends StatelessWidget {
  ScorePriceOrderDetail({required this.finalPrice, required this.score});

  double finalPrice;
  double score;

  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  final ScoreService scoreController = Get.find();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScoreService>(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("قیمت کل"),
                Row(
                  children: [
                    Text(nf.format(finalPrice).toString()),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.string(
                        CBase.toman,
                        color: Colors.black,
                        height: 20.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          scoreController.getShowScore()
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Divider(
                    color: CBase().borderPrimaryColor,
                    height: 1,
                  ),
                )
              : SizedBox(),
          scoreController.getShowScore()
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("جمع امتیاز"),
                      Text(
                        "${nf.format(score)} امتیاز",
                      )
                    ],
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }
}
