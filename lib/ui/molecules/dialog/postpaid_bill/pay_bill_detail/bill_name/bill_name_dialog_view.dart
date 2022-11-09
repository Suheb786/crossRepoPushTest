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
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'bill_name_dialog_view_model.dart';

class PayBillDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final String? title;
  bool _keyboardVisible = false;

  PayBillDialogView({this.onDismissed, this.onSelected, this.title});

  ProviderBase providerBase() {
    return payBillDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return BaseWidget<PayBillDialogViewModel>(
        onModelReady: (model) {
          model.billNameList = [
            'Orange Fixed',
            'Orange Mobile and Net Everyw...',
            'Orange Internet',
            'Umniah',
            'VTEL Jordan',
            'Zain'
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
                    stream: model!.currentIndexStream,
                    initialData: 0,
                    dataBuilder: (BuildContext context, index) {
                      return AppStreamBuilder<List<String>>(
                        stream: model.searchBillNameStream,
                        initialData: model.billNameList,
                        dataBuilder: (BuildContext context, billList) {
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                  child: AppTextField(
                                    labelText: '',
                                    controller: model.searchBillNameController,
                                    textFieldBorderColor: AppColor.gray_1,
                                    hintTextColor: AppColor.gray_2,
                                    textColor: AppColor.black,
                                    hintText: S.of(context).searchCountry,
                                    containerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    onChanged: (value) {
                                      model.searchBillName(value);
                                    },
                                    suffixIcon: (value, data) {
                                      return InkWell(
                                        onTap: () async {},
                                        child: Container(
                                            height: 16,
                                            width: 16,
                                            padding: EdgeInsets.all(6),
                                            child: AppSvg.asset(AssetUtils.search,
                                                color: Theme.of(context).primaryColorDark)),
                                      );
                                    },
                                  ),
                                ),
                                billList!.isNotEmpty
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
                                            key: ValueKey(model.billNameList.length),
                                            child: ClickableListWheelScrollView(
                                              scrollController: model.scrollController,
                                              itemHeight: 72,
                                              itemCount: model.billNameList.length,
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
                                                      childCount: model.billNameList.length,
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
                                                                      EdgeInsets.symmetric(horizontal: 16.0),
                                                                  child: Text(
                                                                    billList[index],
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
                                    if (billList != null && billList.length > 0) {
                                      onSelected!.call(billList[index ?? 0]);
                                    } else {
                                      onSelected!.call('');
                                    }
                                    //  print('onTap----->$currentIndex');
                                    /* if (data.data != null && data.data!.length > 0) {
                                print('onTaponSelected----->$currentIndex');

                                onSelected!.call(model.searchCountryList[currentIndex!]);*/
                                    // } else {
                                    //  print('onTapNavigator----->$currentIndex');
                                    Navigator.pop(context);
                                    //}
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 57,
                                    width: 57,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                    child:
                                        AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
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
                      );
                    },
                  )));
        },
        providerBase: providerBase());
  }
}
