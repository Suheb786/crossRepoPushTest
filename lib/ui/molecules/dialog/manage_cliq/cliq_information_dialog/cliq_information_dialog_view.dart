import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
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
  final bool onWillPop;

  const CliqInformationDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.description,
      required this.subDescription,
      this.isSwipeToCancel = true,
      this.onWillPop = true});

  ProviderBase providerBase() {
    return cliqInformationDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<CliqInformationDialogViewModel>(
        providerBase: providerBase(),
        builder: (BuildContext context, model, child) {
          return Dialog(
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 204.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 32.h),
                            image != null ? AppSvg.asset(image!, height: 40.h, width: 40.w) : Container(),
                            SizedBox(height: 25.h),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.very_dark_gray,
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 20.t,
                                  fontWeight: FontWeight.w700),
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
                                    child: AppPrimaryButton(
                                      onPressed: () {
                                        onSelected!.call();
                                      },
                                      text: S.of(context).confirm,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 42.h),
                          ],
                        ),
                      )),
                  AppStreamBuilder<bool>(
                    stream: model.selectedStream,
                    initialData: false,
                    dataBuilder: (BuildContext context, data) {
                      return Positioned(
                        bottom: -24.h,
                        child: InkWell(
                          onTap: () {
                            onDismissed?.call();
                          },
                          child: Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.secondary),
                              child: Image.asset(
                                AssetUtils.close_bold,
                                scale: 3.5,
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }
}
