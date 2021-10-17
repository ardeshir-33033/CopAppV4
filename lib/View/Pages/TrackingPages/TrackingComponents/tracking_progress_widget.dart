import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

enum TrackingStage { Buy, Bill, Packing, Sending, Transporting, Invoice }

class TrackingProgress extends StatelessWidget {
  final TrackingStage trackingStage;

  const TrackingProgress({Key? key, required this.trackingStage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Center(
                    child: Text(
                      'خرید',
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Center(
                    child: Text(
                      'فاکتور',
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Center(
                    child: Text(
                      'درحال بسته بندی',
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Center(
                    child: Text(
                      'پیک',
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Center(
                    child: Text(
                      'باربری',
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Center(
                    child: Text(
                      'بیجک',
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'Iransans'),
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: Color(0xffE80000),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: trackingStage != TrackingStage.Buy
                      ? Color(0xffE80000)
                      : Colors.transparent,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: trackingStage != TrackingStage.Buy &&
                          trackingStage != TrackingStage.Bill
                      ? Color(0xffE80000)
                      : Colors.transparent,
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: trackingStage == TrackingStage.Invoice ||
                          trackingStage == TrackingStage.Transporting ||
                          trackingStage == TrackingStage.Sending
                      ? Color(0xffE80000)
                      : Colors.transparent,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: trackingStage == TrackingStage.Invoice ||
                          trackingStage == TrackingStage.Transporting
                      ? Color(0xffE80000)
                      : Colors.transparent,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: trackingStage == TrackingStage.Invoice
                      ? Color(0xffE80000)
                      : Colors.transparent,
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
