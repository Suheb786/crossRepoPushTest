import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/cliq_term_condition_selection_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'cliq_information_dialog_view_model.dart';

class CliqInformationDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final String description;
  final String subDescription;

  const CliqInformationDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.description,
      required this.subDescription,
      this.isSwipeToCancel: true});

  ProviderBase providerBase() {
    return cliqInformationDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CliqInformationDialogViewModel>(
      providerBase: providerBase(),
      builder: (BuildContext context, model, child) {
        return Dialog(
            insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: WillPopScope(
              onWillPop: () async => false,
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    onDismissed?.call();
                  }
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 32.h),
                          image != null ? AppSvg.asset(image!, height: 50.h, width: 50.w) : Container(),
                          SizedBox(height: 25.h),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.very_dark_gray,
                                fontFamily: StringUtils.appFont,
                                fontSize: 20.t,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            description,
                            //  textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.veryDarkGray1,
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.t,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 32.h),
                          AppStreamBuilder<bool>(
                            stream: model!.selectedStream,
                            initialData: false,
                            dataBuilder: (BuildContext context, isSelected) {
                              return CliqTermConditionSelectionWidget(
                                subDescription: subDescription,
                                isSelected: isSelected,
                                unMarkSelected: () {
                                  model.isSelected(false);
                                },
                                markSelected: () {
                                  model.isSelected(true);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 32.h),
                          AppStreamBuilder<bool>(
                            stream: model.selectedStream,
                            initialData: false,
                            dataBuilder: (BuildContext context, data) {
                              return InkWell(
                                onTap: () {
                                  onSelected!.call();
                                },
                                child: Visibility(
                                  visible: data ?? false,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 57.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                    child:
                                        AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 16.h),
                            child: Visibility(
                              visible: isSwipeToCancel ?? true,
                              child: InkWell(
                                onTap: () {
                                  onDismissed!.call();
                                },
                                child: Center(
                                  child: Text(
                                    S.of(context).swipeDownToCancel,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10.t,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.dark_gray_1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ));
      },
    );
  }
}
