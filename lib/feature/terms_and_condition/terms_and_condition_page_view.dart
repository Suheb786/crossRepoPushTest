import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class TermsAndConditionPageView
    extends BasePageViewWidget<TermsAndConditionPageViewModel> {
  TermsAndConditionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 8),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Last revised: Sample Terms & Conditions',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.very_dark_gray_black),
              ),
              SizedBox(
                height: 21,
              ),
              Text(
                'By accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.very_dark_gray_black),
              ),
              SizedBox(
                height: 31,
              ),
              Text(
                '''1. I further certify that I am not a U.S permanent resident and I do not hold a Green Card, and \n2. I further certify that I do not have a U.S residence or mailing/residential address or U.S corresponding address or telephone number, andp \n3. I further certify that I do not make regular payments to or from financial institution in the U.S, and\n4. I further certify that I do not granted any power of attorney to a person who is defined as a U.S person, and
                  ''',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.very_dark_gray_black),
              ),
              SizedBox(
                height: 21,
              ),
              Text(
                'By accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.very_dark_gray_black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
