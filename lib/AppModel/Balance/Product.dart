import 'package:copapp/AppModel/Images/ProductImages.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class Product {
  String? productsName;
  String? unitsName;
  String? country;
  String? lastMarketPriceUpdate;
  String? brandsImagePath;
  String? brandsName;
  double? productInfosPrice;
  int? productVirtualQTY;
  int? multipleQTY;
  int? score;
  int? productsId;
  int? detailQTY;
  int? supplierId;
  double? lastMarketPrice;
  List<String>? images;
  bool? warranty;

  Product(
      {this.productsId,
      this.productsName,
      this.unitsName,
      this.brandsImagePath,
      this.productInfosPrice,
      this.productVirtualQTY,
      this.brandsName,
      this.country,
      this.multipleQTY,
      this.score,
      this.lastMarketPrice,
      this.images,
      this.warranty,
      this.detailQTY,
      this.supplierId,
      this.lastMarketPriceUpdate});

  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['productsId'] ?? 0;
    productsName = json['productsName'] ?? "نام وارد نشده";
    unitsName = json['unitsName'] ?? "";
    brandsName = json['brandsName'] ?? "نام وارد نشده";
    brandsImagePath = json['brandsImagePath'] ?? "";
    productInfosPrice = json['productInfosPrice'] ?? 0;
    productVirtualQTY = json['productVirtualQTY'] ?? 1;
    detailQTY = json['detailQTY'] ?? 0;
    supplierId = json['supplierId'] ?? 0;
    //remove this later when the model is unique.
    if (json['country'] == null || json['country'].runtimeType == String)
      country = json['country'] ?? "";
    else
      country = json['country']["name"] ?? "";
    multipleQTY = json['multipleQTY'] ?? 1;
    score = json['score'] ?? 0;
    lastMarketPrice = json['lastMarketPrice'] ?? 0;
    //remove this later when the model is unique
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        if (v.runtimeType == String)
          images!.add(v);
        else if (v != null) images!.add(ProductImage.fromJson(v).path!);
      });
    }

    // images = json['images'] ?? [];
    // if (json['images'] != null) {

    // images = [];
    // json['images'].forEach((v) {
    //   images!.add(ProductImage.fromJson(v));
    // });
    // }
    warranty = json["warranty"] ?? false;
    lastMarketPriceUpdate = json['lastMarketPriceUpdate'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productsId'] = this.productsId;
    data['productsName'] = this.productsName;
    data['unitsName'] = this.unitsName;
    data['brandsName'] = this.brandsName;
    data['brandsImagePath'] = this.brandsImagePath;
    data['productInfosPrice'] = this.productInfosPrice;
    data['productVirtualQTY'] = this.productVirtualQTY;
    data['country'] = this.country;
    data['multipleQTY'] = this.multipleQTY;
    data['score'] = this.score;
    data['lastMarketPrice'] = this.lastMarketPrice;
    data['detailQTY'] = this.detailQTY;
    data['supplierId'] = this.supplierId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v).toList();
    }
    data['warranty'] = this.warranty;
    data['lastMarketPriceUpdate'] = this.lastMarketPriceUpdate;
    return data;
  }

  void displayImageSlider(BuildContext context) {
    slideDialog.showSlideDialog(
        context: context, child: SliderDialog(images: this.images));
  }

  bool isForSale() {
    return this.productVirtualQTY != null && this.productVirtualQTY! > 0;
  }

  Product.fromJsonOld(Map<String, dynamic> json) {
    productsName = json['name'] ?? "";
    multipleQTY = json['multipleQTY'] ?? 0;
    unitsName = json['unit']['name'];
    brandsName = json['brand']['name'];
    brandsImagePath = json['brand']['imagePath'];
    country = json['country']['name'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
    supplierId = 3088;
    productInfosPrice = json['productInfos'][0]['price'];
    productVirtualQTY = json['productInfos'][0]['qty'].toInt();
    productsId = json['id'];
    score = json['productInfos'][0]['score'].toInt();
    lastMarketPrice = json['productInfos'][0]['lastMarketPrice'];
  }
}

class SliderDialog extends StatefulWidget {
  final List<String>? images;

  SliderDialog({required this.images});

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  bool rightVis = false;
  bool leftVis = true;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      rightVis = true;
      leftVis = true;
      if (pageController.page! < 1) {
        rightVis = false;
      }
      if (pageController.page! > widget.images!.length - 2) {
        leftVis = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PhotoViewGallery(
              customSize: Size(CBase().getFullWidth(context) + 100,
                  CBase().getFullHeight(context) + 100),
              backgroundDecoration: BoxDecoration(color: Colors.white),
              pageController: pageController,
              scrollPhysics: const BouncingScrollPhysics(),
              pageOptions: [
                for (int i = 0; i <= widget.images!.length - 1; i++)
                  PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.images![i]),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    minScale: 0.4,
                    maxScale: 0.8,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.images![i]),
                  ),
              ],
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: rightVis,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: leftVis,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: InkWell(
                      onTap: () {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
