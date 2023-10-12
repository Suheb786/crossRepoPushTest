import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadTransactionPageView extends BasePageViewWidget<DownloadTransactionViewModel> {
  DownloadTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 52.0.h, bottom: 0.h),
          height: 80.h,
          child: Text(
            model.arguments.transactionDate + " ${S.of(context).statement}",
            textAlign: TextAlign.center,
            softWrap: false,
            style: TextStyle(
                fontSize: 14.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AppKeyBoardHide(
                child: Container(
                  height: double.infinity,
                  margin: EdgeInsetsDirectional.only(top: 24.h),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                  child: AppStreamBuilder<Resource<CardStatementResponse>>(
                      stream: model.cardStatementStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, statementResponse) {
                        return Column(
                          children: [
                            SizedBox(height: 47.h),
                            statementResponse!.status == Status.SUCCESS
                                ? Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 0.0.h, start: 24.0.w, end: 24.0.w),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height / 2,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.white_gray, width: 1)),
                                      width: double.infinity,
                                      child: SfPdfViewer.memory(
                                        statementResponse.data!.cardStatementContent!.pdfUint8List,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    width: double.infinity,
                                  ),
                            InkWell(
                              onTap: () async {
                                if (statementResponse.status == Status.SUCCESS) {
                                  _shareFiles(context,
                                      await statementResponse.data!.cardStatementContent!.pdfBase64String);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(top: 32.0.h, start: 48.0.w, end: 48.0.w),
                                child: Container(
                                  height: 50.0.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!)),
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).sharePdf,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 12.0.t,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      AppSvg.asset(AssetUtils.share,
                                          color: Theme.of(context).primaryColorDark)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24.0.h),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 57.0.h,
                                  width: 57.0.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).textTheme.bodyLarge!.color!),
                                  child: Center(
                                    child: AppSvg.asset(AssetUtils.tick,
                                        color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    // ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateBackToMainPage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                        ]),
                    child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _shareFiles(BuildContext context, File file) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareXFiles([XFile(file.path)],
        subject: 'Statement PDF', sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
