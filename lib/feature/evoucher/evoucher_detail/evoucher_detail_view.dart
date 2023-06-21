import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import 'evoucher_detail_model.dart';

class EvoucherDetailView extends BasePageViewWidget<EvoucherDetailViewModel> {
  EvoucherDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Stack(
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
                    color: Theme.of(context).colorScheme.secondary,
                    width: 56,
                    height: 56,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSecondaryContainer),
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
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            child: PageDetail(),
          ),
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 40,
                ),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).buyVoucherDetailTitle,
                  textSize: 12,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                SizedBox(
                  height: 4,
                ),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).buyVoucherDetailSubTitle,
                  textSize: 20,
                  textWeight: FontWeight.w600,
                  textColor: Theme.of(context).colorScheme.shadow,
                ),
                SizedBox(
                  height: 8,
                ),
                EVoucherTextWidget(
                  alignment: AlignmentDirectional.topStart,
                  text: S.of(context).buyVoucherDetailSubSubTitle,
                  textSize: 14,
                  textWeight: FontWeight.w400,
                  textColor: Theme.of(context).colorScheme.shadow,
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
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8.0, bottom: 4),
                          child: Text(
                            S.of(context).JOD,
                            style: TextStyle(
                                color: AppColor.verLightGray4, fontSize: 14, fontWeight: FontWeight.w700),
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
                  textColor: Theme.of(context).colorScheme.shadow,
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
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ViewVoucherBtb(),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class ViewVoucherBtb extends StatelessWidget {
  const ViewVoucherBtb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24.0, end: 24.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutePaths.ShareVoucher);
          /*InformationDialog.show(context,
              image: AssetUtils.processing_voucher_icon,
              title: S.of(context).processingVoucher,
              descriptionWidget: Text(
                S.of(context).viewVoucherDialogDescription,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ), onSelected: () {
            Navigator.pop(context);
          }, onDismissed: () {
            Navigator.pop(context);
          });*/
        },
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EVoucherTextWidget(
                alignment: AlignmentDirectional.center,
                text: S.of(context).viewVoucher,
                textSize: 14,
                textWeight: FontWeight.w600,
                textColor: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 24.0),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.ShareVoucher);
                    },
                    child: AppSvg.asset(AssetUtils.view_voucher_icon)),
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.inverseSurface),
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              )),
        ),
      ),
    );
  }
}
