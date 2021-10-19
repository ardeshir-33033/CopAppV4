import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:copapp/View/Components/General/MainFooter.dart';
import 'package:copapp/View/Components/General/SearchBox.dart';
import 'package:copapp/View/Pages/SearchProductPage/SearchProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductPage extends StatelessWidget {
  final Part? bal;
  late final SearchProductController searchProductController;
  SearchProductPage({
    this.bal,
    Key? key,
  }) {
    searchProductController = Get.put(SearchProductController(bal));
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
                  Flexible(
                      fit: FlexFit.tight,
                      child: SingleChildScrollView(child: SearchProduct())),
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
