import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/exempt_payee_code/exempt_payee_code_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ExemptPayeeCodePageView
    extends BasePageViewWidget<ExemptPayeeCodePageViewModel> {
  ExemptPayeeCodePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 12),
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '''• Generally, individuals (including sole proprietors) are not exempt from backup withholding.
• Except as provided below, corporations are exempt from backup withholding for certain payments, including interest and dividends. 
• Corporations are not exempt from backup withholding for payments made in settlement of payment card or third party network transactions.
• Corporations are not exempt from backup withholding with respect to attorneys’ fees or gross proceeds paid to attorneys, and corporations that provide medical or health care services are not exempt with respect to payments reportable on Form 1099-MISC. 
• The following codes identify payees that are exempt from backup withholding. Enter the appropriate code in the field text.
                ''',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme
                        .of(context)
                        .primaryTextTheme
                        .bodyText1!
                        .color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
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
                    color: Theme
                        .of(context)
                        .primaryTextTheme
                        .bodyText1!
                        .color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                '''See Form 1099-MISC, Miscellaneous Income, and its instructions. However, the following payments made to a corporation and reportable on Form 1099-MISC are not exempt from backup withholding: medical and health care payments, attorneys’ fees, gross proceeds paid to an attorney reportable under section 6045(f), and payments for services paid by a federal executive agency. 

                  ''',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme
                        .of(context)
                        .primaryTextTheme
                        .bodyText1!
                        .color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
