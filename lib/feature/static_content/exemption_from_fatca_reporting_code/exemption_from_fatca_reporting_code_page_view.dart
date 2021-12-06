import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/exemption_from_fatca_reporting_code/exemption_from_fatca_reporting_code_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ExemptionFromFatcaReportingCodePageView
    extends BasePageViewWidget<ExemptionFromFatcaReportingCodePageViewModel> {
  ExemptionFromFatcaReportingCodePageView(ProviderBase model) : super(model);

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
                '''The following codes identify payees that are exempt from reporting under FATCA. These codes apply to persons submitting this form for accounts maintained outside of the United States by certain foreign financial institutions. Therefore, if you are only submitting this form for an account you hold in the United States, you may leave this field blank. Consult with the person requesting this form if you are uncertain if the financial institution is subject to these requirements. A requester may indicate that a code is not required by providing you with a Form W-9 with “Not Applicable” (or any similar indication) written or printed on the line for a FATCA exemption code. 
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
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.bodyText1!.color),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                '''Note: You may wish to consult with the financial institution requesting this form to determine whether the FATCA code and/or exempt payee code should be completed.
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
