import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/idwise_intial/idwise_intial_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class IdWiseIntialPageView extends BasePageViewWidget<IdWiseIntialPageViewModel> {
  IdWiseIntialPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, IdWiseIntialPageViewModel model) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 5.h),
      child: Column(
        children: [
          Center(
            child: Text(
              S.of(context).getReadyToScanYourId,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20.t,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 32.h),
          Expanded(
            child: Card(
              elevation: 10,
              shadowColor: Theme.of(context).colorScheme.onBackground,
              color: Theme.of(context).colorScheme.secondary,
              child: Container(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.w, end: 8.w, top: 12.h, bottom: 12.h),
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surfaceTint),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 4.w,
                      radius: Radius.circular(4),
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        gradientFractionOnEnd: 0.3,
                        gradientFractionOnStart: 0.25,
                        child: SingleChildScrollView(
                          controller: model.scrollController,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(end: 12.w),
                                child: Text(
                                  "Last revised: Sample Terms & Conditions \n\n By accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law. I further certify that I am not a U.S permanent resident and I do not hold a Green Card, andI further certify that I do not have a U.S residence or mailing/residential address or U.S corresponding address or telephone number, and I further certify that I do not make regular payments to or from financial institution in the U.S, andI further certify that I do not granted any power of attorney to a person who is defined as a U.S person, and\n \nBy accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law.",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 24.h, end: 12.w),
                                    child: Row(
                                      children: [
                                        AppStreamBuilder<bool>(
                                            stream: model.checkBoxStream,
                                            initialData: false,
                                            dataBuilder: (context, value) {
                                              return Container(
                                                height: 47.h,
                                                width: 47.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: value!
                                                        ? Theme.of(context).canvasColor
                                                        : Theme.of(context).colorScheme.secondary,
                                                    border: Border.all(
                                                        color:
                                                            Theme.of(context).colorScheme.onInverseSurface)),
                                                child: InkWell(
                                                  onTap: () {
                                                    model.checkBoxToggle(!value);
                                                  },
                                                  child: value ? Icon(Icons.check_rounded) : SizedBox(),
                                                ),
                                              );
                                            }),
                                        SizedBox(width: 10.w),
                                        Flexible(
                                          child: Text(
                                            S.of(context).termsAndConditions,
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: Theme.of(context).primaryColorDark,
                                                fontSize: 12.t,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppStreamBuilder<bool>(
                                    initialData: false,
                                    stream: model.buttonStream,
                                    dataBuilder: (context, value) {
                                      return AppPrimaryButton(
                                        isDisabled: !value!,
                                        padding: EdgeInsetsDirectional.only(top: 16.h, end: 12.w),
                                        onPressed: () {},
                                      );
                                    },
                                  ),
                                  SizedBox(height: 40.h),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 56.h),
        ],
      ),
    );
  }
}
