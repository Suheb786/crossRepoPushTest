import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/evoucher/purchase_now/purchase_now_dialog.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PurchaseNowDetailView extends BasePageViewWidget<PurchaseNowDetailViewModel> {
  PurchaseNowDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: 180,
                  color: Colors.yellow,
                ),
                PositionedDirectional(
                  top: 47,
                  start: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      color: Colors.white,
                      width: 56,
                      height: 56,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColor.brightBlue),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 168),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              child: PageDetail(),
            ),
          ),
        ],
      ),
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
          alignment: AlignmentDirectional.topStart,
          text: S.of(context).buyVoucherDetailTitle,
          textSize: 12,
          textWeight: FontWeight.w600,
          textColor: AppColor.gray5,
        ),
        SizedBox(
          height: 4,
        ),
        EVoucherTextWidget(
          alignment: AlignmentDirectional.topStart,
          text: S.of(context).buyVoucherDetailSubTitle,
          textSize: 20,
          textWeight: FontWeight.w600,
          textColor: AppColor.gray_black,
        ),
        SizedBox(
          height: 8,
        ),
        EVoucherTextWidget(
          alignment: AlignmentDirectional.topStart,
          text: S.of(context).buyVoucherDetailSubSubTitle,
          textSize: 14,
          textWeight: FontWeight.w400,
          textColor: AppColor.gray_black,
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).amt,
                  style: TextStyle(color: AppColor.brightBlue, fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0, bottom: 4),
                  child: Text(
                    S.of(context).JOD,
                    style:
                        TextStyle(color: AppColor.verLightGray4, fontSize: 14, fontWeight: FontWeight.w700),
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
          alignment: AlignmentDirectional.topStart,
          text: S.of(context).termsAndConditionsSetting,
          textSize: 14,
          textWeight: FontWeight.w600,
          textColor: AppColor.gray_black,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 24.0, end: 24, top: 16),
          child: Column(
            children: [
              CustomBulletWithTitle(
                title:
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ',
                fontSize: 14,
                lineHeight: 1.5,
              ),
              CustomBulletWithTitle(
                title:
                    'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.  ',
                fontSize: 14,
                lineHeight: 1.5,
              ),
              CustomBulletWithTitle(
                title:
                    'Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.',
                fontSize: 14,
                lineHeight: 1.5,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 75,
        ),
        PurchaseNowBtn(),
        SizedBox(
          height: 24,
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          PurchaseNowDialog.show(context,
              image: AssetUtils.processing_voucher_icon,
              title: S.of(context).purchaseNowTitle,
              descriptionWidget: Text(
                S.of(context).viewVoucherDialogDescription,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ), onSelected: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.EVouchersPurchaseSuccess);
          }, onDismissed: () {
            Navigator.pop(context);
          }, price: S.of(context).amt, subTitle: S.of(context).purchaseNowSubTitle);
        },
        child: Container(
          width: double.infinity,
          height: 56,
          child: Center(
              child: Text(
            S.of(context).purchaseNow,
            style: TextStyle(
                color: Colors.white, fontFamily: "Montserrat", fontSize: 14, fontWeight: FontWeight.w600),
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
