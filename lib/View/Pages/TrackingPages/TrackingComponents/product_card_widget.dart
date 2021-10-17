import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'برند 1',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xff7B7B7B),
                            fontSize: CBase().getTextfontSizeByScreen(),
                            fontFamily: 'Iransans'),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset(
                          'images/ProductPic.png',
                          fit: BoxFit.fitWidth,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: SvgPicture.asset(
                        "images/ProductLogo.svg",
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    width: 0.5,
                    color: Color(0xff707070),
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    width: 0.5,
                    color: Color(0xff707070),
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 2.25),
                    padding: EdgeInsets.only(right: 15.0),
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'بوش پیستون 1xرینگ سبز -',
                              style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize:
                                      CBase().getTitlefontSizeByScreen(),
                                  fontFamily: 'Iransans'),
                            ),
                            Text(
                              ' 6-8 تن',
                              style: TextStyle(
                                  color: Color(0xff5E5E5E),
                                  fontSize:
                                      CBase().getTextfontSizeByScreen(),
                                  fontFamily: 'Iransans'),
                            )
                          ],
                        ),
                        Text(
                          'ایسوزو موتور- ژاپن',
                          style: TextStyle(
                              color: Color(0xffEB5151),
                              fontSize:
                                  CBase().getTitlefontSizeByScreen() - 1,
                              fontFamily: 'Iransans'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    height: 0.5,
                    width: MediaQuery.of(context).size.width * 0.7 - 20.0,
                    color: Color(0xff707070),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.25),
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width * 0.35 - 10.0,
                          child: Center(
                            child: Text(
                              '۲',
                              style: TextStyle(
                                  color: Color(0xff5D5D5D),
                                  fontSize:
                                      CBase().getLargefontSizeByScreen(),
                                  fontFamily: 'Iransans'),
                            ),
                          ),
                        ),
                        Container(
                          width: 0.5,
                          color: Color(0xff707070),
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 0.35 - 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5.0),
                                  height: MediaQuery.of(context).size.height *
                                          0.025 -
                                      0.25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'فی',
                                        style: TextStyle(
                                            color: Color(0xff5E5E5E),
                                            fontSize: CBase()
                                                .getTextfontSizeByScreen(),
                                            fontFamily: 'Iransans'),
                                      ),
                                      Text(
                                        '۱۹,۵۰۰,۰۰۰',
                                        style: TextStyle(
                                            color: Color(0xff5E5E5E),
                                            fontSize: CBase()
                                                .getTextfontSizeByScreen(),
                                            fontFamily: 'Iransans'),
                                      ),
                                      SizedBox()
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9 -
                                          10,
                                  height: 0.5,
                                  color: Color(0xff707070),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5.0),
                                  height: MediaQuery.of(context).size.height *
                                          0.025 -
                                      0.25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Text(
                                        '۳۹,۰۰۰,۰۰۰',
                                        style: TextStyle(
                                            color: Color(0xffEB5151),
                                            fontSize: CBase()
                                                .getTitlefontSizeByScreen(),
                                            fontFamily: 'Iransans'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.0),
                                        child: SvgPicture.asset(
                                            'images/TomanIcon.svg'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
