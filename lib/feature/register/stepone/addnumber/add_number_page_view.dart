import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AddNumberPageView extends BasePageViewWidget<AddNumberViewModel> {
  AddNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Text(
          S.of(context).accountRegistration,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 36.0, bottom: 32),
          child: Text(
            S.of(context).addMobileHeader,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.very_dark_gray,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
                decoration: BoxDecoration(
                  color: AppColor.very_soft_violet,
                  gradient: LinearGradient(colors: [
                    AppColor.dark_violet,
                    AppColor.dark_moderate_blue
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Center(
                    child: Text(
                  "Step Two",
                  style: TextStyle(color: AppColor.white),
                ))),
          ),
        ),
      ],
    );
  }
}
