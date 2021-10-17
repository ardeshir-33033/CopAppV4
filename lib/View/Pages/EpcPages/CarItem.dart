import 'package:copapp/Model/Epc/EpcModelSerie.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class EpcCarItem extends StatelessWidget {
  final EpcModelSerie modelSerie;
  final double? width, height;
  final Function? ontap;

  EpcCarItem({
    Key? key,
    required this.modelSerie,
    this.width,
    this.height,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap!();
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: width! * 0.15),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width! * 0.1),
              child: Center(
                  child: Text(
                modelSerie.englishName != null
                    ? modelSerie.englishName!
                    : '',
                maxLines: 1,
                style: TextStyle(fontSize: CBase().getTextfontSizeByScreen()),
              )),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: width! * 0.1),
              width: width,
              height: 1,
              color: Color(0xffff0000),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                      modelSerie.persianName != null
                          ? (modelSerie.persianName!)
                              .split(' ')
                              .first
                              .toPersianDigit()
                          : '',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: CBase().getTitlefontSizeByScreen() + 2),
                    )),
                    modelSerie.persianName != null
                        ? Text(
                            ' ' + (modelSerie.persianName!).split(' ').last,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize:
                                    CBase().getTextfontSizeByScreen() * 1.2),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: width,
                child: modelSerie.image != null
                    ? Image.network(
                        modelSerie.image!,
                        fit: BoxFit.contain,
                      )
                    : Image.asset('images/noimageicon.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
