import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'select_service_dialog_view_model.dart';

class SelectServiceDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;
  bool _keyboardVisible = false;

  SelectServiceDialogView({this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return selectServiceDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<SelectServiceDialogViewModel>(
        onModelReady: (model) {
          model.serviceList = [
            'Internet Bill Payment',
            'Deactivate Internet Service',
            'Deactivate T.F Service',
          ];
        },
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: _keyboardVisible ? 36 : 204),
              child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      onDismissed?.call();
                    }
                  },
                  child: AppStreamBuilder<int>(
                    initialData: 0,
                    stream: model!.currentIndexStream,
                    dataBuilder: (BuildContext context, selectedIndex) {
                      return AppKeyBoardHide(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: Center(
                                child: Text(
                                  title!,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            model.serviceList.isNotEmpty
                                ? Expanded(
                                    child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Container(
                                          height: 64,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: AppColor.vividYellow,
                                          ),
                                        ),
                                      ),
                                      AppScrollableListViewWidget(
                                        key: ValueKey(model.serviceList.length),
                                        child: ClickableListWheelScrollView(
                                          scrollController: model.scrollController,
                                          itemHeight: 72,
                                          itemCount: model.serviceList.length,
                                          //   itemCount: data.data!.length,
                                          onItemTapCallback: (index) {
                                            print('onItemTapCallback----->$index');
                                          },

                                          child: ListWheelScrollView.useDelegate(
                                              controller: model.scrollController,
                                              itemExtent: 72,
                                              onSelectedItemChanged: (int index) {
                                                print('onSelectedItemChanged----->$index');
                                                model.currentIndexUpdate(index);
                                              },
                                              physics: FixedExtentScrollPhysics(),
                                              perspective: 0.0000000001,
                                              childDelegate: ListWheelChildBuilderDelegate(
                                                  childCount: model.serviceList.length,
                                                  builder: (BuildContext context, int index) {
                                                    return Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 16),
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 24, end: 20, top: 20, bottom: 20),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16),
                                                          color: Colors.transparent),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.symmetric(horizontal: 16.0.w),
                                                              child: Text(
                                                                model.serviceList[index],
                                                                //  data.data![index],
                                                                softWrap: true,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400,
                                                                  // color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.very_dark_violet
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })),
                                        ),
                                      ),
                                    ],
                                  ))
                                : Expanded(
                                    child: Center(
                                      child: Container(
                                        child: Text('No Data Found'),
                                      ),
                                    ),
                                  ),
                            InkWell(
                              onTap: () {
                                if (model.serviceList != null && model.serviceList.length > 0) {
                                  onSelected!.call(model.serviceList[selectedIndex ?? 0]);
                                } else {
                                  onSelected!.call('');
                                }

                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    onDismissed?.call();
                                  },
                                  child: Text(
                                    S.of(context).swipeDownToCancel,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.dark_gray_1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )));
        },
        providerBase: providerBase());
  }
}
