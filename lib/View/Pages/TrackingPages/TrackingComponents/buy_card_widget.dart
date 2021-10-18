import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyCard extends StatelessWidget {
  final String? bottomRight,
      bottomLeft,
      bottomLeftHeading,
      bottomRightHeading,
      phoneNumber;
  final Widget? center, top;

  const BuyCard(
      {Key? key,
      this.bottomRight,
      this.bottomLeft,
      this.top,
      this.center,
      this.bottomLeftHeading,
      this.bottomRightHeading,
      this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: [
          top!,
          Divider(
            color: Color(0xffCBCBCB),
          ),
          center!,
          Divider(
            color: Color(0xffCBCBCB),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      bottomRightHeading!,
                      style: TextStyle(
                          color: Color(0xff808285),
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 0.5,
                    color: Color(0xffCBCBCB),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      bottomRight!,
                      style: TextStyle(
                          color: Color(0xff808285),
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ],
              ),
              Container(
                width: 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Color(0xffCBCBCB),
              ),
              InkWell(
                  onTap: () {
                    if (phoneNumber != null) _launchCaller();
                  },
                  child: SvgPicture.asset("images/PhoneIcon.svg")),
              Container(
                width: 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Color(0xffCBCBCB),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      bottomLeftHeading!,
                      style: TextStyle(
                          color: Color(0xff808285),
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 0.5,
                    color: Color(0xffCBCBCB),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      bottomLeft!,
                      style: TextStyle(
                          color: Color(0xff808285),
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _launchCaller() async {
    String url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
