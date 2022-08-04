import 'dart:io';

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
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadTransactionPageView extends BasePageViewWidget<DownloadTransactionViewModel> {
  DownloadTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(top: 52),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta!.isNegative) {
            } else {
              // ProviderScope.containerOf(context)
              //     .read(homeViewModelProvider)
              //     .homeController
              //     .jumpToPage(0);
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: Center(
                    child: Text(
                      model.arguments.transactionDate + " ${S.of(context).statement}",
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 4,
                              width: 64,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4), color: AppColor.white_gray),
                            ),
                          ),
                          AppStreamBuilder<Resource<CardStatementResponse>>(
                              stream: model.cardStatementStream,
                              initialData: Resource.none(),
                              dataBuilder: (context, statementResponse) {
                                return Column(
                                  children: [
                                    statementResponse!.status == Status.SUCCESS
                                        ? Padding(
                                            padding: EdgeInsetsDirectional.only(top: 38, start: 24, end: 24),
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
                                          _shareFiles(
                                              context,
                                              await statementResponse
                                                  .data!.cardStatementContent!.pdfBase64String);
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(top: 32, start: 48, end: 48),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                  color:
                                                      Theme.of(context).accentTextTheme.bodyText1!.color!)),
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                S.of(context).sharePdf,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 12,
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
                                      padding: EdgeInsets.only(top: 24),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 57,
                                          width: 57,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).accentTextTheme.bodyText1!.color),
                                          child: Center(
                                            child: AppSvg.asset(AssetUtils.tick,
                                                color: Theme.of(context).accentColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _shareFiles(BuildContext context, File file) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareFiles([file.path],
        subject: 'Statement PDF', sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
