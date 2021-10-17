import 'package:copapp/Controller/Controllers/EpcPartController.dart';
import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/BrandItems.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/Inquiry/InquiryItem.dart';
import 'package:copapp/View/Pages/EpcPages/EpcFamilyHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'EpcComponent.dart';

class EpcPartPage extends StatefulWidget {
  EpcPartPage({Key? key}) : super(key: key);

  @override
  _EpcPartPageState createState() => _EpcPartPageState();
}

class _EpcPartPageState extends State<EpcPartPage>
    with SingleTickerProviderStateMixin {
  EpcPartController partController = Get.put(EpcPartController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: partController.scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: partController.scaffoldKey,
          title: '',
        ),
        drawer: AppDrawer(
          scaffoldKey: partController.scaffoldKey,
        ),
        body: GetBuilder<EpcPartController>(
          initState: (v) {
            partController.setVsync(this);
          },
          builder: (_) {
            return partController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CBase().basePrimaryColor),
                    ),
                  )
                : partController.partGroups.isEmpty
                    ? Center(
                        child: Text('اطلاعاتی برای نمایش وجود ندارد'),
                      )
                    : Column(
                        children: [
                          GetBuilder<EpcPartController>(
                            initState: (v) {
                              partController.tabController!.addListener(() {
                                partController.clear(partController
                                    .tabController!.previousIndex);
                              });
                            },
                            builder: (_) {
                              return partController.partGroups.length > 1
                                  ? Container(
                                      width: CBase().getFullWidth(context),
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: TabBar(
                                          indicatorWeight: 0.000000000001,
                                          labelColor: CBase().basePrimaryColor,
                                          unselectedLabelColor: Colors.black,
                                          isScrollable: true,
                                          controller:
                                              partController.tabController,
                                          tabs: <Widget>[
                                            for (int i = 0;
                                                i <
                                                    partController
                                                        .partGroups.length;
                                                i++)
                                              Container(
                                                width: CBase()
                                                        .getFullWidth(context) *
                                                    0.3,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 2),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Center(
                                                  child: Text(
                                                    partController.partGroups[i]
                                                            .name ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                          ]),
                                    )
                                  : SizedBox();
                            },
                          ),
                          Expanded(
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: partController.tabController,
                                children: <Widget>[
                                  for (int i = 0;
                                      i < partController.partGroups.length;
                                      i++)
                                    Column(
                                      children: [
                                        Expanded(
                                          child: ListView(
                                            physics: partController.isZooming
                                                ? NeverScrollableScrollPhysics()
                                                : null,
                                            controller:
                                                partController.scrollController,
                                            children: [
                                              EpcComponent(),
                                              partController.productsLoading[
                                                      partController
                                                          .tabController!.index]
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 18.0),
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  CBase()
                                                                      .basePrimaryColor),
                                                        ),
                                                      ))
                                                  : Column(
                                                      children: [
                                                        partController.selected[
                                                                    partController
                                                                        .tabController!
                                                                        .index] ==
                                                                null
                                                            ? SizedBox()
                                                            : partController
                                                                    .balanceParts[
                                                                        partController
                                                                            .tabController!
                                                                            .index]
                                                                    .isEmpty
                                                                ? Text(
                                                                    'کالایی موجود نیست')
                                                                : EpcFamilyHeading(
                                                                    carType: EpcService
                                                                        .selectedModelSerie!
                                                                        .persianName!,
                                                                    familyName: partController
                                                                            .balanceParts[partController
                                                                                .tabController!.index]
                                                                            .first
                                                                            .appName!
                                                                            .isEmpty
                                                                        ? 'بدون نام'
                                                                        : partController.balanceParts[partController.tabController!.index].first.appName ??
                                                                            'بدون نام',
                                                                  ),
                                                        Container(
                                                            width: CBase()
                                                                .getFullWidth(
                                                                    context),
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                for (int i = 0;
                                                                    i <
                                                                        partController
                                                                            .balanceProducts[partController
                                                                                .tabController!.index]
                                                                            .length;
                                                                    i++)
                                                                  Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              11),
                                                                      child: partController.balanceProducts[partController.tabController!.index][i].productVirtualQTY != 0 &&
                                                                              partController.balanceProducts[partController.tabController!.index][i].productInfosPrice == 0
                                                                          ? Container()
                                                                          : Container(
                                                                              child: partController.balanceProducts[partController.tabController!.index][i].productVirtualQTY!= 0
                                                                                  ? BalanceItem(
                                                                                      bal: partController.balanceProducts[partController.tabController!.index][i],
                                                                                      scaffold: partController.scaffoldKey,
                                                                                    )
                                                                                  : InquiryItem(
                                                                                      scaffold: partController.scaffoldKey,
                                                                                      bal: partController.balanceProducts[partController.tabController!.index][i],
                                                                                    ))),
                                                                SizedBox(
                                                                  height: 18,
                                                                )
                                                              ],
                                                            )),
                                                      ],
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ]),
                          ),
                        ],
                      );
          },
        ),
      ),
    );
  }
}
