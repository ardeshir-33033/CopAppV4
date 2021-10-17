
import 'package:flutter/material.dart';

class PointsRoundButton extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? size;
  final Function? onTap;
  const PointsRoundButton(
      {Key? key, this.child, this.size, this.color, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size!),
      onTap: () {
        onTap!();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size!),
          color: color,
        ),
        width: size,
        height: size,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
