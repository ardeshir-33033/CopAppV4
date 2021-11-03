import 'dart:io';

import 'package:copapp/Controller/Controllers/General/SearchController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Search/SearchSpeech.dart';
import 'package:copapp/View/Pages/SearchProductPage/SearchProductPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class SearchboxV2 extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  SearchboxV2({required this.scaffoldKey});

  @override
  _SearchboxV2State createState() => _SearchboxV2State();
}

class _SearchboxV2State extends State<SearchboxV2> {
  SearchController searchController = Get.put(SearchController());

  TextEditingController controller = TextEditingController();

  bool isLoading = false;

  bool boxVis = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 8.05,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('images/searchbox.png'))),
          child: Row(
            children: [
              Expanded(
                flex: 260,
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    isLoading = true;
                    boxVis = true;
                    searchController.hintText = "";
                    searchController.update(['vis', 'box']);
                    searchController
                        .searchItems(search: controller.text)
                        .then((value) {
                      isLoading = false;
                      searchController.update(['vis']);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        color: Color(0xff808080),
                        size: CBase().getTitlefontSizeByScreen(),
                      ),
                      Text(
                        'سرچ',
                        style: TextStyle(
                            color: Color(0xff808080),
                            fontSize: CBase().getTextfontSizeByScreen() * 1.5),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 842,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GetBuilder<SearchController>(
                            id: "text",
                            builder: (_) {
                              return TextField(
                                controller: controller,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: searchController.hintText,
                                    hintStyle: TextStyle(
                                      color: CBase().basePrimaryColor,
                                      fontSize:
                                          CBase().getTextfontSizeByScreen(),
                                    )),
                                style: TextStyle(
                                  fontSize: CBase().getSmallfontSizeByScreen(),
                                  color: CBase().basePrimaryColor,
                                ),
                                onTap: () {
                                  searchController.textfieldTapped();
                                },
                                onSubmitted: (value) {
                                  if (controller.text.length >= 2) {
                                    FocusScope.of(context).unfocus();
                                    isLoading = true;
                                    boxVis = true;
                                    searchController.hintText = "";
                                    searchController.update(['vis', 'box']);
                                    searchController
                                        .searchItems(search: controller.text)
                                        .then((value) {
                                      isLoading = false;
                                      searchController.update(['vis']);
                                    });
                                  }
                                },
                                onChanged: (value) async {
                                  if (controller.text.isEmpty) {
                                    boxVis = false;
                                    isLoading = false;
                                    searchController.searchedItems.clear();
                                    searchController
                                        .update(['box', 'item', 'vis']);
                                  }
                                  searchController.update(['clear']);
                                },
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              );
                            }),
                      ),
                      GetBuilder<SearchController>(
                          id: 'vis',
                          builder: (_) {
                            return Visibility(
                              visible: isLoading,
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        CBase().basePrimaryColor),
                                    strokeWidth: 2,
                                  )),
                            );
                          }),
                      GetBuilder<SearchController>(
                        id: 'clear',
                        builder: (_) {
                          return Visibility(
                              visible: controller.text.isNotEmpty,
                              child: InkWell(
                                child: Icon(
                                  Icons.clear_rounded,
                                  color: CBase().basePrimaryColor,
                                ),
                                onTap: () {
                                  boxVis = false;
                                  controller.text = "";
                                  searchController.searchedItems.clear();
                                  searchController
                                      .update(['box', 'item', 'clear']);
                                },
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 260,
                child: Visibility(
                  visible: !Platform.isIOS,
                  child: Container(
                    child: Center(
                      child: SearchSpeech(
                        speechTextCallBack: (result) {
                          // boxVis = true;
                          controller.text = result;
                          searchController.update(['clear']);
                          // searchItems(result);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: GetBuilder<SearchController>(
              id: "box",
              builder: (_) {
                return Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: boxVis,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          (MediaQuery.of(context).size.height / 3.0) - 30.0,
                      maxHeight:
                          (MediaQuery.of(context).size.height / 2.25) - 30.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: 5.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                      ),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0.0, 3.0),
                              blurRadius: 3)
                        ],
                      ),
                      child: Column(
                        children: [
                          GetBuilder<SearchController>(
                              id: 'item',
                              builder: (_) {
                                return Flexible(
                                  fit: FlexFit.tight,
                                  child: GetBuilder<SearchController>(
                                    id: 'error',
                                    builder: (_) {
                                      return searchController
                                                  .searchedItems.isEmpty &&
                                              searchController
                                                  .errorText.isNotEmpty
                                          ? Center(
                                              child: Text(
                                              searchController.errorText,
                                              style: TextStyle(
                                                  color:
                                                      CBase().textPrimaryColor,
                                                  fontSize: CBase()
                                                      .getTitlefontSizeByScreen()),
                                              textAlign: TextAlign.center,
                                            ))
                                          : ListView.builder(
                                              itemCount: searchController
                                                  .searchedItems.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 15),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.16,
                                                          height: 75.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: searchController
                                                                              .searchedItems[
                                                                                  index]
                                                                              .thumbImagePath !=
                                                                          null &&
                                                                      searchController
                                                                              .searchedItems[
                                                                                  index]
                                                                              .thumbImagePath !=
                                                                          ""
                                                                  ? NetworkImage(searchController
                                                                          .searchedItems[
                                                                              index]
                                                                          .thumbImagePath ??
                                                                      "")
                                                                  : AssetImage(
                                                                          "images/noimageicon.png")
                                                                      as ImageProvider,
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: CBase()
                                                                        .getFullWidth(
                                                                            context) /
                                                                    1.7,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Text(
                                                                    searchController.searchedItems[index].name !=
                                                                                null &&
                                                                            searchController
                                                                                .searchedItems[
                                                                                    index]
                                                                                .name!
                                                                                .isNotEmpty
                                                                        ? searchController
                                                                            .searchedItems[index]
                                                                            .name!
                                                                            .toPersianDigit()
                                                                        : "بدون نام",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          CBase()
                                                                              .getSubTitlefontSizeByScreen(),
                                                                      color: CBase()
                                                                          .textPrimaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 20,
                                                                width: 150.0,
                                                                child: SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    // itemCount: searchController
                                                                    //     .searchedItems[
                                                                    //         index]
                                                                    //     .vehicleEnglishName!
                                                                    //     .length,

                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        searchController.searchedItems[index].vehicleEnglishName ??
                                                                            "",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontSize: CBase().ssmallTextfontSize),
                                                                      ),
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Get.to(
                                                        () => SearchProductPage(
                                                              bal: searchController
                                                                      .searchedItems[
                                                                  index],
                                                            ));
                                                  },
                                                );
                                              },
                                            );
                                    },
                                  ),
                                );
                              }),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 10.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 0.0,
                              ),
                              child: Center(
                                child: Icon(Icons.expand_less),
                              ),
                            ),
                            onTap: () {
                              boxVis = false;
                              controller.text = "";
                              searchController.searchedItems.clear();
                              searchController.update(['box', 'item', 'clear']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
