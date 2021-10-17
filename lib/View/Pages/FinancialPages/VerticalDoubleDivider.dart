import 'package:flutter/material.dart';

class VerticalDoubleDivider extends StatelessWidget {
  final Color color;

  const VerticalDoubleDivider({Key? key, this.color = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 1.0,
            color: color,
          ),
          flex: 1,
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: Container(
            width: 1.0,
            color: color,
          ),
          flex: 1,
        )
      ],
    );
  }
}
