import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  Function()? onTapCallback;
  Color? color;
  String? text;

  WhiteButton({
    this.text,
    this.color,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.fromLTRB(5.0, 12, 5, 16),
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 5.0,
            right: 5.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xffffffff),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 1.0,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child: Center(
                    child: Text(
                      text ?? 'متن',
                      style: TextStyle(
                        fontSize: 14,
                        //CBase().getTextfontSizeByScreen(),
                        color: color ?? CBase().basePrimaryColor,
                        letterSpacing: -0.65,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1.0,
              ),
            ],
          ),
        ),
        onTap: () {
          if (onTapCallback != null) {
            onTapCallback!();
          }
        },
      ),
    );
  }
}
