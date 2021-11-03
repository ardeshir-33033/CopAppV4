import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/MainFooter.dart';
import 'package:copapp/View/Components/General/SearchBox.dart';
import 'package:copapp/View/Pages/SearchProductPage/SearchProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductPage extends StatefulWidget {
  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  SearchProductController searchProductController = Get.find();

  @override
  void initState() {
    super.initState();
    searchProductController.getPart();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: searchProductController.scaffoldKey,
        bottomNavigationBar: MainFooterNavigation(),
        backgroundColor: const Color(0xfff7f4f8),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  GetBuilder<SearchProductController>(
                    id: 'loading',
                    builder: (_) {
                      return searchProductController.isLoading
                          ? Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CBase().basePrimaryColor),
                              )),
                            )
                          : Flexible(
                              fit: FlexFit.tight,
                              child: ListView.builder(
                                itemCount: searchProductController.parts.length,
                                  itemBuilder: (context, index) {
                                return SearchProduct(part:searchProductController.parts[index],index: index,);
                              }));
                    },
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: SearchboxV2(
                      scaffoldKey: searchProductController.scaffoldKey)),
            ],
          ),
        ),
      ),
    );
  }
}
