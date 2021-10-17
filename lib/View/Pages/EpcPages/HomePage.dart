import 'package:copapp/Controller/Controllers/EpcHomeController.dart';
import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Pages/EpcPages/GroupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CarItem.dart';

class EpcHome extends StatelessWidget {
  EpcHome({Key? key}) : super(key: key);
  EpcHomeController epcController = Get.put(EpcHomeController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
          title: '',
        ),
        body: GetBuilder<EpcHomeController>(
          builder: (_) {
            return epcController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                    ),
                  )
                : Column(
                    children: [

                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [Container(
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                CBase().getFullHeight(context) /
                                                    30),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        child: Image.asset('images/Isuzu.png'),
                                      ),
                                      Visibility(
                                        visible: !epcController.isLoading,
                                        child: Container(
                                          height: 35,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 0.0),
                                              child: Text(
                                                'انتخاب خودرو',
                                                style: TextStyle(
                                                  fontSize: CBase()
                                                      .getTitlefontSizeByScreen(),
                                                  shadows: [
                                                    Shadow(
                                                        color: Color(0xff5E5E5E),
                                                        offset: Offset(0, -5))
                                                  ],
                                                  color: Colors.transparent,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      Color(0xffff0000),
                                                  decorationThickness: 2,
                                                  decorationStyle:
                                                      TextDecorationStyle.solid,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 32,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                    0.45 +
                                                20,
                                        width: CBase().getFullWidth(context),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05),
                                        child: GridView.builder(
                                          physics: ClampingScrollPhysics(),
                                          itemCount:
                                              epcController.modelSeries.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 20),
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return EpcCarItem(
                                              modelSerie:
                                                  epcController.modelSeries[i],
                                              ontap: () {
                                                EpcService.selectedModelSerie =
                                                    epcController.modelSeries[i];
                                                Get.to(() => EpcGroupPage());
                                              },
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.22,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
