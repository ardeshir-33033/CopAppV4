import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BalanceItem extends StatefulWidget {
  Product? bal;
  Function(dynamic)? onTapCallback;

  GlobalKey<ScaffoldState> scaffold;

  BalanceItem({
    this.bal,
    this.onTapCallback,
    required this.scaffold,
  });

  @override
  _BalanceItemState createState() => _BalanceItemState();
}

class _BalanceItemState extends State<BalanceItem> {
  BalanceItemController balanceItemController = Get.find();
  bool isLoading = false;

  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  ScoreService scoreServiceController = Get.find();

  NumberFormat nf1 = NumberFormat.decimalPattern("fa-IR");
  int itemCount = 0;
  bool hasItem = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkHasItem(widget.bal!.id!);
    balanceItemController.scaffoldKey = widget.scaffold;
  }

  @override
  Widget build(BuildContext context) {
    checkHasItem(widget.bal!.productsId!);
    double widgetHeight = (CBase().getFullWidth(context) - 40) * 0.33 + 1;
    return GetBuilder<ScoreService>(builder: (_) {
      return Container(
        width: double.infinity,
        height: widgetHeight,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Visibility(
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                visible: hasItem,
                child: Container(
                  width: 3,
                  height: widgetHeight * 0.35,
                  color: Color(0xffff0000),
                )),
            Expanded(
              flex: 1,
              child: Container(
                height: widgetHeight,
                child: Column(
                  children: [
                    widget.bal?.images != null && widget.bal!.images!.length > 0
                        ? Expanded(
                            flex: 3,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        widget.bal?.images!.first.path ?? ""),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              onTap: () {
                                ///to fix bottom slider in every device this lines needs to be added to slide_popup_dialog.dart
                                // pageBuilder: ( context,  animation1,
                                //     animation2) {
                                //   return Container();
                                // },
                                widget.bal!.displayImageSlider(context);
                              },
                            ),
                          )
                        : Expanded(
                            flex: 3,
                            child: Container(
                              // height: CBase().getFullHeight(context) / 11,
                              // width: MediaQuery.of(context).size.width / 4,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("images/noimageiconsmall.png"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                    scoreServiceController.getShowScore()
                        ? Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              '${widget.bal?.score}'
                                  .toPersianDigit(),
                              style: TextStyle(color: CBase().basePrimaryColor),
                            ))
                        : widget.bal!.brandsImagePath != null
                            ? Expanded(
                                flex: 1,
                                child: SvgPicture.network(
                                    widget.bal!.brandsImagePath!),
                              )
                            : Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: CBase().getFullHeight(context) / 5.4 - 10,
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: CBase().borderPrimaryColor,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 5,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: CBase().borderPrimaryColor,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: CBase().getFullHeight(context) / 5.4 - 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: CBase().getFullWidth(context) / 1.7 - 15,
                            margin: EdgeInsets.only(right: 10, left: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: AutoSizeText(
                                widget.bal!.productsName!.toPersianDigit(),
                                style: TextStyle(
                                  fontSize:
                                      CBase().getTitlefontSizeByScreen() * 0.85,
                                  color: CBase().textPrimaryColor,
                                  letterSpacing: -0.065,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              scoreServiceController.getShowScore()
                                  ? widget.bal!.brandsImagePath != null
                                      ? SvgPicture.network(
                                          widget.bal!.brandsImagePath!)
                                      : Container()
                                  : Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: AutoSizeText(
                                        widget.bal?.brandsName! ??
                                            "" +
                                                " - " +
                                                widget.bal!.country!,
                                        style: TextStyle(
                                          fontSize: CBase()
                                              .getSubTitlefontSizeByScreen(),
                                          color: CBase().basePrimaryLightColor,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                              Row(
                                children: [
                                   widget.bal!.warranty ==
                                              true
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "گارانتی",
                                                style: TextStyle(
                                                  fontSize: CBase()
                                                      .getSubTitlefontSizeByScreen(),
                                                  color: CBase()
                                                      .basePrimaryLightColor,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                  GetBuilder<BalanceItemController>(
                                    id: 'load',
                                    builder: (_) {
                                      return Visibility(
                                        visible: isLoading,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          width: 20.0,
                                          height: 20.0,
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              accentColor:
                                                  CBase().basePrimaryColor,
                                            ),
                                            child: isLoading
                                                ? CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            CBase()
                                                                .basePrimaryColor),
                                                  )
                                                : Text(""),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                      decoration: BoxDecoration(
                        color: CBase().borderPrimaryColor,
                      ),
                      height: 1.0,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 7,
                              child: GetBuilder<BalanceItemController>(
                                id: 1,
                                builder: (_) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      hasItem
                                          ? InkWell(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                  right: 10.0,
                                                  left: 5.0,
                                                ),
                                                child: SvgPicture.asset(
                                                  "images/plus.svg",
                                                  width: 15.0,
                                                  height: 15.0,
                                                  color:
                                                      CBase().basePrimaryColor,
                                                ),
                                              ),
                                              onTap: () {
                                                if (!isLoading) {
                                                  isLoading = true;
                                                  balanceItemController
                                                      .add(widget.bal!, hasItem)
                                                      .then((value) {
                                                    checkNewCount(value);
                                                    isLoading = false;
                                                    balanceItemController
                                                        .upDate();
                                                    balanceItemController
                                                        .upDateRow();
                                                  });
                                                }
                                              },
                                            )
                                          : Text(""),
                                      Flexible(
                                        child: InkWell(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: AutoSizeText(
                                              !hasItem
                                                  ? 'خرید'
                                                  : itemCount
                                                          .toString()
                                                          .toPersianDigit() +
                                                      " " +
                                                      widget.bal!.unitsName!,
                                              style: TextStyle(
                                                fontSize: CBase()
                                                    .getTitlefontSizeByScreen(),
                                                color: hasItem
                                                    ? CBase().textPrimaryColor
                                                    : CBase().basePrimaryColor,
                                                letterSpacing: -0.32,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          onTap: () {
                                            if (!isLoading&&!hasItem) {
                                              isLoading = true;
                                              balanceItemController
                                                  .add(widget.bal!, hasItem)
                                                  .then((value) {
                                                isLoading = false;
                                                balanceItemController.upDate();
                                                checkNewCount(value);
                                                balanceItemController
                                                    .upDateRow();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      hasItem
                                          ? InkWell(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                  left: 10.0,
                                                  right: 5.0,
                                                ),
                                                child: SvgPicture.asset(
                                                  "images/del.svg",
                                                  width: 15.0,
                                                  height: 15.0,
                                                ),
                                              ),
                                              onTap: () {
                                                if (!isLoading) {
                                                  isLoading = true;
                                                  balanceItemController
                                                      .remove(widget.bal!,
                                                          itemCount)
                                                      .then((value) {
                                                    isLoading = false;
                                                    balanceItemController
                                                        .upDate();
                                                    checkNewCount(value);
                                                    balanceItemController
                                                        .upDateRow();
                                                  });
                                                }
                                              },
                                            )
                                          : Text(""),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                color: CBase().borderPrimaryColor,
                              ),
                              width: 1,
                              // height: 50.0,
                            ),
                            Flexible(
                              flex: 6,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: GetBuilder<BalanceItemController>(
                                        id: 1,
                                        builder: (_) {
                                          return Column(
                                            mainAxisAlignment:
                                                scoreServiceController
                                                            .getShowScore() &&
                                                        hasItem
                                                    ? MainAxisAlignment
                                                        .spaceEvenly
                                                    : MainAxisAlignment.center,
                                            children: [
                                              !hasItem
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Visibility(
                                                          visible: hasItem,
                                                          child: Text(
                                                            "فی",
                                                            style: TextStyle(
                                                              fontSize: CBase()
                                                                  .getSmallfontSizeByScreen(),
                                                              color: CBase()
                                                                  .textPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          nf
                                                              .format(widget
                                                                      .bal!
                                                                      .productInfosPrice ??
                                                                  0)
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: CBase()
                                                                .getSmallfontSizeByScreen(),
                                                            color: CBase()
                                                                .textPrimaryColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        SvgPicture.string(
                                                          toman,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                          width: 15.0,
                                                          height: 15.0,
                                                        ),
                                                      ],
                                                    )
                                                  : Visibility(
                                                      visible:
                                                          scoreServiceController
                                                              .getShowScore(),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            (widget
                                                                        .bal!
                                                                        .score! *
                                                                    itemCount)
                                                                .toInt()
                                                                .toString()
                                                                .toPersianDigit(),
                                                            style: TextStyle(
                                                              fontSize: CBase()
                                                                  .getSmallfontSizeByScreen(),
                                                              color: CBase()
                                                                  .textPrimaryColor,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Visibility(
                                                            visible: hasItem,
                                                            child: Text(
                                                              "امتیاز",
                                                              style: TextStyle(
                                                                fontSize: CBase()
                                                                    .getSmallfontSizeByScreen(),
                                                                color: CBase()
                                                                    .textPrimaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              Visibility(
                                                visible: scoreServiceController
                                                        .getShowScore() &&
                                                    hasItem,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 1),
                                                  height: 1,
                                                  width: CBase().getFullWidth(
                                                              context) /
                                                          3.7 -
                                                      5,
                                                  color: CBase()
                                                      .borderPrimaryColor,
                                                ),
                                              ),
                                              Visibility(
                                                visible: hasItem,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FittedBox(
                                                      child: AutoSizeText(
                                                        nf
                                                            .format(itemCount *
                                                                widget
                                                                    .bal!
                                                                    .productInfosPrice!)
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                                  .getTitlefontSizeByScreen() *
                                                              0.9,
                                                          color: CBase()
                                                              .basePrimaryLightColor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    SvgPicture.string(
                                                      toman,
                                                      color: CBase()
                                                          .basePrimaryLightColor,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                      width: 15.0,
                                                      height: 15.0,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  checkHasItem(int id) {
    itemCount = CartServiceV2().cartProductQTY(id);
    if (itemCount == 0) {
      hasItem = false;
    } else {
      hasItem = true;
    }
  }

  void checkNewCount(int c) {
    if (c <= 0) {
      hasItem = false;
      itemCount = 0;
    } else {
      hasItem = true;
      itemCount = c;
    }
  }

  String toman =
      '<svg viewBox="0.0 -0.3 12.5 13.1" ><path transform="translate(-496.83, -730.72)" d="M 498.9729614257813 734.2662353515625 C 498.949462890625 734.103515625 498.93798828125 733.9420776367188 498.93798828125 733.7821044921875 C 498.93798828125 733.6837158203125 498.94580078125 733.546630859375 498.9609375 733.3692016601563 C 498.9766235351563 733.192626953125 499.0170288085938 732.984375 499.083740234375 732.7438354492188 C 499.1494750976563 732.50341796875 499.2313232421875 732.2757568359375 499.3283081054688 732.0597534179688 C 499.4253540039063 731.8441162109375 499.5269775390625 731.648681640625 499.6331787109375 731.4730224609375 L 500.2506713867188 731.9259033203125 C 500.2171020507813 731.9727783203125 500.1780395507813 732.0394287109375 500.1339111328125 732.1254272460938 C 500.0902099609375 732.2119140625 500.045166015625 732.3134765625 500.0000610351563 732.4302978515625 C 499.95458984375 732.5457153320313 499.911376953125 732.673095703125 499.8699951171875 732.8119506835938 C 499.82861328125 732.9494018554688 499.7941284179688 733.09375 499.7670288085938 733.2432250976563 C 499.7398681640625 733.3936157226563 499.722412109375 733.5457153320313 499.7145385742188 733.7002563476563 C 499.7117919921875 733.744873046875 499.7108764648438 733.7866821289063 499.7108764648438 733.8284912109375 C 499.7108764648438 733.9420776367188 499.7186889648438 734.052001953125 499.734375 734.158203125 C 499.7444458007813 734.2271728515625 499.7642211914063 734.3085327148438 499.7941284179688 734.4000244140625 C 499.8240356445313 734.4920043945313 499.86865234375 734.587646484375 499.9284057617188 734.6865234375 C 499.9881591796875 734.7863159179688 500.0631103515625 734.88330078125 500.1536865234375 734.9789428710938 C 500.2442626953125 735.0745849609375 500.3536987304688 735.1600952148438 500.4815063476563 735.2363891601563 C 500.6102905273438 735.3128051757813 500.7601318359375 735.3748168945313 500.93212890625 735.4226684570313 C 501.1045532226563 735.4703979492188 501.3003540039063 735.4943237304688 501.5206298828125 735.4943237304688 C 501.795166015625 735.4943237304688 502.0438842773438 735.4686279296875 502.2664184570313 735.4171752929688 C 502.4894409179688 735.3651733398438 502.684814453125 735.289794921875 502.8531494140625 735.1900024414063 C 503.0214233398438 735.0911254882813 503.16259765625 734.96923828125 503.276611328125 734.8262939453125 C 503.3901977539063 734.6832885742188 503.4757080078125 734.5204467773438 503.5331420898438 734.33935546875 C 503.6026000976563 734.1177368164063 503.6403198242188 733.8942260742188 503.6453857421875 733.669921875 L 503.6453857421875 733.6234741210938 C 503.6453857421875 733.4137573242188 503.6283569335938 733.2101440429688 503.59521484375 733.010986328125 C 503.5612182617188 732.8123168945313 503.5138549804688 732.6224975585938 503.4531860351563 732.443115234375 C 503.3924560546875 732.2638549804688 503.332275390625 732.1075439453125 503.2724609375 731.9741821289063 C 503.212646484375 731.84130859375 503.1602783203125 731.7369384765625 503.1151733398438 731.6605834960938 C 503.0697021484375 731.5842895507813 503.0457763671875 731.5460815429688 503.04345703125 731.5460815429688 L 503.6881103515625 731.135498046875 C 503.6959228515625 731.1488647460938 503.7285766601563 731.2035522460938 503.7850952148438 731.3005981445313 C 503.8421630859375 731.3976440429688 503.907470703125 731.5263061523438 503.9814453125 731.687744140625 C 504.0550537109375 731.84912109375 504.1290283203125 732.0380859375 504.2030639648438 732.2532958984375 C 504.276611328125 732.4693603515625 504.3341064453125 732.7024536132813 504.37548828125 732.953125 C 504.40673828125 733.1517333984375 504.4224243164063 733.3568115234375 504.4224243164063 733.5687255859375 C 504.4224243164063 733.6253051757813 504.418701171875 733.7374877929688 504.4104614257813 733.9039306640625 C 504.4031372070313 734.07080078125 504.35205078125 734.2933349609375 504.2591552734375 734.5724487304688 C 504.1607666015625 734.864013671875 504.0228881835938 735.1159057617188 503.8453369140625 735.3279418945313 C 503.6679077148438 735.5399169921875 503.46142578125 735.7145385742188 503.2260131835938 735.85302734375 C 502.9901123046875 735.990966796875 502.7294311523438 736.093994140625 502.4429931640625 736.1610717773438 C 502.156982421875 736.2282104492188 501.8549194335938 736.26171875 501.5362548828125 736.26171875 C 501.2047729492188 736.26171875 500.8948974609375 736.2208251953125 500.6061401367188 736.1394653320313 C 500.3173217773438 736.05810546875 500.0603637695313 735.935302734375 499.8350219726563 735.7711791992188 C 499.6097412109375 735.60791015625 499.422607421875 735.400146484375 499.2736206054688 735.1500244140625 C 499.1246948242188 734.8994140625 499.0244140625 734.6046752929688 498.9729614257813 734.2662353515625 Z M 502.3404541015625 731.096923828125 L 501.7073364257813 731.7286376953125 L 501.070068359375 731.0932006835938 L 501.7031860351563 730.4619140625 L 502.3404541015625 731.096923828125 Z" fill="#8c8c8c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-496.42, -736.68)" d="M 498.1786499023438 747.599609375 C 497.8856201171875 747.599609375 497.6356201171875 747.5653076171875 497.4291381835938 747.4959106445313 C 497.22216796875 747.426513671875 497.046875 747.3193359375 496.9027709960938 747.1756591796875 C 496.8149108886719 747.0877685546875 496.7476806640625 746.9932861328125 496.70068359375 746.8917846679688 C 496.654541015625 746.790283203125 496.6198120117188 746.6901245117188 496.5969848632813 746.59130859375 C 496.5741577148438 746.4928588867188 496.5618286132813 746.3988037109375 496.5587768554688 746.3096923828125 C 496.5565795898438 746.220458984375 496.5548095703125 746.1435546875 496.5548095703125 746.0794677734375 C 496.5548095703125 746.057861328125 496.5556945800781 745.9950561523438 496.5570068359375 745.8900146484375 C 496.5583190917969 745.7841796875 496.5605163574219 745.6488647460938 496.5627136230469 745.483642578125 C 496.5657958984375 745.3184814453125 496.5671081542969 745.129150390625 496.5671081542969 744.9155883789063 C 496.5671081542969 744.7051391601563 496.5657958984375 744.48193359375 496.5627136230469 744.247802734375 C 496.5627136230469 744.0179443359375 496.5605163574219 743.7799072265625 496.5548095703125 743.5316162109375 C 496.5495300292969 743.2838134765625 496.5411987304688 743.04345703125 496.5288696289063 742.81201171875 C 496.5170288085938 742.57958984375 496.5025024414063 742.3656005859375 496.4849548339844 742.169677734375 C 496.4678344726563 741.9736328125 496.4471435546875 741.8128662109375 496.4230041503906 741.6876220703125 L 497.2072448730469 741.5440063476563 C 497.23095703125 741.6798095703125 497.2516174316406 741.8466796875 497.2687377929688 742.0439453125 C 497.285888671875 742.2412109375 497.30126953125 742.4556884765625 497.3126831054688 742.6881103515625 C 497.3250122070313 742.9196166992188 497.334228515625 743.1612548828125 497.3408203125 743.4138793945313 C 497.347412109375 743.6656494140625 497.3508911132813 743.91162109375 497.3508911132813 744.1515502929688 L 497.3508911132813 746.159423828125 C 497.3508911132813 746.2503662109375 497.3553161621094 746.334716796875 497.3649597167969 746.413330078125 C 497.3742065429688 746.4920043945313 497.4093627929688 746.560546875 497.4708557128906 746.619384765625 C 497.5323486328125 746.680908203125 497.6237487792969 746.728759765625 497.7445678710938 746.7635498046875 C 497.8662719726563 746.7982177734375 498.0108032226563 746.8157958984375 498.1786499023438 746.8157958984375 L 498.259033203125 746.8157958984375 L 498.259033203125 747.599609375 L 498.1786499023438 747.599609375 Z" fill="#8c8c8c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-498.56, -740.2)" d="M 500.3169555664063 750.3377685546875 C 500.5546264648438 750.3377685546875 500.7518920898438 750.3008422851563 500.9091796875 750.2279052734375 C 501.0664978027344 750.1541137695313 501.2005004882813 750.0570068359375 501.310791015625 749.935302734375 C 501.4219360351563 749.814453125 501.5177001953125 749.6756591796875 501.5989990234375 749.5196533203125 C 501.6802673339844 749.36328125 501.762451171875 749.203369140625 501.8450317382813 749.0382080078125 C 501.9170837402344 748.8883056640625 501.9939575195313 748.7411499023438 502.0748291015625 748.5953369140625 C 502.1565246582031 748.4503173828125 502.2483520507813 748.3206787109375 502.3507080078125 748.207763671875 C 502.4535522460938 748.093994140625 502.5708312988281 748.0026245117188 502.7030639648438 747.931884765625 C 502.8348999023438 747.8611450195313 502.9890747070313 747.8259887695313 503.1648559570313 747.8259887695313 C 503.375732421875 747.8259887695313 503.5615844726563 747.8673095703125 503.7228088378906 747.9520263671875 C 503.884033203125 748.0355224609375 504.0224609375 748.1458740234375 504.1371459960938 748.2816162109375 C 504.2513427734375 748.4173583984375 504.3427429199219 748.5724487304688 504.4108276367188 748.7455444335938 C 504.4789428710938 748.9190673828125 504.5263671875 749.0952758789063 504.552734375 749.2740478515625 C 504.56591796875 749.3641357421875 504.5729370117188 749.457763671875 504.5729370117188 749.5535278320313 C 504.5729370117188 749.63916015625 504.5650634765625 749.750732421875 504.5487976074219 749.8896484375 C 504.5329895019531 750.0284423828125 504.4903564453125 750.181396484375 504.4209594726563 750.3478393554688 C 504.3515014648438 750.514404296875 504.2566223144531 750.6597900390625 504.1371459960938 750.7832641601563 C 504.0167236328125 750.9075927734375 503.8704223632813 750.9937133789063 503.6968994140625 751.0416259765625 C 503.5874938964844 751.070556640625 503.4780883789063 751.0855712890625 503.369140625 751.0855712890625 C 503.3155212402344 751.0855712890625 503.2338256835938 751.0784912109375 503.1226501464844 751.0657958984375 C 503.0123901367188 751.0521240234375 502.8788146972656 751.0156860351563 502.7232666015625 750.9554443359375 C 502.56689453125 750.895751953125 502.4170532226563 750.8218994140625 502.27294921875 750.7353515625 C 502.1288452148438 750.6488037109375 501.9957275390625 750.56005859375 501.8731384277344 750.4696044921875 C 501.7690124511719 750.6110229492188 501.6600646972656 750.7239379882813 501.5466918945313 750.8096313476563 C 501.433349609375 750.8948364257813 501.31298828125 750.9598388671875 501.1851196289063 751.0055541992188 C 501.0572509765625 751.0508422851563 500.9210815429688 751.0816040039063 500.7774047851563 751.097412109375 C 500.63330078125 751.1136474609375 500.47998046875 751.12158203125 500.3169555664063 751.12158203125 L 500.2369995117188 751.12158203125 L 500.2369995117188 750.3377685546875 L 500.3169555664063 750.3377685546875 Z M 502.3331298828125 749.821533203125 C 502.5752258300781 750.0003662109375 502.7970886230469 750.1299438476563 502.9970092773438 750.2098999023438 C 503.130126953125 750.2626342773438 503.2505187988281 750.2894287109375 503.3568420410156 750.2894287109375 C 503.4078063964844 750.2894287109375 503.454345703125 750.2841796875 503.4970092773438 750.2735595703125 C 503.542236328125 750.2626342773438 503.586181640625 750.2318725585938 503.6287841796875 750.181396484375 C 503.67138671875 750.1312255859375 503.7083129882813 750.0653076171875 503.7386474609375 749.9854125976563 C 503.7694091796875 749.9054565429688 503.7918090820313 749.8135986328125 503.8049926757813 749.70947265625 C 503.8102416992188 749.6673583984375 503.8128662109375 749.624267578125 503.8128662109375 749.5811767578125 C 503.8128662109375 749.5148315429688 503.8076171875 749.4454345703125 503.7970581054688 749.3734130859375 C 503.7940063476563 749.35498046875 503.7874145507813 749.3233032226563 503.77685546875 749.277587890625 C 503.7662963867188 749.2322998046875 503.7509155273438 749.1818237304688 503.730712890625 749.1259765625 C 503.7109375 749.0693359375 503.6846008300781 749.0113525390625 503.6529541015625 748.9515991210938 C 503.6208801269531 748.891357421875 503.5822143554688 748.8369140625 503.5369567871094 748.7877197265625 C 503.4912719726563 748.738525390625 503.4381103515625 748.6976318359375 503.3770446777344 748.6655883789063 C 503.3155212402344 748.6339111328125 503.2452392578125 748.61767578125 503.1648559570313 748.61767578125 C 503.1116943359375 748.61767578125 503.0615844726563 748.633056640625 503.0150146484375 748.6633911132813 C 502.9684448242188 748.6941528320313 502.9214477539063 748.7420654296875 502.8748779296875 748.8057861328125 C 502.8283081054688 748.869873046875 502.7786254882813 748.9494018554688 502.726806640625 749.045654296875 C 502.6749572753906 749.141845703125 502.6156616210938 749.2551879882813 502.5488586425781 749.38525390625 L 502.3331298828125 749.821533203125 Z" fill="#8c8c8c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-504.83, -740.29)" d="M 511.4209899902344 752.5113525390625 C 511.763671875 752.4428100585938 512.07080078125 752.3466186523438 512.3427734375 752.2239990234375 C 512.6138305664063 752.1019287109375 512.8466796875 751.9639892578125 513.0404663085938 751.8106079101563 C 513.2341918945313 751.6563720703125 513.3875122070313 751.493408203125 513.4995727539063 751.3207397460938 C 513.612060546875 751.1484985351563 513.6806030273438 750.9788818359375 513.7052001953125 750.8115234375 L 513.5513916015625 750.8115234375 L 513.3260498046875 750.8115234375 C 513.2293701171875 750.8115234375 513.1195068359375 750.8062744140625 512.9969482421875 750.7947998046875 C 512.5140991210938 750.7662353515625 512.156494140625 750.6080932617188 511.9249267578125 750.32080078125 C 511.8225708007813 750.191162109375 511.7579956054688 750.0426635742188 511.731201171875 749.873046875 C 511.7157897949219 749.7843017578125 511.7078857421875 749.6951293945313 511.7078857421875 749.6063842773438 C 511.7078857421875 749.5216064453125 511.7171020507813 749.4139404296875 511.7364501953125 749.2838745117188 C 511.75537109375 749.15380859375 511.7992553710938 749.0057373046875 511.8682861328125 748.8397216796875 C 511.937255859375 748.6736450195313 512.0185546875 748.5303955078125 512.1121215820313 748.4104614257813 C 512.2254638671875 748.2703247070313 512.3484497070313 748.1640014648438 512.4811401367188 748.0914916992188 C 512.6138305664063 748.0194091796875 512.7509155273438 747.9829711914063 512.8936767578125 747.9829711914063 C 513.2095947265625 747.9829711914063 513.5004272460938 748.125732421875 513.765380859375 748.4104614257813 C 513.8589477539063 748.5150146484375 513.9432983398438 748.6331787109375 514.0188598632813 748.7645874023438 C 514.094482421875 748.8959350585938 514.1594848632813 749.0364990234375 514.212646484375 749.1863403320313 C 514.2662353515625 749.3370361328125 514.3084106445313 749.493896484375 514.339599609375 749.6577758789063 C 514.370849609375 749.8212280273438 514.3883666992188 749.9877319335938 514.3931884765625 750.1573486328125 L 514.71044921875 750.1573486328125 L 514.71044921875 750.8115234375 L 514.3431396484375 750.8115234375 C 514.27587890625 751.1410522460938 514.155517578125 751.4389038085938 513.9806518554688 751.7047119140625 C 513.8057861328125 751.970947265625 513.594482421875 752.203369140625 513.3462524414063 752.4014892578125 C 513.0980224609375 752.5997314453125 512.8216552734375 752.7622680664063 512.51806640625 752.8887939453125 C 512.2140502929688 753.0157470703125 511.8994750976563 753.10498046875 511.5743408203125 753.1558837890625 L 511.4209899902344 752.5113525390625 Z M 512.8936767578125 748.6406860351563 C 512.8286743164063 748.6406860351563 512.7676391601563 748.6661376953125 512.7095947265625 748.7162475585938 C 512.652099609375 748.766357421875 512.6002197265625 748.830078125 512.5545043945313 748.9078369140625 C 512.5087890625 748.9860229492188 512.47021484375 749.072998046875 512.439453125 749.1705322265625 C 512.4077758789063 749.2672119140625 512.3871459960938 749.362060546875 512.375732421875 749.4556884765625 C 512.369140625 749.507080078125 512.3660888671875 749.55712890625 512.3660888671875 749.6063842773438 C 512.3660888671875 749.6463623046875 512.3699951171875 749.696044921875 512.37744140625 749.7544555664063 C 512.3853759765625 749.8133544921875 512.4077758789063 749.866455078125 512.446044921875 749.9130249023438 C 512.4793701171875 749.9578857421875 512.5211181640625 749.993896484375 512.5712280273438 750.0216064453125 C 512.621337890625 750.0496826171875 512.6749267578125 750.0720825195313 512.7315673828125 750.0887451171875 C 512.7882690429688 750.10546875 512.8440551757813 750.1173095703125 512.8985595703125 750.125244140625 C 512.9530029296875 750.1336059570313 513.00048828125 750.1380004882813 513.0404663085938 750.140625 C 513.1520385742188 750.147216796875 513.2561645507813 750.1502685546875 513.3546142578125 750.1502685546875 C 513.379150390625 750.1502685546875 513.4262084960938 750.1502685546875 513.4965209960938 750.1489868164063 C 513.5663452148438 750.1476440429688 513.64501953125 750.1436767578125 513.7319946289063 750.1370849609375 C 513.7249755859375 749.9943237304688 513.7086791992188 749.85986328125 513.681884765625 749.73291015625 C 513.6546630859375 749.6063842773438 513.620361328125 749.4881591796875 513.5782470703125 749.3787841796875 C 513.5355834960938 749.2694091796875 513.4885864257813 749.1710205078125 513.436279296875 749.0831298828125 C 513.384033203125 748.9957275390625 513.3299560546875 748.9192504882813 513.274169921875 748.8546142578125 C 513.2517700195313 748.8326416015625 513.2271728515625 748.8084716796875 513.1990966796875 748.7830810546875 C 513.17138671875 748.757080078125 513.1410522460938 748.7338256835938 513.1090087890625 748.7122802734375 C 513.0764770507813 748.691650390625 513.0426635742188 748.674560546875 513.007080078125 748.6604614257813 C 512.9714965820313 748.6472778320313 512.9337158203125 748.6406860351563 512.8936767578125 748.6406860351563 Z" fill="#8c8c8c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-508.86, -737.8)" d="M 518.60400390625 747.677001953125 L 519.24853515625 747.677001953125 C 519.377685546875 747.677001953125 519.5033569335938 747.6739501953125 519.6259155273438 747.668701171875 C 519.748046875 747.6625366210938 519.86181640625 747.646728515625 519.9664306640625 747.6195068359375 C 520.0709838867188 747.5935668945313 520.1636962890625 747.5540161132813 520.24365234375 747.5012817382813 C 520.3236083984375 747.4490356445313 520.385986328125 747.3760986328125 520.4308471679688 747.282470703125 C 520.4532470703125 747.2359619140625 520.4699096679688 747.1766357421875 520.4808959960938 747.10546875 C 520.4874877929688 747.059326171875 520.490966796875 747.0087890625 520.490966796875 746.9552001953125 C 520.490966796875 746.9266357421875 520.4884033203125 746.8822631835938 520.4840087890625 746.8233642578125 C 520.4796142578125 746.7649536132813 520.465087890625 746.6828002929688 520.44091796875 746.57958984375 C 520.4163208007813 746.476318359375 520.3802490234375 746.3677978515625 520.333740234375 746.25439453125 L 520.0433349609375 745.5391845703125 L 520.6377563476563 745.2452392578125 C 520.6377563476563 745.2478637695313 520.6478271484375 745.270263671875 520.6676635742188 745.314208984375 C 520.6878662109375 745.357666015625 520.7137451171875 745.4156494140625 520.7462768554688 745.4890747070313 C 520.7783203125 745.5628662109375 520.8134765625 745.647705078125 520.8516845703125 745.744384765625 C 520.8895263671875 745.8418579101563 520.9251098632813 745.9447021484375 520.95849609375 746.0536499023438 C 521.0582275390625 746.3765869140625 521.1162109375 746.6616821289063 521.1320190429688 746.9085693359375 C 521.1342163085938 746.9446411132813 521.1355590820313 746.979736328125 521.1355590820313 747.015380859375 C 521.1355590820313 747.2178955078125 521.1021728515625 747.3963012695313 521.034912109375 747.5496826171875 C 520.9681396484375 747.70166015625 520.8798217773438 747.826904296875 520.76953125 747.927001953125 C 520.6597290039063 748.0276489257813 520.533203125 748.1076049804688 520.390869140625 748.1678466796875 C 520.248046875 748.2279663085938 520.0916137695313 748.269775390625 519.921630859375 748.2943115234375 C 519.7511596679688 748.3193359375 519.5745239257813 748.3312377929688 519.3922119140625 748.3312377929688 L 518.60400390625 748.3312377929688 L 518.60400390625 747.677001953125 Z M 520.02001953125 744.1068725585938 L 519.4791870117188 744.647705078125 L 518.9312744140625 744.1033325195313 L 519.47216796875 743.5590209960938 L 520.02001953125 744.1068725585938 Z M 521.3890380859375 744.1099243164063 L 520.8482055664063 744.654296875 L 520.3003540039063 744.1068725585938 L 520.8416137695313 743.565185546875 L 521.3890380859375 744.1099243164063 Z" fill="#8c8c8c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
}
