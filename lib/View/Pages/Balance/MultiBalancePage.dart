import 'package:copapp/Controller/Controllers/Balance/MultiBalanceController.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/MultiBalanceSubMenu.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/PointCounter.dart';
import 'package:copapp/View/Components/General/SearchBox.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MultiBalanceWidget.dart';

class MultiBalancePage extends StatefulWidget {
  @override
  _MultiBalancePageState createState() => _MultiBalancePageState();
}

class _MultiBalancePageState extends State<MultiBalancePage> {
  MultiBalanceController multiBalanceController =
      Get.put(MultiBalanceController());

  @override
  void initState() {
    super.initState();
    multiBalanceController.startFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: multiBalanceController.scaffoldKey,
        backgroundColor: CBase().backgroundColor,
        drawer: AppDrawer(
          scaffoldKey: multiBalanceController.scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: multiBalanceController.scaffoldKey,
        ),
        body: SafeArea(
            child: ConditionalWillPopScope(
          // onWillPop: null,
          onWillPop: () => multiBalanceController.backPress(),
          shouldAddCallbacks: true,
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0, right: 20),
                      child: PointCounter(),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  GetBuilder<MultiBalanceController>(
                      id: "sub&button",
                      builder: (_) {
                        return Container(
                          height: 30,
                          padding: EdgeInsets.only(right: 30.0),
                          child:multiBalanceController.result!=null? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  multiBalanceController.subCategories?.length,
                              itemBuilder: (context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: index !=
                                            multiBalanceController
                                                    .subCategories!.length -
                                                1
                                        ? 10
                                        : 30,
                                  ),
                                  width:
                                      (MediaQuery.of(context).size.width - 80) /
                                          3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: BalanceExtensions()
                                                    .getSelectedCategory()!
                                                    .id ==
                                                multiBalanceController
                                                    .subCategories![index].id
                                            ? CBase().basePrimaryLightColor
                                            : Colors.white),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      multiBalanceController
                                          .subCategorySelect(index);
                                    },
                                    child: Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          multiBalanceController
                                                  .subCategories![index].name ??
                                              "نام وارد نشده",
                                          style: TextStyle(
                                              color: CBase().textPrimaryColor,
                                              fontSize: 11
                                              //CBase().getSubTitlefontSizeByScreen()
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }):SizedBox(),
                        );
                      }),
                  GetBuilder<MultiBalanceController>(
                      id: "multi",
                      builder: (_) {
                        return Expanded(
                          child: Padding(
                              padding:
                                  EdgeInsets.only(top: 10, right: 30, left: 30),
                              child: multiBalanceController.result == null
                                  ? Center(
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    CBase().basePrimaryColor),
                                          ),
                                          Text("در حال دریافت")
                                        ],
                                      ),
                                    )
                                  : multiBalanceController.result!.length == 0
                                      ? Center(
                                          child: Text("کالایی وجود ندارد"),
                                        )
                                      : GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 1,
                                                  mainAxisSpacing: 8,
                                                  crossAxisSpacing: 8,
                                                  crossAxisCount: 3),
                                          itemCount: multiBalanceController
                                              .result!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return MultiBalanceWidget(
                                              bal: multiBalanceController
                                                  .result![index],
                                            );
                                          },
                                        )),
                        );
                      }),
                  GetBuilder<MultiBalanceController>(
                      id: "sub&button",
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ProductPageSubMenu(
                            items: multiBalanceController.result,
                            scaffoldKey: multiBalanceController.scaffoldKey,
                          ),
                        );
                      }),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 45.0, right: 20, left: 20),
                child: SingleChildScrollView(
                    child: SearchboxV2(
                  scaffoldKey: multiBalanceController.scaffoldKey,
                )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
