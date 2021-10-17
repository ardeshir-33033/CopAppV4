import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CounterNumber extends StatelessWidget {
  int number;

  CounterNumber({required this.number});

  @override
  Widget build(BuildContext context) {
    number > 9 || number < 0 ? throw 'Number not in range' : null;
    return Container(
      width: 14.67,
      height: 19.1,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SvgPicture.asset(
            'images/Counter.svg',
            fit: BoxFit.contain,
          ),
          AnimatedFlipCounter(
            duration: Duration(milliseconds: 1000),
            value: number.toDouble(),
            textStyle: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: CBase().getTextfontSizeByScreen() * 1.1),
          ),
          // NumberSlideAnimation(
          //   number: number.toString(),
          //   duration: const Duration(seconds: 1),
          //   curve: Curves.bounceIn,
          //   textStyle: TextStyle(
          //     color: Colors.white.withOpacity(0.9),
          //   ),
          // )
        ],
      ),
    );
  }
}
