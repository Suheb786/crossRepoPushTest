import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ClaimOfTaxTreatyBenefitsPageView extends BasePageViewWidget<ClaimOfTaxTreatyBenefitsPageViewModel> {
  ClaimOfTaxTreatyBenefitsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      height: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                model.arguments.staticRouteContent == StaticRouteContent.TAX_TREATY_BENEFITS
                    ? /*StringUtils.isDirectionRTL(context)
                        ? "تم تحديث التعليمات الخاصة بهذا الخط لتشمل الإقرارات المطلوبة من قبل الأفراد الذين يطالبون بمزايا الاتفاقية على أرباح الأعمال أو المكاسب التي لا تُنسب إلى منشأة دائمة ، بما في ذلك الشريك الأجنبي الذي يقود المكاسب الخاضعة للضريبة بموجب القسم 864 (ج) (8) عند نقل حصة في شراكة والذي سيخضع للحجب بموجب القسم 1446 (و). تم أيضًا تحديث التعليمات الخاصة بهذا البند لتشمل الإقرارات التي يطلبها الأفراد الذين يطالبون بمزايا الاتفاقية بموجب ضريبة متداخلة تنص على منافع متداخلة تتعلق بنظام ضريبي قائم على التحويلات."
                        :*/
                    '''The instructions for this line have been updated to include representations required by individuals claiming treaty benefits on business profits or gains not attributable to a permanent establishment, including for a foreign partner that derives gain subject to tax under section 864(c)(8) upon the transfer of an interest in a partnership and who would be subject to withholding under section 1446(f). The instructions for this line have also been updated to include representations required by individuals claiming treaty benefits under an income tax treaty that provides for treaty benefits related to a remittance-based tax system. 
                '''
                    : S.of(context).creditBureauAuthorizationDesc,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
