import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class ManageContactDetailsPage extends BasePage<ManageContactDetailsPageViewModel> {
  final Beneficiary _beneficiary;

  ManageContactDetailsPage(this._beneficiary);

  @override
  ManageContactDetailsPageState createState() => ManageContactDetailsPageState();
}

class ManageContactDetailsPageState
    extends BaseStatefulPage<ManageContactDetailsPageViewModel, ManageContactDetailsPage> {
  @override
  ProviderBase provideBase() {
    return manageContactDetailsViewModelProvider.call(widget._beneficiary);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85.h),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 24.0.w),
              child: AppSvg.asset(AssetUtils.leftArrow,
                  matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ));
  }

  @override
  void onModelReady(ManageContactDetailsPageViewModel model) {
    getViewModel().setData();
    getViewModel().getPurpose(getViewModel().beneficiary.accountNo!, "TransferI");
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ManageContactDetailsPageViewModel model) {
    return ManageContactDetailsPageView(provideBase());
  }
}
