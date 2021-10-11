import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class PurposeOfAccountOpeningDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const PurposeOfAccountOpeningDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return purposeOfAccountOpeningDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PurposeOfAccountOpeningDialogViewModel>(
        builder: (context, model, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Dialog(
                insetPadding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                child: AppStreamBuilder<int>(
                  stream: model!.currentIndexStream,
                  initialData: 0,
                  dataBuilder: (context, currentIndex) {
                    return AppStreamBuilder<Resource<List<String>>>(
                      stream: model.getPurposeOfAccountOpeningStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, data) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: Center(
                                child: Text(
                                  S.of(context).purposeOfOpeningAccount,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                                child: ListWheelScrollView.useDelegate(
                                    itemExtent: 64,
                                    onSelectedItemChanged: (int index) {
                                      model.currentIndexUpdate(index);
                                    },
                                    physics: FixedExtentScrollPhysics(),
                                    perspective: 0.0000000001,
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                            childCount: data!.data!.length,
                                            builder: (BuildContext context,
                                                int index) {
                                              return ListScrollWheelListWidget(
                                                label: data.data![index],
                                                textColor: currentIndex == index
                                                    ? AppColor.white
                                                    : AppColor.dark_gray_1,
                                                widgetColor:
                                                    currentIndex == index
                                                        ? AppColor.dark_violet_3
                                                        : AppColor.white,
                                              );
                                            }))),
                            InkWell(
                              onTap: () {
                                onSelected!.call(data.data![currentIndex!]);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.dark_violet_4),
                                child: AppSvg.asset(AssetUtils.tick),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16),
                              child: Center(
                                child: Text(
                                  S.of(context).swipeDownToCancel,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.dark_gray_1),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )),
          );
        },
        providerBase: providerBase());
  }
}
