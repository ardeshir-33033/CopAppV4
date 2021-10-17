import 'package:another_xlider/another_xlider.dart';
import 'package:copapp/Controller/Controllers/General/CustomSliderController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSlider extends StatelessWidget {
  final Function? onSelect;

  CustomSlider({Key? key, this.onSelect}) : super(key: key);

  CustomSliderController sliderController = Get.put(CustomSliderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomSliderController>(builder: (_) {
      return Container(
        padding: EdgeInsets.only(bottom: 30.0, left: 15, right: 15),
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i <= 10; i++)
                    Container(
                      width: 1,
                      height: 12,
                      color: Color(0xffAFAFAF),
                    )
                ],
              ),
            ),
            FlutterSlider(
              values: [sliderController.start!, sliderController.end!],
              rangeSlider: true,
              min: 0,
              max: 50000000,
              tooltip: FlutterSliderTooltip(
                  alwaysShowTooltip: true,
                  format: (v) {
                    List<String> all = [];
                    String result = '';
                    int i = v.split('.')[0].length;
                    for (i; i > 3; i = i - 3) {
                      all.add(v.split('.')[0].substring(i - 3, i));
                    }
                    all.add(v.split('.')[0].substring(0, i));
                    for (int j = all.length - 1; j > 0; j--) {
                      result += (all[j] + ',');
                    }
                    result += all.first;
                    return result;
                  },
                  positionOffset: FlutterSliderTooltipPositionOffset(top: 60),
                  boxStyle: FlutterSliderTooltipBox(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.0, color: Colors.transparent),
                          color: Colors.transparent)),
                  textStyle: TextStyle(
                      color: CBase().textPrimaryColor,
                      fontSize: CBase().getLargefontSizeByScreen())),
              trackBar: FlutterSliderTrackBar(
                  inactiveTrackBar: BoxDecoration(color: Color(0xffAFAFAF)),
                  activeTrackBar: BoxDecoration(color: Color(0xffAFAFAF)),
                  activeTrackBarHeight: 3,
                  inactiveTrackBarHeight: 3),
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: Container(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Image.asset(
                      'images/thumb.png',
                      fit: BoxFit.contain,
                    )),
              ),
              rightHandler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'images/thumb.png',
                      fit: BoxFit.contain,
                    )),
              ),
              onDragging: (i, s, e) {
                sliderController.onDrag(s,e);
              },
              onDragCompleted: (i, s, e) {
                onSelect!(s, e);
              },
            ),
          ],
        ),
      );
    });
  }
}
