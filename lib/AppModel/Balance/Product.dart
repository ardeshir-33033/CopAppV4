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
  double? score;
  int? productsId;
  int? detailQTY;
  double? lastMarketPrice;
  List<ProductImage>? images;
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
      this.lastMarketPriceUpdate});

  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['productsId'];
    productsName = json['productsName'];
    unitsName = json['unitsName'];
    brandsName = json['brandsName'];
    brandsImagePath = json['brandsImagePath'];
    productInfosPrice = json['productInfosPrice'];
    productVirtualQTY = json['productVirtualQTY'];
    detailQTY = json['detailQTY'];
    if (json['country'].runtimeType == String)
      country = json['country'];
    else
      country = json['country']["name"];

    multipleQTY = json['multipleQTY'].toInt();
    score = json['score'];
    lastMarketPrice = json['lastMarketPrice'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(ProductImage.fromJson(v));
      });
    }
    warranty = json["warranty"];
    lastMarketPriceUpdate = json['lastMarketPriceUpdate'];
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['warranty'] = this.warranty;
    data['lastMarketPriceUpdate'] = this.lastMarketPriceUpdate;
    return data;
  }

  void displayImageSlider(BuildContext context) {
    slideDialog.showSlideDialog(
        context: context, child: SliderDialog(images: this.images));
  }
}

class SliderDialog extends StatefulWidget {
  final List<ProductImage>? images;

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
    // TODO: implement initState
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
                    imageProvider: NetworkImage(widget.images![i].path ?? ""),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    minScale: 0.4,
                    maxScale: 0.8,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.images![i].id ?? 0),
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
