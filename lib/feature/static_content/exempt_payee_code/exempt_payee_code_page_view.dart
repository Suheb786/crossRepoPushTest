import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ExemptPayeeCodePageView extends BasePageViewWidget<ExemptPayeeCodePageViewModel> {
  ExemptPayeeCodePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(end: 12),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''• بشكل عام ، لا يتم إعفاء الأفراد (بما في ذلك المالكين الفرديين) من حجب النسخ الاحتياطي.
• باستثناء ما هو منصوص عليه أدناه ، تُعفى الشركات من الاقتطاع الاحتياطي لمدفوعات معينة ، بما في ذلك الفوائد والأرباح.
• لا تُعفى الشركات من الاقتطاع الاحتياطي للمدفوعات التي تتم لتسوية بطاقات الدفع أو معاملات شبكة الطرف الثالث.
• لا تُعفى الشركات من الاقتطاع الاحتياطي فيما يتعلق بأتعاب المحاماة أو إجمالي العائدات المدفوعة للمحامين ، ولا تُعفى الشركات التي تقدم خدمات الرعاية الطبية أو الصحية فيما يتعلق بالمدفوعات الواجب الإبلاغ عنها في النموذج 1099-MISC.
• تحدد الرموز التالية المستفيدين المعفيين من الاقتطاع الاحتياطي. أدخل الرمز المناسب في نص الحقل.
                '''
                    :*/
                '''• Generally, individuals (including sole proprietors) are not exempt from backup withholding.
• Except as provided below, corporations are exempt from backup withholding for certain payments, including interest and dividends. 
• Corporations are not exempt from backup withholding for payments made in settlement of payment card or third party network transactions.
• Corporations are not exempt from backup withholding with respect to attorneys’ fees or gross proceeds paid to attorneys, and corporations that provide medical or health care services are not exempt with respect to payments reportable on Form 1099-MISC. 
• The following codes identify payees that are exempt from backup withholding. Enter the appropriate code in the field text.
                ''',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyText1!.color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''١. مؤسسة معفاة من الضرائب بموجب المادة 501 (أ) ، أو أي حساب IRA ، أو حساب وصاية بموجب القسم 403 (ب) (7) إذا كان الحساب يفي بمتطلبات القسم 401 (و) (2).
٢. الولايات المتحدة أو أي من وكالاتها أو مؤسساتها.
٣. ولاية ، أو منطقة كولومبيا ، أو كومنولث أمريكي أو حيازة ، أو أي من أقسامها أو أدواتها السياسية.
٤. حكومة أجنبية أو أي من أقسامها أو وكالاتها أو أدواتها السياسية.
٥. شركة
٦. تاجر في الأوراق المالية أو السلع المطلوبة للتسجيل في الولايات المتحدة ، أو منطقة كولومبيا ، أو الكومنولث الأمريكي أو الحيازة.
٧. تاجر بعمولة آجلة مسجل لدى لجنة تداول السلع الآجلة 8 - صندوق استثمار عقاري.
٨. كيان مسجل في جميع الأوقات خلال السنة الضريبية بموجب قانون شركة الاستثمار لعام 1940.
٩. صندوق استئماني مشترك يديره بنك بموجب المادة 584 (أ).
١٠. مؤسسة مالية.
١١. وسيط معروف في مجتمع الاستثمار بالمرشح أو أمين الحفظ.
١٢. ائتمان معفي من الضرائب بموجب القسم 664 أو موصوف في القسم 4947.
                '''
                    :*/
                '''1. An organization exempt from tax under section 501(a), any IRA, or a custodial account under section 403(b)(7) if the account satisfies the requirements of section 401(f)(2) .
2. The United States or any of its agencies or instrumentalities .
3. A state, the AREA of Columbia, a U.S. commonwealth or possession, or any of their political subdivisions or instrumentalities.
4. A foreign government or any of its political subdivisions, agencies, or instrumentalities.
5. A corporation 
6. A dealer in securities or commodities required to register in the United States, the AREA of Columbia, or a U.S. commonwealth or possession.
7. A futures commission merchant registered with the Commodity Futures Trading Commission 8—A real estate investment trust.
8. An entity registered at all times during the tax year under the Investment Company Act of 1940.
9. A common trust fund operated by a bank under section 584(a).
10. A financial institution.
11. A middleman known in the investment community as a nominee or custodian.
12. A trust exempt from tax under section 664 or described in section 4947.
                ''',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyText1!.color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                /*StringUtils.isDirectionRTL(context)
                    ? '''انظر نموذج 1099-MISC ، الدخل المتنوع ، وتعليماته. ومع ذلك ، فإن المدفوعات التالية المقدمة إلى شركة والتي يجب الإبلاغ عنها في النموذج 1099-MISC لا تُعفى من الاقتطاع الاحتياطي: مدفوعات الرعاية الطبية والصحية ، وأتعاب المحاماة ، وإجمالي العائدات المدفوعة للمحامي الواجب الإبلاغ عنه بموجب القسم 6045 (و) ، والمدفوعات مقابل الخدمات التي تدفعها وكالة تنفيذية اتحادية.
                  '''
                    :*/
                '''See Form 1099-MISC, Miscellaneous Income, and its instructions. However, the following payments made to a corporation and reportable on Form 1099-MISC are not exempt from backup withholding: medical and health care payments, attorneys’ fees, gross proceeds paid to an attorney reportable under section 6045(f), and payments for services paid by a federal executive agency. 

                  ''',
                style: TextStyle(
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
