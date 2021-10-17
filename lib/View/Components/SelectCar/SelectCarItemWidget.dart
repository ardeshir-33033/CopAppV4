import 'package:copapp/AppModel/Home/Car.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SelectedCarItemWidget extends StatelessWidget {
  final double? width, height;
  final Function? onCancel;
  final List<Car>? cars;
  final String? year;

  SelectedCarItemWidget(
      {this.width, this.height, this.onCancel, this.cars, this.year});
  Car? car = BalanceServiceV2().getSelectedCar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                onCancel!();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.close,
                  color: Color(0xffff0000),
                  size: 15,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                height: height! - 30,
                width: width! / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      car?.engName ?? "",
                      // car!.keyWord != null ? car!.keyWord : '',
                      maxLines: 1,
                      style: TextStyle(
                          color: CBase().textPrimaryColor,
                          fontSize: CBase().getTextfontSizeByScreen()),
                    )),
                    Center(
                      child: Text(
                        'ایــســوزو',
                        maxLines: 1,
                        style: TextStyle(
                            color: CBase().textPrimaryColor,
                            fontSize: CBase().getTextfontSizeByScreen()),
                      ),
                    ),
                    Center(
                        child: Text(
                      car!.name ?? '',
                      maxLines: 1,
                      style: TextStyle(
                          color: CBase().textPrimaryColor,
                          fontSize: CBase().getTextfontSizeByScreen()),
                    )),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Center(
                        child: Text(
                          year!,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: CBase().getTextfontSizeByScreen(),
                            color: CBase().textPrimaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xffff0000),
                            decorationThickness: 3,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width! / 2,
                height: height! - 35,
                child: car!.imagePath != null
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.network(
                          car!.imagePath ?? "",
                          fit: BoxFit.contain,
                        ),
                      )
                    : SizedBox(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
