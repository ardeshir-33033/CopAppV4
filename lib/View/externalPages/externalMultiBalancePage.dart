import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/Controller/Controllers/Balance/ExternalMultiBalanceController.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/ExternalMultiBalanceWidget.dart';
import 'package:copapp/View/Components/Balance/MultiBalanceSubMenu.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/SearchBox.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExternalMultiBalancePage extends StatefulWidget {
  @override
  _ExternalMultiBalancePageState createState() => _ExternalMultiBalancePageState();
}

class _ExternalMultiBalancePageState extends State<ExternalMultiBalancePage> {
  ExternalMultiBalanceController multiBalanceController = Get.put(ExternalMultiBalanceController());


  @override
  void initState() {
    super.initState();
    BalanceExtensions.selectedCategory = Category(name: "" , id: 233);
    multiBalanceController.getBalanceExternal();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: multiBalanceController.scaffoldKey,
        backgroundColor: CBase().backgroundColor,
        // drawer: AppDrawer(
        //   scaffoldKey: multiBalanceController.scaffoldKey,
        // ),
        // appBar: CustomAppBar(
        //   scaffoldKey: multiBalanceController.scaffoldKey,
        // ),
        body: SafeArea(
            child: ConditionalWillPopScope(
              // onWillPop: null,
              onWillPop: () => multiBalanceController.backPress(),
              shouldAddCallbacks: true,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(bottom: 5.0, right: 20),
                      //     child: PointCounter(),
                      //   ),
                      // ),
                      SizedBox(
                        height: 100,
                      ),
                      GetBuilder<ExternalMultiBalanceController>(
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
                      GetBuilder<ExternalMultiBalanceController>(
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
                                      return ExternalMultiBalanceWidget(
                                        bal: multiBalanceController
                                            .result![index],
                                      );
                                    },
                                  )),
                            );
                          }),
                      GetBuilder<ExternalMultiBalanceController>(
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
