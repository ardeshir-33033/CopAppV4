import 'package:copapp/Controller/Controllers/FinancialController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

// ignore: must_be_immutable
class FilterIcon extends StatelessWidget {
  final int? id;
  final Function(DateTime since, DateTime till)? onSelect;
  final FinancialController financialController = Get.find();
  final TextEditingController textEditingController = TextEditingController();

  FilterIcon({Key? key, this.id, this.onSelect}) : super(key: key);

  int? sd, sm, sy;


  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: id == 0,
      child: IconButton(
        icon: Icon(
          id == 0
              ? Icons.calendar_today_rounded
              : id == 3
                  ? Icons.attach_money_rounded
                  : null,
          color: CBase().textPrimaryColor,
        ),
        onPressed: () {
          if (id == 0) {
            DatePicker.showDatePicker(context,
                maxYear: PersianDate().year!,
                initialDay: PersianDate().day!,
                initialMonth: PersianDate().month!,
                initialYear: PersianDate().year!,
                // title: Center(
                //     child: Text(
                //   'از',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // )),
                onConfirm: (y, m, d) {
              sd = d;
              sm = m;
              sy = y;

              if (sd != null && sm != null && sy != null) {
                Future.delayed(Duration(milliseconds: 500), () {
                  DatePicker.showDatePicker(context,
                      maxYear: PersianDate().year!,
                      initialDay: PersianDate().day!,
                      initialMonth: PersianDate().month!,
                      initialYear: PersianDate().year!,
                      // title: Center(
                      //     child: Text(
                      //   'تا',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // )),
                      onConfirm: (ty, tm, td) {
                    List<int> s =
                        PersianDate().jalaliToGregorian(sy!, sm!, sd!);
                    DateTime since = DateTime(s[0], s[1], s[2], 0, 0, 0);
                    List<int> t =
                        PersianDate().jalaliToGregorian(ty!, tm!, td!);
                    DateTime till = DateTime(t[0], t[1], t[2], 23, 59, 59);
                    if (since.isBefore(till)) {
                      onSelect!(since, till);
                    } else {
                      Snacki().GETSnackBar(false, 'بازه زمانی معتبر نمی باشد');
                    }
                  });
                });
              }
            });
          }
        },
      ),
    );
  }
}
