// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomInfoWidget extends StatelessWidget {
  final String main, rotated;
  final Color mainColor;
  final double mainSize, rotatedSize;
  final bool mainCenter;
  const CustomInfoWidget(
      {Key? key,
      required this.main,
      required this.mainColor,
      this.mainSize = 12.0,
      this.rotated = '',
      this.rotatedSize = 12.0,
      this.mainCenter = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
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
        Expanded(
          child: mainCenter
              ? Center(
                  child: Text(
                    main,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: mainColor,
                        fontFamily: 'Iransans',
                        fontSize: mainSize),
                  ),
                )
              : Text(
                  main,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
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
    );
  }
}
