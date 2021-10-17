import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceController.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Model/Part.dart';
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

class BalancePage extends StatefulWidget {
  List<Part>? items;

  BalancePage({
    this.items,
  });

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  BalanceController balanceController = Get.put(BalanceController());

  @override
  void initState() {
    // TODO: implement initState
    balanceController.init(widget.items!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: AppDrawer(
          scaffoldKey: balanceController.scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: balanceController.scaffoldKey,
        ),
        backgroundColor: CBase().backgroundColor,
        key: balanceController.scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0, bottom: 5.0),
                      child: PointCounter(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 65.0, bottom: 5),
                    child: FilterBalanceWidget(
                      scaffoldKey: balanceController.scaffoldKey,
                    ),
                  ),
                  GetBuilder<BalanceController>(
                      id: 1,
                      builder: (_) {
                        return balanceController.isLoadingfilter
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
                            : GetBuilder<BalanceItemController>(
                                id: 6,
                                builder: (_) {
                                  return Flexible(
                                    fit: FlexFit.tight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5, left: 5),
                                      child: ListView.builder(
                                        itemCount:
                                            balanceController.items?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (balanceController.items != null &&
                                              balanceController.items!.length !=
                                                  0)
                                            return BalanceWidget(
                                              scaffoldKey:
                                                  balanceController.scaffoldKey,
                                              bal: balanceController.items![index],
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
