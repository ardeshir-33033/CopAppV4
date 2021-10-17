import 'package:flutter/material.dart';


class OrderNumberWidget extends StatelessWidget {
  final String main, top, rotated;
  final Color mainColor;
  final double mainSize, topSize, rotatedSize;
  final bool mainCenter;
  const OrderNumberWidget(
      {Key? key,
      required this.main,
      this.top = '',
      required this.mainColor,
      this.mainSize = 12.0,
      this.topSize = 12.0,
      this.rotated = '',
      this.rotatedSize = 12.0,
      this.mainCenter = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        top != ''
            ? Text(
                top,
                style: TextStyle(
                    color: Color(0xff707070),
                    fontFamily: 'Iransans',
                    fontSize: topSize),
              )
            : SizedBox(),
        Row(
          mainAxisAlignment: mainCenter && rotated == ''
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            rotated != ''
                ? RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      rotated,
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontFamily: 'Iransans',
                          fontSize: rotatedSize),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.all(mainCenter ? 0.0 : 5.0),
              child: Text(
                main,
                style: TextStyle(
                    color: mainColor,
                    fontFamily: 'Iransans',
                    fontSize: mainSize),
              ),
            ),
            mainCenter && rotated != ''
                ? Visibility(
                    visible: mainCenter,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        rotated,
                        style: TextStyle(
                            color: Colors.transparent,
                            fontFamily: 'Iransans',
                            fontSize: rotatedSize),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        top != ''
            ? Text(
                top,
                style: TextStyle(
                    color: Colors.transparent,
                    fontFamily: 'Iransans',
                    fontSize: topSize),
              )
            : SizedBox(),
      ],
    );
  }
}
