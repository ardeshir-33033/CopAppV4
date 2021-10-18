import 'package:copapp/AppModel/Home/Car.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatelessWidget {
  final Car? car;
  final double? width, height;
  final Function? onTap;
  final String? year;
  final int? len;

  CarItemWidget(
      {this.car, this.width, this.height, this.onTap, this.len, this.year});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: AnimatedContainer(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.033),
        duration: Duration(milliseconds: 200),
        child: Column(
          children: [
            Center(
                child: Text(
              car!.engName ?? '',
              maxLines: 1,
              style: TextStyle(fontSize: CBase().getTextfontSizeByScreen()),
            )),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: width! * 0.1),
              width: width,
              height: 1,
              color: Color(0xffff0000),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                      child: Text(
                    getCarName(car!.name),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: CBase().getTitlefontSizeByScreen() + 2),
                  )),
                  Text(
                    getSuffix(car!.name),
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: CBase().getTextfontSizeByScreen()),
                  ),
                  // car!.name != null
                  //     ? car!.name != '۷۰۰'
                  //         ? car!.name != '٥'
                  //             ? Text(
                  //                 ' تـــن',
                  //                 maxLines: 1,
                  //                 style: TextStyle(
                  //                     fontSize:
                  //                         CBase().getTextfontSizeByScreen()),
                  //               )
                  //             : Text(
                  //                 ' تــــن',
                  //                 maxLines: 1,
                  //                 style: TextStyle(
                  //                     fontSize:
                  //                         CBase().getTextfontSizeByScreen()),
                  //               )
                  //         : Text(
                  //             " پــی",
                  //             maxLines: 1,
                  //             style: TextStyle(
                  //                 fontSize: CBase().getTextfontSizeByScreen()),
                  //           )
                  //     : SizedBox(),
                ],
              ),
            ),
            Center(
              child: Text(
                year!,
                maxLines: 1,
                style:
                    TextStyle(fontSize: CBase().getTextfontSizeByScreen() + 2),
              ),
            ),
            Flexible(
              child: Container(
                width: width,
                child: car!.imagePath != null
                    ? Image.network(
                        car!.imagePath ?? "",
                        fit: BoxFit.contain,
                      )
                    : Column(
                        children: <Widget>[
                          for (int i = 0; i < len!; i++)
                            car!.imagePath != null
                                ? Expanded(
                                    child: Image.network(car!.imagePath ?? ""),
                                  )
                                : SizedBox(),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getSuffix(String? name) {
    if (name == null) {
      return '';
    } else if (name.split(' ')[0].contains('5') ||
        name.split(' ')[0].contains('٥')) {
      return ' تــــن';
    } else if (name.split(' ').contains('700') ||
        name.split(' ').contains('۷۰۰')) {
      return " پــی";
    } else {
      return ' تـــن';
    }
  }

  String getCarName(String? name) {
    if (name == null) {
      return '';
    } else {
      return name.replaceAll(RegExp(r'[آ-ی]+'), '').trimRight();
    }
  }
}
