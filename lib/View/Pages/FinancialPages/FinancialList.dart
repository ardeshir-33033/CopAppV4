import 'package:copapp/Controller/Controllers/FinListController.dart';
import 'package:copapp/Model/FilterResponseModel.dart';
import 'package:copapp/Model/Order/OrderFilterModel.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'FinancialCard.dart';

class FinancialList extends StatelessWidget {
  final List<FilterResponseModel>? items;
  final OrdersFilterModel? filters;
  final List<OrderHeader>? commissions;
  final int? id;
  FinancialList({Key? key, this.items, this.id, this.filters, this.commissions})
      : super(key: key);

  final FinListController listController = Get.put(FinListController());

  @override
  Widget build(BuildContext context) {
    if (items != null) listController.setPoints(items);
    return GetBuilder<FinListController>(builder: (_) {
      return Container(
          child: items == null || items!.isEmpty
              ? Center(
                  child: Text('اطلاعاتی برای نمایش وجود ندارد'),
                )
              : ListView.builder(
                  itemCount: items!.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: FinancialCard(
                          orderNumber: items![i].code.toString(),
                          paymentStatus: items![i].orderStatusId == "payPending"
                              ? 1
                              : items![i].orderStatusId == "cancelled"
                                  ? 2
                                  : items![i].orderStatusId == "returned"
                                      ? 3
                                      : items![i].orderStatusId == "payFailed"
                                          ? 4
                                          : 0,
                          isPaidCommision: commissions![i].paidRefId == null ||
                                  commissions![i].paidRefId!.isEmpty
                              ? false
                              : true,
                          dateTop: commissions![i].paidTime == null ||
                                  commissions![i].paidTime!.isEmpty
                              ? ''
                              : commissions![i].paidTime,
                          // widget.items[i].createDs != null
                          //     ? widget.items[i].createDs
                          //     : '',
                          dateBottom: items![i].paidTime != null
                              ? items![i].paidTime
                              : '',
                          imageBottom: 'images/FinancialBill.png',
                          imageTop: 'images/FinancialCart.svg',
                          orderCode: items![i].id.toString(),
                          points: listController.points[i].toInt().toString(),
                          price: items![i].finalPrice!.toInt().toString(),
                        ));
                  },
                ));
    });
  }
}
