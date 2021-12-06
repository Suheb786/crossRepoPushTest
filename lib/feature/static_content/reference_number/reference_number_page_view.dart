import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/static_content/reference_number/reference_number_page_view-model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReferenceNumberPageView
    extends BasePageViewWidget<ReferenceNumberPageViewModel> {
  ReferenceNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      height: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Scrollbar(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '''This line may be used by the filer of Form W-8BEN or by the withholding agent to whom it is provided to include any referencing information that is useful to the withholding agent in carrying out its obligations. For example, withholding agents who are required to associate the Form W-8BEN with a particular Form W-8IMY may want to use line 7 for a referencing number or code that will make the association clear. A beneficial owner can use line 7 to include the number of the account for which he or she is providing the form. A foreign single owner of a disregarded entity can use line 7 to inform the withholding agent that the account to which a payment is made or credited is in the name of the disregarded entity 
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
