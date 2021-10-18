import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final Widget? route;
  final Function(dynamic result)? onTapCallback;
  final FlexFit? fit;

  final bool? icon;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final Color? color;
  final String? text;
  WhiteButton({
    this.leftIcon,
    this.rightIcon,
    this.icon,
    this.text,
    this.color,
    this.route,
    this.onTapCallback,
    this.fit,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: fit ?? FlexFit.tight,
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
              icon == true
                  ? rightIcon != null
                      ? rightIcon!
                      : SizedBox(
                          width: 1.0,
                        )
                  : SizedBox(
                      width: 1.0,
                    ),
              Flexible(
                fit: fit ?? FlexFit.tight,
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
              icon == true
                  ? leftIcon != null
                      ? leftIcon!
                      : SizedBox(
                          width: 1.0,
                        )
                  : SizedBox(
                      width: 1.0,
                    ),
            ],
          ),
        ),
        onTap: () {
          if (route != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route!),
            );
          }

          if (onTapCallback != null) {
            onTapCallback!("tap");
          }
        },
      ),
    );
  }
}
