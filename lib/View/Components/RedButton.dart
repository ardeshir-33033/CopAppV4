import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class REDButton extends StatelessWidget {
  final Widget? route;
  final Function(dynamic result)? onTapCallback;
  final dynamic param;
  final String? title;

  REDButton({
    this.onTapCallback,
    this.param,
    this.route,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 100.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: CBase().baseBlackColor,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 0),
                blurRadius: 6)
          ],
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              title ?? 'ادامه',
              style: TextStyle(
                fontSize: CBase().getTitlefontSizeByScreen(),
                color: CBase().baseYellowColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route ?? Container(),
            ),
          );
        }

        if (onTapCallback != null) {
          onTapCallback!(param);
        }
      },
    );
  }
}
