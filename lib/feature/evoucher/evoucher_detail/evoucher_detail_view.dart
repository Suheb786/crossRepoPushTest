import 'package:animated_widgets/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/evoucher/my_voucher_text_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import 'evoucher_detail_model.dart';

class EvoucherDetailView extends BasePageViewWidget<EvoucherDetailViewModel> {
  EvoucherDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              height: 180,
              color: Colors.yellow,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    EVoucherTextWidget(
                      alignment: Alignment.topLeft,
                      text: 'FIFA 22',
                      textSize: 12,
                      textWeight: FontWeight.w600,
                      textColor: AppColor.gray5,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    EVoucherTextWidget(
                      alignment: Alignment.topLeft,
                      text: 'FIFA 22 Promo Pack Lorem Ipsum',
                      textSize: 20,
                      textWeight: FontWeight.w600,
                      textColor: AppColor.gray_black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    EVoucherTextWidget(
                      alignment: Alignment.topLeft,
                      text: 'Valid until 24 December 2022',
                      textSize: 14,
                      textWeight: FontWeight.w400,
                      textColor: AppColor.gray_black,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EVoucherTextWidget(
                            alignment: Alignment.topLeft,
                            text: '3,540',
                            textSize: 24,
                            textWeight: FontWeight.w700,
                            textColor: AppColor.brightBlue,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EVoucherTextWidget(
                      alignment: Alignment.topLeft,
                      text: 'Terms & Conditions',
                      textSize: 14,
                      textWeight: FontWeight.w600,
                      textColor: AppColor.gray_black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EVoucherTextWidget(
                        alignment: Alignment.topLeft,
                        text:
                            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.',
                        textSize: 14,
                        textWeight: FontWeight.w400,
                        textColor: AppColor.gray_black,
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          InformationDialog.show(context,
                              image: AssetUtils.cardFreeze,
                              title: 'Processing voucher',
                              descriptionWidget: Text(
                                "Your voucher is being processed. You’ll get notification when your voucher is ready to be used.",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ), onSelected: () {
                            Navigator.pop(context);
                          }, onDismissed: () {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          height: 56,
                          child: Row(
                            children: [
                              EVoucherTextWidget(
                                alignment: Alignment.center,
                                text: 'View Voucher',
                                textSize: 14,
                                textWeight: FontWeight.w600,
                                textColor: AppColor.brightBlue,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.white_gray),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
