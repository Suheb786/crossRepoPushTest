import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/us_tax_payer_identification_number/us_tax_payer_identification_number_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class UsTaxPayerIdentificationNumberPageView
    extends BasePageViewWidget<UsTaxPayerIdentificationNumberPageViewModel> {
  UsTaxPayerIdentificationNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
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
                    ? '''إذا كان لديك رقم ضمان اجتماعي (SSN) ، أدخله هنا. للتقدم بطلب للحصول على SSN ، احصل على نموذج SS-5 من مكتب إدارة الضمان الاجتماعي (SSA) أو عبر الإنترنت على www.ssa.gov/forms/ss-5.pdf PDF. إذا كنت في الولايات المتحدة ، يمكنك الاتصال بـ SSA على الرقم 1-800-772-1213. أكمل النموذج SS-5 وأعده إلى SSA.
إذا لم يكن لديك رقم الضمان الاجتماعي (SSN) ولم تكن مؤهلاً للحصول عليه ، فيمكنك الحصول على رقم تعريف دافع الضرائب الفردي (ITIN). للتقدم بطلب للحصول على ITIN ، قم بتقديم نموذج W-7 لدى مصلحة الضرائب الأمريكية. عادةً ما يستغرق الحصول على ITIN من 4 إلى 6 أسابيع. للمطالبة ببعض مزايا الاتفاقية ، يجب عليك إكمال السطر 5 عن طريق تقديم SSN أو ITIN ، أو السطر 6 من خلال تقديم رقم تعريف ضريبي أجنبي (TIN الأجنبي).

ITIN للاستخدام الضريبي فقط. لا يخولك الحصول على مزايا الضمان الاجتماعي أو تغيير وضعك الوظيفي أو الهجرة بموجب قانون الولايات المتحدة.

من المرجح أن يتم تخصيص دخل خاضع للضريبة مرتبط بشكل فعال للشريك في شراكة يدير تجارة أو عملًا في الولايات المتحدة. يتعين على الشريك تقديم إقرار ضريبة الدخل الفيدرالية الأمريكية ويجب أن يكون لديه رقم تعريف دافع ضرائب أمريكي (TIN).

يجب عليك تقديم رقم الضمان الاجتماعي (SSN) أو رقم التعريف الضريبي (TIN) إذا كنت:

المطالبة بإعفاء من الاقتطاع الضريبي بموجب القسم 871 (و) لبعض المعاشات المستلمة بموجب خطط مؤهلة ، أو
تقديم النموذج إلى شراكة تمارس تجارة أو نشاطًا تجاريًا في الولايات المتحدة.
                '''
                    :*/
                '''If you have a social security number (SSN), enter it here. To apply for an SSN, get Form SS-5 from a Social Security Administration (SSA) office or online at www.ssa.gov/forms/ss-5.pdf PDF. If you are in the United States, you can call the SSA at 1-800-772-1213. Complete Form SS-5 and return it to the SSA.
If you do not have an SSN and are not eligible to get one, you can get an individual taxpayer identification number (ITIN). To apply for an ITIN, file Form W-7 with the IRS. It usually takes 4–6 weeks to get an ITIN. To claim certain treaty benefits, you must complete line 5 by submitting an SSN or ITIN, or line 6 by providing a foreign tax identification number (foreign TIN).

An ITIN is for tax use only. It does not entitle you to social security benefits or change your employment or immigration status under U.S. law.

A partner in a partnership conducting a trade or business in the United States will likely be allocated effectively connected taxable income. The partner is required to file a U.S. federal income tax return and must have a U.S. taxpayer identification number (TIN).

You must provide an SSN or TIN if you are:

Claiming an exemption from withholding under section 871(f) for certain annuities received under qualified plans, or
Submitting the form to a partnership that conducts a trade or business in the United States. 
                ''',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
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
