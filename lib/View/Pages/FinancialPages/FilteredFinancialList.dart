import 'package:copapp/Controller/Controllers/FilteredFinListController.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/View/Components/General/SearchInList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'FinancialCard.dart';

class FilteredFinancialList extends StatelessWidget {
  final List<OrderHeader>? allCommissions;
  final int? id;
  final dynamic selected;
  final Function? onBack;
  final String? name;

  FilteredFinancialList(
      {Key? key,
      this.allCommissions,
      this.id,
      this.selected,
      this.onBack,
      this.name})
      : super(key: key);
  final FilteredFinListController listController =
      Get.put(FilteredFinListController());

  @override
  Widget build(BuildContext context) {
    listController.setInits(id,allCommissions,selected);
    return GetBuilder<FilteredFinListController>(builder: (_) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: GestureDetector(
              child: SearchInList(
                hint: name!,
                enable: false,
                key: ValueKey(id),
                onTap: () {
                  onBack!();
                },
                list: allCommissions!.map((e) => e.code!).toList(),
              ),
              onTap: () {
                onBack!();
              },
            ),
          ),
          Expanded(
            child: Container(
              child: listController.isLoading!
                  ? Center(
                      child: Text('درحال دریافت'),
                    )
                  : listController.items.isNotEmpty
                      ? ListView.builder(
                          itemCount: listController.items.length,
                          itemBuilder: (context, int i) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20.0),
                                child: FinancialCard(
                                  orderNumber:
                                      listController.items[i].code.toString(),
                                  paymentStatus: listController
                                              .items[i].orderStatusId ==
                                          "payPending"
                                      ? 1
                                      : listController.items[i].orderStatusId ==
                                              "cancelled"
                                          ? 2
                                          : listController
                                                      .items[i].orderStatusId ==
                                                  "returned"
                                              ? 3
                                              : listController.items[i]
                                                          .orderStatusId ==
                                                      "payFailed"
                                                  ? 4
                                                  : 0,
                                  isPaidCommision:
                                      listController.commissions[i].paidRefId ==
                                                  null ||
                                              listController.commissions[i]
                                                  .paidRefId!.isEmpty
                                          ? false
                                          : true,
                                  dateTop: listController
                                                  .commissions[i].paidTime ==
                                              null ||
                                          listController
                                              .commissions[i].paidTime!.isEmpty
                                      ? ''
                                      : listController.commissions[i].paidTime,
                                  // widget.items[i].createDs != null
                                  //     ? widget.items[i].createDs
                                  //     : '',
                                  dateBottom:
                                      listController.items[i].paidTime != null
                                          ? listController.items[i].paidTime
                                          : '',
                                  imageBottom: 'images/FinancialBill.png',
                                  imageTop: 'images/FinancialCart.svg',
                                  orderCode:
                                      listController.items[i].id.toString(),
                                  points: listController.points[i].toString(),
                                  price: listController.items[i].finalPrice
                                      .toString(),
                                ));
                          },
                        )
                      : Center(child: Text('اطلاعاتی برای نمایش وجود ندارد')),
            ),
          ),
        ],
      );
    });
  }
}
