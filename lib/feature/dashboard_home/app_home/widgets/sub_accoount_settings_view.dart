import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../utils/resource.dart';
import '../../../sub_account/transfer/select_transfer/select_transfer_page.dart';
import '../app_home_view_model.dart';
import 'app_home_page_widgets.dart';

class SubAccountSettingsView extends StatefulWidget {
  AppHomeViewModel model;

  SubAccountSettingsView(this.model);

  @override
  State<SubAccountSettingsView> createState() => _SubAccountSettingsViewState();
}

class _SubAccountSettingsViewState extends State<SubAccountSettingsView> {
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
          return Padding(
            padding: EdgeInsetsDirectional.only(start: 36.0.w, end: 36.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TransferBetweenAccountTile(
                  isEnabled: (cardData
                          ?.data?.dashboardDataContent?.dashboardFeatures?.transferBetweenAccountsFeature ??
                      false),
                  isCardActivated: (cardData
                          ?.data?.dashboardDataContent?.dashboardFeatures?.transferBetweenAccountsFeature ??
                      false),
                  onTap: () {
                    var accounts = (cardData?.data?.dashboardDataContent?.accounts ?? []);
                    Navigator.pushNamed(
                      context,
                      RoutePaths.SelectTransferPage,
                      arguments: SelectTranferPageArgument(
                        selectedAccount: model.selectedAccount,
                        allAccountsList: accounts,
                      ),
                    );
                  },
                ),
                ShareAccountTile(
                  context: context,
                  model: model,
                  isCardActivated: (cardData
                          ?.data?.dashboardDataContent?.dashboardFeatures?.shareAccountInformationFeature ??
                      false),
                  isEnabled: (cardData
                          ?.data?.dashboardDataContent?.dashboardFeatures?.shareAccountInformationFeature ??
                      false),
                ),
                CloseSubAccount(
                  model: model,
                  isCardActivated:
                      (cardData?.data?.dashboardDataContent?.dashboardFeatures?.closeSubAccountFeature ??
                          false),
                  isEnabled:
                      (cardData?.data?.dashboardDataContent?.dashboardFeatures?.closeSubAccountFeature ??
                          false),
                ),
                SizedBox(height: 180.h),
              ],
            ),
          );
        });
  }
}
