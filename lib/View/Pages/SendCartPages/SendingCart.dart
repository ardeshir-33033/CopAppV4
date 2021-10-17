import 'package:copapp/Controller/Controllers/SendCartController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Pages/SendCartPages/AddressPayTypePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SendingCartCustomerTab.dart';

class SendCart extends StatefulWidget {
  @override
  _SendCartState createState() => _SendCartState();
}

class _SendCartState extends State<SendCart>
    with SingleTickerProviderStateMixin {
  SendCartController sendCartController = Get.put(SendCartController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendCartController.controller =
        TabController(length: sendCartController.list.length, vsync: this);
    sendCartController.controller!.addListener(() {
      setState(() {
        sendCartController.selectedIndex = sendCartController.controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: sendCartController.scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: sendCartController.scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: sendCartController.scaffoldKey,
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: sendCartController.list,
                controller: sendCartController.controller,
                labelColor: Color(0xffff0000),
                unselectedLabelColor: CBase().baseBlackColor,
                indicatorColor: Colors.transparent,
              ),
              Expanded(
                child: TabBarView(
                    controller: sendCartController.controller,
                    children: [
                      AddressPayType(),
                      Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: GetBuilder<SendCartController>(builder: (_) {
                            return SendingCartCustomerWidget();
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
