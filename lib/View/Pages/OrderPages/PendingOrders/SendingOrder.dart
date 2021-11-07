import 'package:copapp/Controller/Controllers/Order/OrderInfoController.dart';

import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'OrderAddress.dart';
import 'SendOrderTab.dart';


class SendOrder extends StatefulWidget {
  @override
  _SendOrderState createState() => _SendOrderState();
}

class _SendOrderState extends State<SendOrder>
    with SingleTickerProviderStateMixin {
    OrderInfoController orderInfoController = Get.find();
      final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    orderInfoController.controller =
        TabController(length: orderInfoController.list.length, vsync: this);
    orderInfoController.controller!.addListener(() {
      setState(() {
        orderInfoController.selectedIndex = orderInfoController.controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: orderInfoController.list,
                controller: orderInfoController.controller,
                labelColor: Color(0xffff0000),
                unselectedLabelColor: CBase().baseBlackColor,
                indicatorColor: Colors.transparent,
              ),
              Expanded(
                child: TabBarView(
                    controller: orderInfoController.controller,
                    children: [
                      OrderAddress(),
                      Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: GetBuilder<OrderInfoController>(builder: (_) {
                            return SendOrderTab();
                          })),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
