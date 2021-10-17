import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TotalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'مبلغ کل',
                          style: TextStyle(
                              fontFamily: 'Iransans',
                              fontSize:
                                  CBase().getTitlefontSizeByScreen(),
                              color: Color(0xff5E5A5E)),
                        ),
                        Text(
                          '۱۲,۵۰۰,۰۰۰',
                          style: TextStyle(
                              fontFamily: 'Iransans',
                              fontSize:
                                  CBase().getTitlefontSizeByScreen(),
                              color: Color(0xff5E5A5E)),
                        )
                      ],
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'images/TomanIcon.svg',
                          color: Color(0xff5E5A5E),
                        ),
                      ],
                    ),
                    flex: 1,
                  )
                ],
              ),
              Divider(
                color: Color(0xff707070),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'جمع امتیاز',
                          style: TextStyle(
                              fontFamily: 'Iransans',
                              fontSize:
                                  CBase().getTitlefontSizeByScreen(),
                              color: Color(0xff5E5A5E)),
                        ),
                        Text(
                          '۱۲۵',
                          style: TextStyle(
                              fontFamily: 'Iransans',
                              fontSize:
                                  CBase().getTitlefontSizeByScreen(),
                              color: Color(0xff5E5A5E)),
                        )
                      ],
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
