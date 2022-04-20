import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QrScreenPageView extends BasePageViewWidget<QrScreenPageViewModel> {
  QrScreenPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 56.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).qrPayments,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).showQrForScanning,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColorDark,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 34,
                  ),
                  Text(
                    S.of(context).amount,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '20.00',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.0, top: 2),
                          child: Text(
                            "JOD",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColor.verLightGray4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RepaintBoundary(
                    key: model.globalKey,
                    child: Image.asset(
                      AssetUtils.qr,
                      width: 223,
                      height: 223,
                    ),
                  ),
                  Text(
                    S.of(context).qrValidForOneHour,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      _shareImage(model, context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 34, left: 24, right: 24),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .bodyText1!
                                    .color!)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).shareQr,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            AppSvg.asset(AssetUtils.share,
                                color: Theme.of(context).primaryColorDark)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 29, bottom: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.AppHome);
                      },
                      child: Container(
                        height: 57,
                        width: 57,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color),
                        child: Center(
                          child: AppSvg.asset(AssetUtils.tick,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _shareImage(QrScreenPageViewModel model, BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = model.globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ///TODO:check directory
      final directory = (await getExternalStorageDirectory())!.path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      File imgFile = new File('$directory/QR.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderBox box = context.findRenderObject() as RenderBox;
      Share.shareFiles([imgFile.path],
          subject: 'QR',
          text:
              'Scan QR or click on link below to pay JOD 20 to Zein Malhas\n\n blinkURL',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } catch (e) {
      print(e);
    }
  }
}
