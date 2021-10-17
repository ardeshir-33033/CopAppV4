import 'package:copapp/Controller/Controllers/FinancialController.dart';

import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/SearchInList.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'ChoiceWidget.dart';
import 'CustomSlider.dart';
import 'FilterIcon.dart';

class Financial extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  FinancialController financialController = Get.put(FinancialController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ConditionalWillPopScope(
        shouldAddCallbacks: true,
        onWillPop: () => financialController.backPress(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xffF6F6F6),
          drawer: AppDrawer(
            scaffoldKey: scaffoldKey,
          ),
          appBar: CustomAppBar(
            scaffoldKey: scaffoldKey,
          ),
          body: GetBuilder<FinancialController>(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0, right: 20.0, left: 20),
                  child: Visibility(
                    visible: financialController.items != null &&
                        financialController.filters != null &&
                        financialController.child != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ChoiceWidget(
                              value: financialController.preId,
                              items: [
                                ChoiceWidgetItem(id: 0, title: 'تاریخ'),
                                ChoiceWidgetItem(id: 1, title: 'مشتری'),
                                ChoiceWidgetItem(id: 2, title: 'قطعه'),
                                ChoiceWidgetItem(id: 3, title: 'مبلغ'),
                                ChoiceWidgetItem(id: 4, title: 'تسویه شده'),
                                ChoiceWidgetItem(id: 5, title: 'تسویه نشده'),
                                ChoiceWidgetItem(id: 6, title: 'شماره سفارش'),
                              ],
                              title: 'بر اساس: ',
                              onChoose: (v) {
                                financialController.choose(v);
                              },
                            ),
                            financialController.heading.isNotEmpty &&
                                    financialController.heading != null
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      ' - ${financialController.heading}',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Color(0xff707070),
                                        fontFamily: 'Iransans',
                                        fontSize:
                                            CBase().getTextfontSizeByScreen(),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        FilterIcon(
                          id: financialController.preId,
                          key: ValueKey(financialController.preId),
                          onSelect: (since, till) {
                            financialController.dateSelect(since, till);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: financialController.searchVis
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: SearchInList(
                            list: financialController.orderCodes,
                            getResult: (List<String> results) {
                              financialController.getResult(results);
                            },
                          ),
                        )
                      : financialController.rangeVis
                          ? CustomSlider(onSelect: (s, e) {
                              financialController.setRange(s, e);
                            })
                          : SizedBox(),
                ),
                Expanded(
                  child: financialController.items != null &&
                          financialController.filters != null &&
                          financialController.child != null
                      ? AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: financialController.child,
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CBase().basePrimaryColor),
                          ),
                        ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
