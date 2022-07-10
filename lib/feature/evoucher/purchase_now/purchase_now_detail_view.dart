import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evoucher/purchase_now/purchase_now_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evoucher/purchase_now/purchase_now_view.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PurchaseNowDetailView
    extends BasePageViewWidget<PurchaseNowDetailViewModel> {
  PurchaseNowDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    color: Colors.yellow,
                  ),
                  Positioned(
                    top: 47,
                    left: 24,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        color: Colors.white,
                        width: 56,
                        height: 56,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: AppColor.brightBlue),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 168),
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: PageDetail(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PageDetail extends StatelessWidget {
  const PageDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        EVoucherTextWidget(
          alignment: Alignment.topLeft,
          text: S.of(context).buyVoucherDetailTitle,
          textSize: 12,
          textWeight: FontWeight.w600,
          textColor: AppColor.gray5,
        ),
        SizedBox(
          height: 4,
        ),
        EVoucherTextWidget(
          alignment: Alignment.topLeft,
          text: S.of(context).buyVoucherDetailSubTitle,
          textSize: 20,
          textWeight: FontWeight.w600,
          textColor: AppColor.gray_black,
        ),
        SizedBox(
          height: 8,
        ),
        EVoucherTextWidget(
          alignment: Alignment.topLeft,
          text: S.of(context).buyVoucherDetailSubSubTitle,
          textSize: 14,
          textWeight: FontWeight.w400,
          textColor: AppColor.gray_black,
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "3,540",
                  style: TextStyle(
                      color: AppColor.brightBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).JOD,
                    style: TextStyle(
                        color: AppColor.verLightGray4,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        EVoucherTextWidget(
          alignment: Alignment.topLeft,
          text: S.of(context).termsAndConditionsSetting,
          textSize: 14,
          textWeight: FontWeight.w600,
          textColor: AppColor.gray_black,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: EVoucherTextWidget(
            alignment: Alignment.topLeft,
            text: S.of(context).eVoucherDetailDescption,
            textSize: 14,
            textWeight: FontWeight.w400,
            textColor: AppColor.gray_black,
          ),
        ),
        SizedBox(
          height: 75,
        ),
        PurchaseNowBtn(),
        SizedBox(
          height: 75,
        ),
      ],
    );
  }
}

class PurchaseNowBtn extends StatelessWidget {
  const PurchaseNowBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          PurchaseNowDialog.show(context,
              image: AssetUtils.processingVoucherSvg,
              title: "FIFA 22 Voucher Lorem Ipsum",
              descriptionWidget: Text(
                S.of(context).viewVoucherDialogDescription,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ), onSelected: () {
            Navigator.pop(context);
          }, onDismissed: () {
            Navigator.pop(context);
          }, price: '3054', subTitle: 'FIFA 22');
        },
        child: Container(
          width: double.infinity,
          height: 56,
          child: Center(
              child: Text(
            S.of(context).purchaseNow,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w600),
          )),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.white_gray),
              color: AppColor.brightBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              )),
        ),
      ),
    );
  }
}
