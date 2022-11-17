import 'package:domain/constants/enum/new_bills_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/asset_utils.dart';

import 'new_bills_page_view.dart';
import 'new_bills_page_view_model.dart';

class NewBillsPage extends BasePage<NewBillsPageViewModel> {
  @override
  NewBillsPageState createState() => NewBillsPageState();
}

class NewBillsPageState extends BaseStatefulPage<NewBillsPageViewModel, NewBillsPage> {
  @override
  ProviderBase provideBase() {
    return newBillsPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NewBillsPageViewModel model) {
    return NewBillsPageView(provideBase());
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  void onModelReady(NewBillsPageViewModel model) {
   /* model.newBillsPageDataList = [
      NewBillsPageData(AssetUtils.electricityIcon, S.of(context).waterAndElectricity,
          NewBillsTypeEnum.WATERANDELECTRICITY),
      NewBillsPageData(
          AssetUtils.mobile, S.of(context).telecommunication, NewBillsTypeEnum.TELECOMMUNICATION),
      NewBillsPageData(AssetUtils.governmentServiceIcon, S.of(context).governmentService,
          NewBillsTypeEnum.GOVERNMENTSERVICE),
      NewBillsPageData(AssetUtils.dollarSvg, S.of(context).banks, NewBillsTypeEnum.BANKS),
      NewBillsPageData(
          AssetUtils.financialService, S.of(context).financialServices, NewBillsTypeEnum.FINANCIALSERVICES),
      NewBillsPageData(AssetUtils.gasfuelIcon, S.of(context).fuelAndGas, NewBillsTypeEnum.FUELANDGAS),
      NewBillsPageData(AssetUtils.flightIcon, S.of(context).travelAndTransportation,
          NewBillsTypeEnum.TRAVELANDTRANSPORTATION),
    ];*/
    super.onModelReady(model);
  }
}
