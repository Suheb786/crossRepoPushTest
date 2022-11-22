import 'package:domain/constants/enum/new_bills_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/asset_utils.dart';

import 'new_prepaid_bills_page_view.dart';
import 'new_prepaid_bills_page_view_model.dart';

class NewPrePaidBillsPage extends BasePage<NewPrePaidBillsPageViewModel> {
  @override
  NewPrePaidBillsPageState createState() => NewPrePaidBillsPageState();
}

class NewPrePaidBillsPageState extends BaseStatefulPage<NewPrePaidBillsPageViewModel, NewPrePaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return newPrePaidBillsPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NewPrePaidBillsPageViewModel model) {
    return NewPrePaidBillsPageView(provideBase());
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  void onModelReady(NewPrePaidBillsPageViewModel model) {
    model.newPrePaidBillsPageDataList = [
      NewPrePaidBillsPageData(AssetUtils.electricityIcon, S.of(context).waterAndElectricity,
          NewBillsTypeEnum.WATERANDELECTRICITY),
      NewPrePaidBillsPageData(
          AssetUtils.mobile, S.of(context).telecommunication, NewBillsTypeEnum.TELECOMMUNICATION),
      NewPrePaidBillsPageData(AssetUtils.governmentServiceIcon, S.of(context).governmentService,
          NewBillsTypeEnum.GOVERNMENTSERVICE),
      NewPrePaidBillsPageData(AssetUtils.dollarSvg, S.of(context).banks, NewBillsTypeEnum.BANKS),
      NewPrePaidBillsPageData(
          AssetUtils.financialService, S.of(context).financialServices, NewBillsTypeEnum.FINANCIALSERVICES),
      NewPrePaidBillsPageData(AssetUtils.gasfuelIcon, S.of(context).fuelAndGas, NewBillsTypeEnum.FUELANDGAS),
      NewPrePaidBillsPageData(AssetUtils.flightIcon, S.of(context).travelAndTransportation,
          NewBillsTypeEnum.TRAVELANDTRANSPORTATION),
    ];
    super.onModelReady(model);
  }
}
