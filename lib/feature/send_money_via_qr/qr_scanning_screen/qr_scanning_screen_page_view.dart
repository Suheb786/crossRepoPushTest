import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/qr_scanning_screen/qr_scanning_screen_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanningScreenPageView extends BasePageViewWidget<QrScanningScreenPageViewModel> {
  QrScanningScreenPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, QrScanningScreenPageViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          AppStreamBuilder<Resource<VerifyQrResponse>>(
              initialData: Resource.none(),
              stream: model.verifyQRStream,
              onData: (data) async {
                if (data.status == Status.SUCCESS) {
                  await Future.delayed(const Duration(milliseconds: 300));
                  model.controller?.resumeCamera();

                  ///LOG EVENT TO FIREBASE
                  await FirebaseAnalytics.instance.logEvent(
                    name: "qr_scanned",
                    parameters: {"is_qr_scanned": true.toString(), "request_id": data.data?.qrContent?.requestId ?? ''},
                  );

                  ///Log event to infobip
                  var event = {
                    "definitionId": "QRScanned",
                    "properties": {"completed": true}
                  };
                  InfobipMobilemessaging.submitEventImmediately(event);

                  Navigator.pushReplacementNamed(context, RoutePaths.SendMoneyQrScanning,
                      arguments: SendMoneyQRScanningArguments(
                          source: 'QR',
                          amount: data.data?.qrContent?.amount ?? '',
                          accountHolderName: data.data?.qrContent?.accountHolderName ?? '',
                          accountNo: data.data?.qrContent?.toAccount ?? '',
                          requestId: data.data?.qrContent?.requestId ?? ''));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                  await Future.delayed(const Duration(milliseconds: 300));
                  model.controller?.resumeCamera();
                  Navigator.pop(context);
                }
              },
              dataBuilder: (context, snapshot) {
                return QRView(
                  key: model.qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    model.controller = controller;
                    controller.scannedDataStream.listen((scanData) {
                      debugPrint('Scanned Data---->${scanData.code}');
                      // if (model.result != null) {
                      //   return;
                      // }
                      model.controller?.pauseCamera();
                      model.result = scanData;
                      if (model.result!.code != null) {
                        model.extractResult(context, scanData);
                      }
                    });
                  },
                  overlay: QrScannerOverlayShape(
                      borderColor: Theme.of(context).accentColor,
                      borderRadius: 16,
                      borderLength: 125,
                      //overlayColor: AppColor.very_dark_blue.withOpacity(0.9),
                      //borderLength: 140,
                      cutOutSize: 256),
                  onPermissionSet: (ctrl, p) {
                    if (!p) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('no Permission')),
                      );
                    }
                  },
                );
              }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  //color: Colors.black.withOpacity(0.5),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Text(
                    S.of(context).payViaQR,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      S.of(context).payViaQRDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).accentColor),
                    ),
                  ),
                  SizedBox(height: 50),
                  InkWell(
                      onTap: () async {
                        ///LOG EVENT TO FIREBASE
                        await FirebaseAnalytics.instance.logEvent(
                          name: "qr_screen_dismissed",
                          parameters: {"is_qr_screen_dismissed": true.toString()},
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.white, borderRadius: BorderRadius.all(Radius.circular(100))),
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 15.w),
                        child: AppSvg.asset(AssetUtils.close, color: AppColor.brightBlue),
                      )),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
