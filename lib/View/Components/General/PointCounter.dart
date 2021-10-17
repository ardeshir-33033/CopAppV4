import 'package:copapp/Controller/Controllers/General/PointController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CounterNumber.dart';

class PointCounter extends StatelessWidget {
  PointController pointController = Get.put(PointController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointController>(builder: (_) {
      return pointController.isLoading
          ? Container(
              height: 29.1,
              width: 0,
            )
          : Container(
              height: 29.1,
              padding:
                  EdgeInsets.all(pointController.getValue() >= 0 ? 5.0 : 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: pointController.numbers.isNotEmpty
                      ? CBase().borderPrimaryColor
                      : Colors.transparent),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (int i = 0; i < 5; i++)
                    pointController.getValue() >= 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: pointController.numbers.length > i
                                ? CounterNumber(
                                    number: pointController.numbers[i],
                                  )
                                : CounterNumber(
                                    number: 0,
                                  ),
                          )
                        : SizedBox(),
                ],
              ));
    });
  }
}
