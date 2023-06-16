import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../utils/navgition_type.dart';
import 'beneficiary_contact_details_page_view.dart';
import 'beneficiary_contact_details_page_view_model.dart';

class BeneficiaryContactDetailsPage extends BasePage<BeneficiaryContactDetailsPageViewModel> {
  final dynamic _beneficiaryInformation;

  BeneficiaryContactDetailsPage(this._beneficiaryInformation);

  @override
  State<StatefulWidget> createState() => BeneficiaryContactDetailsPageState();
}

class BeneficiaryContactDetailsPageState
    extends BaseStatefulPage<BeneficiaryContactDetailsPageViewModel, BeneficiaryContactDetailsPage> {
  @override
  Widget buildView(BuildContext context, BeneficiaryContactDetailsPageViewModel model) =>
      BeneficiaryContactDetailsPageView(provideBase());

  @override
  ProviderBase provideBase() =>
      beneficiaryContactAddedPageViewModelProvider.call(widget._beneficiaryInformation);

  @override
  void onModelReady(BeneficiaryContactDetailsPageViewModel model) {
    final provider = ProviderScope.containerOf(context).read(
      beneficiaryContactListPageViewModelProvider,
    );
    model.navigationType = provider.navigationType!;
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return getViewModel().navigationType! == NavigationType.REQUEST_MONEY
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.0.h),
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h, top: 50.h),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                final provider = ProviderScope.containerOf(context).read(
                  beneficiaryContactListPageViewModelProvider,
                );
                if (provider.isNewRecordCreated || getViewModel().isUpdateProfile) {
                  provider.getBeneficiaryList(isFromSearch: false);
                }
                Navigator.pop(context);
              },
              child: AppSvg.asset(AssetUtils.back,
                  height: 24.h,
                  width: 24.w,
                  matchTextDirection: true,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }
}
