import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class PackingCard extends StatelessWidget {
  final String? title, detail;

  const PackingCard({Key? key, this.title, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4 - 10,
            child: Center(
              child: FittedBox(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff808285),
                      fontSize: CBase().getSmallfontSizeByScreen(),
                      fontFamily: 'Iransans'),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 0.5,
            height: MediaQuery.of(context).size.height * 0.05,
            color: Color(0xff707070),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4 - 10,
            child: Center(
              child: FittedBox(
                child: Text(
                  detail!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff808285),
                      fontSize: CBase().getSmallfontSizeByScreen(),
                      fontFamily: 'Iransans'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
