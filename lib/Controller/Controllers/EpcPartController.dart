import 'dart:async';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Model/Epc/EpcPartGroup.dart';
import 'package:copapp/Model/Product.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class EpcPartController extends GetxController {
  bool isLoading = false, isZooming = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double? width;
  List<double> height = [];
  List<EpcPartGroup> partGroups = [];
  List<EpcPartGroup> filteredPartGroups = [];
  List<double> m = [];
  List<bool> productsLoading = [];
  List<Parts?> selected = [];
  List<List<Product>> balanceProducts = [[]];
  List<List<Part>> balanceParts = [[]];
  TabController? tabController;
  TickerProvider? vsync;
  ScrollController tableScrollController = ScrollController();
  ScrollController scrollController = ScrollController();
  List<String?> dropValue = [];
  List<List<DropdownMenuItem<String>>> dropItems = [];
  double localScale = 1.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading = true;
    update();
    EpcService().GetPartGroups(EpcService.selectedSubGroup!.id!).then((value) {
      if (value.isSuccess) {
        partGroups = value.data;

        tabController = TabController(length: partGroups.length, vsync: vsync!);
        for (int i = 0; i < partGroups.length; i++) {
          filteredPartGroups.add(EpcPartGroup.instance(partGroups[i]));
          dropItems.add(partGroups[i]
              .group!
              .partCategoryValues!
              .map((e) => DropdownMenuItem(
                    child: Text(
                      e.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: e.value,
                  ))
              .toList());
          dropItems[i].insert(
              0,
              DropdownMenuItem(
                child: Text(
                  'بدون فیلتر',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                value: null,
              ));
          dropValue.add(null);
          balanceParts.add([]);
          balanceProducts.add([]);
          selected.add(null);
          productsLoading.add(false);
        }
        setWidthHeight();
      } else {
        isLoading = false;
        update();
        value.ShowMessage();
      }
    });
  }

  Future setWidthHeight() async {
    for (int i = 0; i < partGroups.length; i++) {
      m.add(0);
    }
    for (int i = 0; i < partGroups.length; i++) {
      Completer<ui.Image> completer = new Completer<ui.Image>();
      new NetworkImage(partGroups[i].imageUrl!)
          .resolve(new ImageConfiguration())
          .addListener(ImageStreamListener(
              (ImageInfo info, bool _) => completer.complete(info.image)));
      completer.future.then((value) {
        m[i] = (value.width.toDouble() /
            (CBase().getFullWidth(scaffoldKey.currentContext!) - 20));
        width = (CBase().getFullWidth(scaffoldKey.currentContext!) - 20);
        height.add(value.height.toDouble() / m[i]);
        isLoading = false;
        update();
      });
    }
  }

  void select(int _code) {
    if (selected[tabController!.index] == null ||
        selected[tabController!.index]!.code != _code) {
      selected[tabController!.index] = partGroups[tabController!.index]
          .parts!
          .firstWhere((element) => element.code == _code);
      scrolTable(_code);
    } else
      selected[tabController!.index] = null;
    setBalance();
    update();
  }

  void setBalance() async {
    int tabIndex = tabController!.index;
    if (selected[tabIndex] != null && selected[tabIndex]!.code != null) {
      balanceParts = [];
      balanceProducts = [];
      for (int i = 0; i < partGroups.length; i++) {
        balanceParts.add([]);
        balanceProducts.add([]);
      }
      productsLoading[tabIndex] = true;
      update();
      Future.delayed(Duration(milliseconds: 10), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      });
      await BalanceServiceV2().searchByPartNumbers(getCodes()
      // ,EpcService.selectedModelSerie!.id!
      ).then((value) {
        if (value.isSuccess) {
          balanceParts[tabIndex] = value.data;
          balanceParts[tabIndex].forEach((element) {
            balanceProducts[tabIndex].addAll(element.products);
          });
          productsLoading[tabIndex] = false;
          update();
          Future.delayed(Duration(milliseconds: 10), () {
            scrollController.animateTo(CBase.deviceHeight,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          });
        } else {
          value.ShowMessage();
        }
      });
    } else {
      balanceParts[tabIndex] = [];
      balanceProducts[tabIndex] = [];
      productsLoading[tabIndex] = false;
      update();
    }
  }

  List<String> getCodes() {
    List<String> list = [];
    filteredPartGroups[tabController!.index].parts!.forEach((element) {
      if (element.code == selected[tabController!.index]!.code) {
        list.add(element.partNumber!
            // .substring(1, element.partNumber!.length - 1)
            // .replaceAll('-', '')
            );
      }
    });
    return list;
  }

  void setVsync(_vsync) {
    vsync = _vsync;
  }

  void clear(int index) {
    balanceParts[index] = [];
    balanceProducts[index] = [];
    selected[index] = null;
    productsLoading[index] = false;
    dropValue[index] = null;
    filteredPartGroups[index] = EpcPartGroup.instance(partGroups[index]);
    productsLoading.forEach((element) {
      element = false;
    });
    update();
  }

  void selectedFilter(v) {
    dropValue[tabController!.index] = v;
    update();
  }

  EpcPartGroup setFilterCodes() {
    EpcPartGroup t = EpcPartGroup.instance(partGroups[tabController!.index]);
    // t = partGroups[tabController!.index];
    if (dropValue[tabController!.index] != null) {
      t.parts = t.parts!
          .where((element) =>
              element.appliedModel!.contains(dropValue[tabController!.index]!))
          .toList();
    }
    return t;
  }

  void setFilter() {
    EpcPartGroup t = EpcPartGroup.instance(partGroups[tabController!.index]);
    // t = partGroups[tabController!.index];
    t = setFilterCodes();
    EpcPartGroup x = new EpcPartGroup.instance(t);
    x.imageCoordinates = [];
    for (int i = 0; i < t.imageCoordinates!.length; i++) {
      List<int?> list = t.parts!.map((e) => e.code).toList();
      if (list.contains(t.imageCoordinates![i].code)) {
        x.imageCoordinates!.add(t.imageCoordinates![i]);
      }
    }
    // List<ImageCoordinates> imgC = x.imageCoordinates!;
    // t.imageCoordinates = imgC;
    filteredPartGroups[tabController!.index] = EpcPartGroup.instance(x);
    update();
  }

  void init(int index) {
    balanceParts[index] = [];
    balanceProducts[index] = [];
    selected[index] = null;
    productsLoading[index] = false;
    filteredPartGroups[index] = EpcPartGroup.instance(partGroups[index]);
    productsLoading.forEach((element) {
      element = false;
    });
    update();
  }

  void scrolTable(int code) {
    tableScrollController.animateTo(
        MediaQuery.of(scaffoldKey.currentContext!).size.width *
            0.133 *
            filteredPartGroups[tabController!.index]
                .parts!
                .indexWhere((element) => element.code == code),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease);
  }

  void setZooming(bool bool) {
    isZooming = bool;
    update();
  }
}
