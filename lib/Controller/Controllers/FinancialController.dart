import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/FilterResponseModel.dart';
import 'package:copapp/Model/Order/OrderFilterModel.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/View/Pages/FinancialPages/FilteredFinancialList.dart';
import 'package:copapp/View/Pages/FinancialPages/FinancialFilter.dart';
import 'package:copapp/View/Pages/FinancialPages/FinancialList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class FinancialController extends GetxController {
  // GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool poped = false;
  ResponseModel<FilterResponseModel>? model;
  List<FilterResponseModel>? items = [];
  List<FilterResponseModel> allItems = [];
  Widget? child;
  String heading = '';
  int preId = 0;
  ResponseModel<OrdersFilterModel> filtersModel =
      ResponseModel<OrdersFilterModel>();
  OrdersFilterModel? filters;
  bool searchVis = false, rangeVis = false;
  List<String> orderCodes = [];

  ResponseModel<List<OrderHeader>> commissionModel =
      ResponseModel<List<OrderHeader>>();
  List<OrderHeader> allCommissions = [];
  List<OrderHeader> commissions = [];

  Future getAllFactros() async {
    Map<String, dynamic> data = {};
    model = await OrderServiceV2().PostOrdersFilter(data);
    if (!model!.isSuccess) {
      if (!poped) model!.ShowMessage();
      Future.delayed(Duration(seconds: 2), () {
        if (!poped) {
          poped = true;
          Get.back();
          Get.back();
        }
      });
    }
  }

  Future getCommission() async {
    commissionModel = await OrderServiceV2().GetAllCommissionOrders();
    if (!commissionModel.isSuccess) {
      if (!poped) commissionModel.ShowMessage();
      Future.delayed(Duration(seconds: 2), () {
        if (!poped) {
          poped = true;
          Get.back();
          Get.back();
        }
      });
    }
  }

  Future getFilters() async {
    filtersModel = await OrderServiceV2().GetFeedOrdersFilter();
    if (!filtersModel.isSuccess) {
      if (!poped) filtersModel.ShowMessage();
      Future.delayed(Duration(seconds: 2), () {
        if (!poped) {
          poped = true;
          Get.back();
          Get.back();
        }
      });
    }
  }

  Future<bool> backPress() async {
    if (child is FilteredFinancialList) {
      heading = '';

      child = filterOptionNotSelected(preId, true);

      update();
    } else {
      Get.back();
    }
    return false;
  }

  others(int id) {
    return FinancialList(
      id: id,
      key: ValueKey(id),
      items: items,
      filters: filters,
      commissions: commissions,
    );
  }

  filterOptionSelected(int id, dynamic selected, String name) {
    return FilteredFinancialList(
      id: id,
      selected: selected,
      key: ValueKey(id),
      allCommissions: allCommissions,
      name: preId == 2 ? name : '',
      onBack: () {
        backPress();
      },
    );
  }

  filterOptionNotSelected(int id, bool back) {
    return FinancialFilter(
      id: id,
      key: ValueKey(id),
      filters: filters,
      back: back,
      onSelect: (v, selected) {
        if (preId == 1) heading = v;
        child = filterOptionSelected(id, selected, v);
        update();
      },
    );
  }

  getFilteredByDate(Map<String, dynamic> data) async {
    model = await OrderServiceV2().PostOrdersFilter(data);
    if (!model!.isSuccess) {
      if (!poped) model!.ShowMessage();
      Future.delayed(Duration(seconds: 2), () {
        if (!poped) {
          poped = true;
          Get.back();
          Get.back();
        }
      });
    }
  }

  List<FilterResponseModel> getFilteredPaid() {
    items = allItems;
    setCommisions();
    List<FilterResponseModel> t = [];
    List<OrderHeader> h = [];
    commissions.forEach((c) {
      if (c.paidRefId != null && c.paidRefId!.isNotEmpty) {
        h.add(c);
      }
    });
    allItems.forEach((v) {
      h.forEach((c) {
        if (v.code == c.code) {
          t.add(v);
        }
      });
    });
    return t;
  }

  List<FilterResponseModel> getFilteredNotPaid() {
    items = allItems;
    setCommisions();
    List<FilterResponseModel> t = [];
    List<OrderHeader> h = [];
    commissions.forEach((c) {
      if (c.paidRefId == null || c.paidRefId!.isEmpty) {
        h.add(c);
      }
    });
    allItems.forEach((v) {
      h.forEach((c) {
        if (v.code == c.code) {
          t.add(v);
        }
      });
    });
    return t;
  }

  void paidItems(int v) {
    items = null;
    update();

    items = getFilteredPaid();
    setCommisions();
    child = others(v);
    update();
  }

  void notPaidItems(int v) {
    items = null;
    update();
    items = getFilteredNotPaid();
    setCommisions();
    child = others(v);
    update();
  }

  void searchOrderCode(v) {
    items = null;
    update();
    items = allItems;
    setCommisions();

    items!.forEach((w) {
      orderCodes.add(w.code!);
      orderCodes.add(w.id.toString());
    });
    searchVis = true;
    child = others(v);
    update();
  }

  void setCommisions() {
    commissions = [];
    for (int i = 0; i < items!.length; i++) {
      bool found = false;
      for (int j = 0; j < allCommissions.length; j++) {
        if (items![i].code == allCommissions[j].code) {
          commissions.add(allCommissions[j]);
          found = true;
        }
      }
      if (!found) {
        commissions.add(OrderHeader(code: items![i].code));
      }
    }
  }

  void setRange(double s, double e) {
    items = [];
    allItems.forEach((v) {
      if ((v.finalPrice!) >= s && (v.finalPrice!) <= e) items!.add(v);
    });
    setCommisions();
    child = others(preId);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFilters().then((value) {
      filters = filtersModel.data;
      update();
    });
    getAllFactros().then((value) {
      getCommission().then((w) {
        if (!poped) {
          allCommissions = commissionModel.data;
          items = model!.data;
          allItems = model!.data;
          setCommisions();
          if (preId != 1 && preId != 2)
            child = others(preId);
          else
            child = filterOptionNotSelected(preId, false);
          update();
        }
      });
    });
  }

  void choose(v) {
    heading = '';
    update();
    searchVis = false;
    rangeVis = false;
    if (v == 1 || v == 2) {
      preId = v;
      items = allItems;
      setCommisions();
      child = filterOptionNotSelected(v, false);
      update();
    } else if (preId != v) {
      preId = v;

      update();
      if (v == 0) {
        items = allItems;
        setCommisions();
        update();
      }
      if (v == 3) {
        items = allItems;
        setCommisions();
        rangeVis = true;
        update();
      }
      if (v == 4) {
        items = allItems;
        setCommisions();
        update();
        paidItems(v);
      }
      if (v == 5) {
        items = allItems;
        setCommisions();
        update();
        notPaidItems(v);
      }
      if (v == 6) {
        items = allItems;
        setCommisions();
        update();
        searchOrderCode(v);
      }
      child = others(v);
    }
  }

  void dateSelect(since, till) {
    if (preId == 0) {
      items = null;
      commissions = [];
      update();

      Map<String, dynamic> data = {
        'startDate': since.toString().split(' ')[0].trim() +
            'T' +
            since.toString().split(' ')[1].trim() +
            'Z',
        'endDate': till.toString().split(' ')[0].trim() +
            'T' +
            till.toString().split(' ')[1].trim() +
            'Z',
      };

      getFilteredByDate(data).then((v) {
        items = model!.data;
        setCommisions();
        child = others(preId);
        update();
      });
    }
  }

  void getResult(List<String> results) {
    List<FilterResponseModel> t = [];
    allItems.forEach((item) {
      if (results.contains((item.code!).toEnglishDigit()) ||
          results.contains((item.id.toString()).toEnglishDigit())) {
        t.add(item);
      }
    });
    items = t;
    setCommisions();
    child = others(preId);
    update();
  }
}
