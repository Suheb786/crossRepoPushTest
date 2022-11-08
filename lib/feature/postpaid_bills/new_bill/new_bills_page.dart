import 'package:domain/constants/enum/new_bills_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/*
  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 107),
        child: Padding(
          padding: const EdgeInsets.only(top: 52.0, bottom: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: AppSvg.asset(
                  AssetUtils.leftArrow,
                  color: AppColor.white,
                ),
              ),
              Text(
                S.of(context).payAllBills,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
              ),
              SizedBox.shrink(),
            ],
          ),
        ));
  }*/

  @override
  Widget buildView(BuildContext context, NewBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, child: NewBillsPageView(provideBase()));
  }

  @override
  void onModelReady(NewBillsPageViewModel model) {
    model.newBillsPageDataList = [
      NewBillsPageData(AssetUtils.electricityIcon, S.of(context).waterAndElectricity,
          NewBillsTypeEnum.WATERANDELECTRICITY),
      NewBillsPageData(
          AssetUtils.electricityIcon, S.of(context).telecommunication, NewBillsTypeEnum.TELECOMMUNICATION),
      NewBillsPageData(
          AssetUtils.electricityIcon, S.of(context).governmentService, NewBillsTypeEnum.GOVERNMENTSERVICE),
      NewBillsPageData(AssetUtils.electricityIcon, S.of(context).banks, NewBillsTypeEnum.BANKS),
      NewBillsPageData(
          AssetUtils.electricityIcon, S.of(context).financialServices, NewBillsTypeEnum.FINANCIALSERVICES),
      NewBillsPageData(AssetUtils.electricityIcon, S.of(context).fuelAndGas, NewBillsTypeEnum.FUELANDGAS),
      NewBillsPageData(AssetUtils.electricityIcon, S.of(context).travelAndTransportation,
          NewBillsTypeEnum.TRAVELANDTRANSPORTATION),
    ];
    super.onModelReady(model);
  }
}
