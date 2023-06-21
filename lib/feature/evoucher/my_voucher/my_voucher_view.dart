import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/evoucher/my_voucher_item_view.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/app_divider.dart';
import '../../../ui/molecules/app_keyboard_hide.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog.dart';
import '../evoucher/evoucher_view_model.dart';

class MyVoucherView extends BasePageViewWidget<EvoucherViewModel> {
  MyVoucherView(ProviderBase model) : super(model);

  List<dynamic> _elements = [
    {
      'date': '16 September',
      'item': [
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
      ]
    },
    {
      'date': '18 September',
      'item': [
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
      ]
    },
    {
      'date': '20 September',
      'item': [
        {
          'status': 'Pending',
          'title': "FIFA 22 Promo Packs Lorem Ipsum",
          "amt": '5000',
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: ListView(
        padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
        children: [
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  labelText: "",
                  controller: model.myVoucherSearchController,
                  hintText: S.of(context).eVoucherSearchLabel,
                  containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  onChanged: (value) {
                    // model.searchBillName(value);
                  },
                  suffixIcon: (value, data) {
                    return InkWell(
                      onTap: () async {},
                      child: Container(
                          height: 16.0.h,
                          width: 16.0.w,
                          padding: EdgeInsets.all(6),
                          child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                    );
                  },
                ),
              ),
              SizedBox(width: 24.w),
              InkWell(
                onTap: () {
                  RelationshipWithCardHolderDialog.show(context,
                      title: S.of(context).transaction_period,
                      relationSHipWithCardHolder: ['Last 30 days', 'Last 60 days', 'Last 90 days'],
                      onDismissed: () {
                    Navigator.pop(context);
                  }, onSelected: (value) {
                    Navigator.pop(context);
                  });
                },
                child: AppSvg.asset(
                  AssetUtils.filter,
                  color: Theme.of(context).colorScheme.shadow,
                  height: 24,
                  width: 24,
                ),
              )
            ],
          ),
          const SizedBox(height: 32),
          getMyVouchers(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget getMyVouchers() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var element = _elements[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                element['date'].toString(),
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.shadow,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ), //title
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.secondary,
              elevation: 16,
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, childIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.PurchaseNowDetail);
                    },
                    child: MyVoucherItemView(),
                  );
                },
                separatorBuilder: (context, index) {
                  return AppDivider();
                },
                itemCount: element['item'].length,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 32);
      },
      itemCount: _elements.length,
    );
  }
}
