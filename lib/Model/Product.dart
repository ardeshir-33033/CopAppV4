import 'dart:ui';

import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

import 'Brand.dart';
import 'Country.dart';
import 'ProductImage.dart';
import 'ProductInfo.dart';
import 'Unit.dart';

class Product {
  String? name;
  String? code;
  Unit? unit;
  Brand? brand;
  Part? part;
  Country? country;
  List<ProductImage>? images;
  List<ProductInfo>? productInfos;
  double? qtyCart;
  double? sumSale;
  int? id;
  int? multipleQTY;

  Product({
    this.name,
    this.code,
    this.unit,
    this.brand,
    this.part,
    this.country,
    this.images,
    this.productInfos,
    this.qtyCart,
    this.sumSale,
    this.id,
    this.multipleQTY,
  });

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    multipleQTY = json['multipleQTY'] ?? 0;
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    part = json['part'] != null ? Part.fromJson(json['part']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(ProductImage.fromJson(v));
      });
    }
    if (json['productInfos'] != null) {
      productInfos = [];
      json['productInfos'].forEach((v) {
        productInfos!.add(ProductInfo.fromJson(v));
      });
    }
    qtyCart = json['qtyCart'] ?? 0.0;
    sumSale = json['sumSale'] ?? 0.0;
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['multipleQTY'] = this.multipleQTY;
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.part != null) {
      data['part'] = this.part!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.productInfos != null) {
      data['productInfos'] = this.productInfos!.map((v) => v.toJson()).toList();
    }
    data['qtyCart'] = this.qtyCart;
    data['sumSale'] = this.sumSale;
    data['id'] = this.id;
    return data;
  }

  List<Product>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Product>((ct) {
        return Product.fromJson(ct);
      }).toList();
    }

    return null;
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
        )
        // PhotoViewGallery.builder(
        //   scrollPhysics: const BouncingScrollPhysics(),
        //   builder: (BuildContext context, int index) {
        //     return PhotoViewGalleryPageOptions(
        //       imageProvider: NetworkImage(this.images[index]?.path ?? ""),
        //       initialScale: PhotoViewComputedScale.contained * 0.8,
        //       minScale: 0.4,
        //       maxScale: 0.8,
        //       heroAttributes:
        //           PhotoViewHeroAttributes(tag: this.images[index]?.id ?? 0),
        //     );
        //   },
        //   itemCount: this.images?.length ?? 0,
        //   loadingBuilder: (context, event) => Center(
        //     child: Container(
        //       width: 200.0,
        //       height: 200.0,
        //       child: CircularProgressIndicator(
        //         value: event == null
        //             ? 0
        //             : event.cumulativeBytesLoaded / event.expectedTotalBytes,
        //       ),
        //     ),
        //   ),
        //   backgroundDecoration: BoxDecoration(color: Colors.white),
        //   pageController: PageController(),
        //   onPageChanged: (index) {
        //     //
        //   },
        // ),
        );
  }
}
