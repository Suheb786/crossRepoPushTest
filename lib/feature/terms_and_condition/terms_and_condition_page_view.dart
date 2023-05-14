import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class TermsAndConditionPageView extends BasePageViewWidget<TermsAndConditionPageViewModel> {
  TermsAndConditionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(end: 8),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                StringUtils.isDirectionRTL(context)
                    ? 'آخر مراجعة: نموذج الشروط والأحكام'
                    : 'Last revised: Sample Terms & Conditions',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.very_dark_gray_black),
              ),
              SizedBox(
                height: 21,
              ),
              Text(
                StringUtils.isDirectionRTL(context)
                    ? 'من خلال الوصول إلى موقع الويب هذا ، فإنك توافق على الالتزام بشروط وأحكام استخدام موقع الويب هذه ، وجميع القوانين واللوائح المعمول بها ، وتوافق على أنك مسؤول عن الامتثال لأي قوانين محلية معمول بها. إذا كنت لا توافق على أي من هذه الشروط ، فيحظر عليك استخدام أو الوصول إلى هذا الموقع. المواد الواردة في هذا الموقع محمية بموجب قانون حقوق النشر والعلامات التجارية المعمول به.'
                    : 'By accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law.',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.very_dark_gray_black),
              ),
              SizedBox(
                height: 31,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1.',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.very_dark_gray_black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      StringUtils.isDirectionRTL(context)
                          ? 'أشهد أيضًا أنني لست مقيمًا دائمًا في الولايات المتحدة ولا أحمل البطاقة الخضراء ، و'
                          : 'I further certify that I am not a U.S permanent resident and I do not hold a Green Card, and',
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.very_dark_gray_black),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2.',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.very_dark_gray_black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      StringUtils.isDirectionRTL(context)
                          ? 'أقر كذلك بأنني لا أمتلك محل إقامة أو عنوان بريدي / سكني في الولايات المتحدة أو عنوان أو رقم هاتف في الولايات المتحدة ، و p'
                          : 'I further certify that I do not have a U.S residence or mailing/residential address or U.S corresponding address or telephone number, andp',
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.very_dark_gray_black),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3.',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.very_dark_gray_black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      StringUtils.isDirectionRTL(context)
                          ? 'كما أقر بأنني لا أقوم بسداد مدفوعات منتظمة من أو إلى مؤسسة مالية في الولايات المتحدة ، و'
                          : 'I further certify that I do not make regular payments to or from financial institution in the U.S, and',
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.very_dark_gray_black),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4.',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.very_dark_gray_black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      StringUtils.isDirectionRTL(context)
                          ? 'كما أقر بأنني لم أمنح أي توكيل رسمي لأي شخص يتم تعريفه على أنه شخص أمريكي ، و'
                          : 'I further certify that I do not granted any power of attorney to a person who is defined as a U.S person, and',
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.very_dark_gray_black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 21,
              ),
              Text(
                StringUtils.isDirectionRTL(context)
                    ? 'من خلال الوصول إلى موقع الويب هذا ، فإنك توافق على الالتزام بشروط وأحكام استخدام موقع الويب هذه ، وجميع القوانين واللوائح المعمول بها ، وتوافق على أنك مسؤول عن الامتثال لأي قوانين محلية معمول بها. إذا كنت لا توافق على أي من هذه الشروط ، فيحظر عليك استخدام أو الوصول إلى هذا الموقع. المواد الواردة في هذا الموقع محمية بموجب قانون حقوق النشر والعلامات التجارية المعمول به.'
                    : 'By accessing this web site, you are agreeing to be bound by these web site Terms and Conditions of Use, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this web site are protected by applicable copyright and trade mark law.',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
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
