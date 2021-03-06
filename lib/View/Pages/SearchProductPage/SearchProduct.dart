import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'JoinedProducts.dart';

class SearchProduct extends StatelessWidget {
  SearchProduct({
    Key? key,
    required this.part,
    required this.index,
  }) : super(key: key);
  final Part part;
  final int index;
  final SearchProductController searchProductController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Column(
        children: <Widget>[
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   margin: EdgeInsets.only(
          //     right: 10.0,
          //     left: 10.0,
          //   ),
          //   child: ProductTitlebar(
          //     bal: widget.part != null ? widget.part : null,
          //   ),
          // ),
          GetBuilder<SearchProductController>(
            builder: (_) {
              return Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: JoinedProducts(
                  part: part,
                  index: index,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
