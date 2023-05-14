import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/fatca_certification/fatca_certification_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FatcaCertificationPageView extends BasePageViewWidget<FatcaCertificationPageViewModel> {
  FatcaCertificationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 12.w),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? 'بموجب عقوبات الحنث باليمين ، أشهد أن:'
                    :*/
                'Under penalties of perjury, I certify that:',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Text(
                  /*StringUtils.isDirectionRTL(context)
                      ? '''١. الرقم الموضح في هذا النموذج هو رقم التعريف الصحيح لدافعي الضرائب (أو في انتظار إصدار رقم لي) ؛ و
٢. أنا لست خاضعًا للاقتطاع الضريبي الاحتياطي للأسباب التالية: (أ) أنا معفي من الاقتطاع الاحتياطي ، أو (ب) لم يتم إخطاري من قِبل دائرة الإيرادات الداخلية (IRS) بأنني خاضع للاقتطاع الضريبي الاحتياطي كنتيجة عدم الإبلاغ عن جميع الفوائد أو أرباح الأسهم ، أو (ج) أخطرتني مصلحة الضرائب بأنني لم أعد خاضعًا للاقتطاع الاحتياطي ؛ و
٣. أنا مواطن أمريكي أو شخص أمريكي آخر (المحدد أدناه) ؛ و
٤. رمز (رموز) قانون الامتثال الضريبي للحسابات الخارجية المُدخل في هذا النموذج (إن وجد) يشير إلى أنني معفي من الإبلاغ عن قانون الامتثال الضريبي للحسابات الخارجية صحيح.
                  '''
                      :*/
                  '''1. The number shown on this form is my correct taxpayer identification number (or I am waiting for a number to be issued to me); and
2. I am not subject to backup withholding because: (a) I am exempt from backup withholding, or (b) I have not been notified by the Internal Revenue Service (IRS) that I am subject to backup withholding as a result of a failure to report all interest or dividends, or (c) the IRS has notified me that I am no longer subject to backup withholding; and
3. I am a U.S. citizen or other U.S. person (defined below); and
4. The FATCA code(s) entered on this form (if any) indicating that I am exempt from FATCA reporting is correct.
                  ''',
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''تعليمات الاعتماد. يجب شطب العنصر 2 أعلاه إذا تم إخطارك من قِبل مصلحة الضرائب الأمريكية بأنك تخضع حاليًا للخصم المقتطع بسبب
فشلت في الإبلاغ عن جميع الفوائد والأرباح على إقرارك الضريبي. بالنسبة للمعاملات العقارية ، لا ينطبق البند 2. لفائدة الرهن العقاري المدفوعة ،
اقتناء أو التخلي عن الممتلكات المضمونة ، وإلغاء الديون ، والمساهمات في ترتيبات التقاعد الفردي (IRA) ، والمدفوعات بشكل عام
بخلاف الفوائد والأرباح ، لا يلزمك التوقيع على الشهادة ، ولكن يجب عليك تقديم رقم التعريف الضريبي الصحيح.
                  '''
                    :*/
                '''Certification instructions. You must cross out item 2 above if you have been notified by the IRS that you are currently subject to backup withholding because
you have failed to report all interest and dividends on your tax return. For real estate transactions, item 2 does not apply. For mortgage interest paid,
acquisition or abandonment of secured property, cancellation of debt, contributions to an individual retirement arrangement (IRA), and generally, payments
other than interest and dividends, you are not required to sign the certification, but you must provide your correct TIN.
                  ''',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
