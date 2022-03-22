import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page_view.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AllContactPage extends BasePage<AllContactPageViewModel> {
  final AllContactArguments _arguments;

  AllContactPage(this._arguments);

  @override
  AllContactPageState createState() => AllContactPageState();
}

class AllContactPageState
    extends BaseStatefulPage<AllContactPageViewModel, AllContactPage> {
  @override
  ProviderBase provideBase() {
    return allContactsViewModelProvider.call(widget._arguments);
  }

  @override
  void onModelReady(AllContactPageViewModel model) {
    model.setBeneficiaryList(model.arguments.beneficiaryList);
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85),
      child: GestureDetector(
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: AppSvg.asset(AssetUtils.leftArrow,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Text(
                S.of(context).manageContacts,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Container(
                  width: 28,
                ),
              )
            ],
          )),
    );
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
  Widget buildView(BuildContext context, AllContactPageViewModel model) {
    return AllContactPageView(provideBase());
  }
}

class AllContactArguments {
  final List<Beneficiary> beneficiaryList;

  AllContactArguments({required this.beneficiaryList});
}
