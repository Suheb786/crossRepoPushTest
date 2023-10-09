import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/app_svg.dart';
import '../../../utils/asset_utils.dart';

class ClaimOfTaxTreatyBenefitsPageView extends BasePageViewWidget<ClaimOfTaxTreatyBenefitsPageViewModel> {
  ClaimOfTaxTreatyBenefitsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 52.0.h, bottom: 0.h),
            height: 80.h,
            child: Text(
              model.arguments.staticRouteContent ==
                  StaticRouteContent.TAX_TREATY_BENEFITS
                  ? S.of(context).claimOfTaxTreatyBenefits
                  : S.of(context).creditBureauAuthorization,
              textAlign: TextAlign.center,
              softWrap: false,
              style: TextStyle(
                  fontSize: 14.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(top: 24.h),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 47.h),
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
                ),
                Positioned(
                  top: 0.h,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48.h,
                      width: 48.h,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                          ]),
                      child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
