import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/Balance/externalBalanceController.dart';
import 'package:copapp/Controller/Controllers/Cart/CartLengthController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Controllers/Inquiry/InquiryController.dart';
import 'package:copapp/Controller/Controllers/Inquiry/InquiryItemController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/BalanceWidget.dart';
import 'package:copapp/View/Components/Balance/FilterBalanceWidget.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/PointCounter.dart';
import 'package:copapp/View/Components/General/SearchBox.dart';
import 'package:copapp/View/Components/General/WhiteButton.dart';
import 'package:copapp/View/Pages/CartPage/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExternalBalancePage extends StatefulWidget {
  final List<Part>? items;

  ExternalBalancePage({
    this.items,
  });

  @override
  _ExternalBalancePageState createState() => _ExternalBalancePageState();
}

class _ExternalBalancePageState extends State<ExternalBalancePage> {
  ExternalBalanceController balanceController =
      Get.put(ExternalBalanceController());
  ScoreService scoreServiceController = Get.put(ScoreService());
  BalanceItemController balanceItemController =
      Get.put(BalanceItemController());
  InquiryItemController inquiryItemController =
      Get.put(InquiryItemController());
  InquiryCartController inquiryController = Get.put(InquiryCartController());
  CartLengthController cartLengthController = Get.put(CartLengthController());
  @override
  void initState() {
    balanceController.init(widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // drawer: AppDrawer(
        //   scaffoldKey: balanceController.scaffoldKey,
        // ),
        // appBar: CustomAppBar(
        //   scaffoldKey: balanceController.scaffoldKey,
        // ),
        backgroundColor: CBase().backgroundColor,
        key: balanceController.scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: 20.0, bottom: 5.0),
                  //     child: PointCounter(),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 65.0, bottom: 5),
                    child: FilterBalanceWidget(
                      scaffoldKey: balanceController.scaffoldKey,
                    ),
                  ),
                  GetBuilder<ExternalBalanceController>(
                      id: "Load",
                      builder: (_) {
                        return balanceController.isLoadingExternal ||
                                balanceController.items == null
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          CBase().basePrimaryColor),
                                    ),
                                    Text(
                                      'در حال دریافت',
                                    )
                                  ],
                                ),
                              )
                            : GetBuilder<ExternalBalanceController>(
                                id: "parent",
                                builder: (_) {
                                  return Flexible(
                                    fit: FlexFit.tight,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 5, left: 5),
                                      child: ListView.builder(
                                        itemCount:
                                            balanceController.items!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (balanceController.items != null &&
                                              balanceController.items!.length !=
                                                  0)
                                            return BalanceWidget(
                                              scaffoldKey:
                                                  balanceController.scaffoldKey,
                                              bal: balanceController
                                                  .items![index],
                                            );
                                          return Container(
                                              width:
                                                  CBase().getFullWidth(context),
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            CBase()
                                                                .basePrimaryColor),
                                                  ),
                                                  Text("در حال دریافت"),
                                                ],
                                              )));
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                      }),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        WhiteButton(
                          text: 'سبد خرید',
                          color: CBase().textPrimaryColor,
                          onTapCallback: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 45.0, right: 20, left: 20),
                  child: SingleChildScrollView(
                      child: SearchboxV2(
                    scaffoldKey: balanceController.scaffoldKey,
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
