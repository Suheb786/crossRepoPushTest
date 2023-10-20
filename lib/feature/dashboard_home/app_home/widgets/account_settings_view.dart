import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';
import '../../../sub_account/open_sub_account/open_sub_account_success/open_sub_account_success_page.dart';
import '../../../sub_account/transfer/select_transfer/select_transfer_page.dart';
import '../app_home_view_model.dart';
import 'app_home_page_widgets.dart';

class AccountSettingsView extends StatefulWidget {
  AppHomeViewModel model;

  AccountSettingsView(this.model);

  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  late AppHomeViewModel model;

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<Resource<GetDashboardDataResponse>>(
        stream: model.getDashboardDataStream,
        initialData: Resource.none(),
        dataBuilder: (context, cardData) {
          return AppStreamBuilder<Resource<CreateAccountResponse>>(
              stream: model.createAccountStream,
              initialData: Resource.none(),
              onData: (event) {
                if (event.status == Status.SUCCESS) {
                  Navigator.pushNamed(context, RoutePaths.OpenSubAccountSuccessPage,
                          arguments:
                              OpenSubAccountSuccessPageArgument(accountNo: model.accountNo, iban: model.iban))
                      .then((value) {
                    model.closeSubAccountDialogAndRefreshPage();
                  });
                }
              },
              dataBuilder: (context, createAccountResponse) {
                return Container(
                  padding: EdgeInsetsDirectional.only(start: 36.0.w, end: 36.w),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddMoneyTile(),
                      TransferBetweenAccountTile(
                        isVisible: (cardData?.data?.dashboardDataContent?.dashboardFeatures
                                    ?.transferBetweenAccountsFeature ??
                                false) &&
                            model.hasSubAccount(
                              (cardData?.data?.dashboardDataContent?.accounts ?? []),
                            ),
                        onTap: () {
                          var accounts = (cardData?.data?.dashboardDataContent?.accounts ?? []);
                          Navigator.pushNamed(
                            context,
                            RoutePaths.SelectTransferPage,
                            arguments: SelectTranferPageArgument(
                              selectedAccount: model.selectedAccount,
                              allAccountsList: /*model.getAllMyAccounts()*/
                                  accounts,
                            ),
                          );
                        },
                        isEnabled: true,
                        isCardActivated: true,
                      ),
                      OpenSubAccountTile(
                        isCardActivated:
                            (cardData?.data?.dashboardDataContent?.dashboardFeatures?.subAccountFeature ??
                                    false) &&
                                (cardData?.data?.dashboardDataContent?.allowSubAccount ?? false) &&
                                model.isSubAccountCanBeCreated(),
                        isEnabled:
                            (cardData?.data?.dashboardDataContent?.dashboardFeatures?.subAccountFeature ??
                                    false) &&
                                (cardData?.data?.dashboardDataContent?.allowSubAccount ?? false) &&
                                model.isSubAccountCanBeCreated(),
                        model: model,
                      ),
                      ShareAccountTile(context: context, model: model),
                      SizedBox(
                          height: (cardData?.data?.dashboardDataContent?.dashboardFeatures
                                          ?.transferBetweenAccountsFeature ??
                                      false) &&
                                  model.hasSubAccount(
                                    (cardData?.data?.dashboardDataContent?.accounts ?? []),
                                  )
                              ? 110.h
                              : 180.h),
                    ],
                  ),
                );
              });
        });
  }
}
