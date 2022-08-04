import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/exemption_from_fatca_reporting_code/exemption_from_fatca_reporting_code_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ExemptionFromFatcaReportingCodePageView
    extends BasePageViewWidget<ExemptionFromFatcaReportingCodePageViewModel> {
  ExemptionFromFatcaReportingCodePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 12),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''تحدد الرموز التالية المستفيدين المعفيين من الإبلاغ بموجب قانون الامتثال الضريبي للحسابات الخارجية. تنطبق هذه الرموز على الأشخاص الذين يقدمون هذا النموذج للحسابات التي تحتفظ بها مؤسسات مالية أجنبية معينة خارج الولايات المتحدة. لذلك ، إذا كنت ترسل هذا النموذج فقط لحساب تملكه في الولايات المتحدة ، فيمكنك ترك هذا الحقل فارغًا. استشر الشخص الذي يطلب هذا النموذج إذا لم تكن متأكدًا مما إذا كانت المؤسسة المالية تخضع لهذه المتطلبات. قد يشير مقدم الطلب إلى أن الرمز غير مطلوب من خلال تزويدك باستمارة W-9 مع "غير منطبق" (أو أي مؤشر مشابه) مكتوبًا أو مطبوعًا على سطر رمز الإعفاء من قانون الامتثال الضريبي للحسابات الخارجية.   '''
                    :*/
                '''The following codes identify payees that are exempt from reporting under FATCA. These codes apply to persons submitting this form for accounts maintained outside of the United States by certain foreign financial institutions. Therefore, if you are only submitting this form for an account you hold in the United States, you may leave this field blank. Consult with the person requesting this form if you are uncertain if the financial institution is subject to these requirements. A requester may indicate that a code is not required by providing you with a Form W-9 with “Not Applicable” (or any similar indication) written or printed on the line for a FATCA exemption code. 
                ''',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyText1!.color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''منظمة معفاة من الضرائب بموجب المادة 501 (أ) أو أي خطة تقاعد فردية على النحو المحدد في القسم 7701 (أ) (37).

ب. الولايات المتحدة أو أي من وكالاتها أو هيئاتها.

ج- ولاية ، أو منطقة كولومبيا ، أو كومنولث أمريكي أو حيازة ، أو أي من أقسامها أو أدواتها السياسية.

د- شركة يتم تداول أسهمها بانتظام في واحد أو أكثر من أسواق الأوراق المالية ، كما هو موضح في قسم اللوائح 1.1472-1 (c) (1) (i).

هـ. شركة عضو في نفس المجموعة التابعة الموسعة كشركة موصوفة في قسم اللوائح رقم 1.1472-1 (c) (1) (i).

تاجر في الأوراق المالية أو السلع أو الأدوات المالية المشتقة (بما في ذلك العقود الرئيسية الافتراضية ، والعقود الآجلة ، والعقود الآجلة ، والخيارات) التي تم تسجيلها على هذا النحو بموجب قوانين الولايات المتحدة أو أي ولاية.

ز- صندوق استثمار عقاري.

ح. شركة استثمار منظمة على النحو المحدد في القسم 851 أو كيان مسجل في جميع الأوقات خلال السنة الضريبية بموجب قانون شركة الاستثمار لعام 1940.

أولا - صندوق استئماني مشترك على النحو المحدد في البند 584 (أ).

ياء - بنك على النحو المحدد في القسم 581.

ك وسيط

L. ائتمان معفى من الضريبة بموجب
القسم 664 أو الموضحة في القسم 4947 (أ) (1).

ائتمان معفي من الضرائب بموجب خطة القسم 403 (ب) أو خطة القسم 457 (ز).
                '''
                    :*/
                '''A. An organization exempt from tax under section 501(a) or any individual retirement plan as defined in section 7701(a)(37). 

B. The United States or any of its agencies or instrumentalities.

C. A state, the AREA of Columbia, a U.S. commonwealth or possession, or any of their political subdivisions or instrumentalities.
 
D. A corporation the stock of which is regularly traded on one or more established securities markets, as described in Regulations section 1.1472-1(c)(1)(i).

E. A corporation that is a member of the same expanded affiliated group as a corporation described in Regulations section 1.1472-1(c)(1)(i).
 
F. A dealer in securities, commodities, or derivative financial instruments (including notional principal contracts, futures, forwards, and options) that is registered as such under the laws of the United States or any state.
 
G. A real estate investment trust.
 
H. A regulated investment company as defined in section 851 or an entity registered at all times during the tax year under the Investment Company Act of 1940.
 
I. A common trust fund as defined in section 584(a).
 
J. A bank as defined in section 581.

K. A broker 

L. A trust exempt from tax under 
section 664 or described in section 4947(a)(1).

M. A tax exempt trust under a section 403(b) plan or section 457(g) plan.
                ''',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyText1!.color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''ملاحظة: قد ترغب في استشارة المؤسسة المالية التي تطلب هذا النموذج لتحديد ما إذا كان يجب إكمال رمز قانون الامتثال الضريبي للحسابات الخارجية و / أو رمز المدفوع لأمره المعفي. '''
                    :*/
                '''Note: You may wish to consult with the financial institution requesting this form to determine whether the FATCA code and/or exempt payee code should be completed.
                  ''',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyText1!.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
