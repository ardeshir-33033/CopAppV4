import 'package:flutter/material.dart';

class DoubleWidgetDivider extends StatelessWidget {
  final Widget? top, bottom;
  final Color? dividerColor;

  const DoubleWidgetDivider(
      {Key? key, this.top, this.bottom, this.dividerColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        top??SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 1.0,
                color: dividerColor,
              ),
            )
          ],
        ),
        bottom??SizedBox()
      ],
    );
  }
}
