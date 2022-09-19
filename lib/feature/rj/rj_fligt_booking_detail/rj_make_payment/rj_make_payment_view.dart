import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjMakePaymentView extends BasePageViewWidget<RjMakePaymentViewModel> {
  RjMakePaymentView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
                enabled: isError ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<List<MakePaymentCard>>>(
                    initialData: Resource.none(),
                    stream: model.itemSelectedStream,
                    dataBuilder: (BuildContext context, data) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(rjFlightBookingDetailViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              1.0) {
                            FocusScope.of(context).unfocus();

                            if (StringUtils.isDirectionRTL(context)) {
                              if (details.primaryVelocity!.isNegative) {
                                ProviderScope.containerOf(context)
                                    .read(rjFlightBookingDetailViewModelProvider)
                                    .previousPage();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(rjFlightBookingDetailViewModelProvider)
                                    .nextPage();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                ProviderScope.containerOf(context)
                                    .read(rjFlightBookingDetailViewModelProvider)
                                    .nextPage();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(rjFlightBookingDetailViewModelProvider)
                                    .previousPage();
                              }
                            }
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                              child: Column(
                                children: [
                                  Container(
                                    child: Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(
                                        S.of(context).payFrom,
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: AppColor.veryDarkGray2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: model.makePaymentCardList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return data!.data!.length > 0
                                            ? GestureDetector(
                                                onTap: () {
                                                  model.selectedItem(index);
                                                },
                                                child: Container(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 24, end: 24, top: 16),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        border:
                                                            Border.all(width: 1, color: AppColor.white_gray)),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          model.makePaymentCardList[index].cardName,
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              color: AppColor.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              model.makePaymentCardList[index].cardNo,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  color: AppColor.gray5,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                            Spacer(),
                                                            data.data![index].isSelected
                                                                ? Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    child: Padding(
                                                                      padding: EdgeInsetsDirectional.all(10),
                                                                      child: AppSvg.asset(
                                                                        AssetUtils.right,
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.yellow,
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                        border: Border.all(
                                                                            width: 1,
                                                                            color: AppColor.white_gray)),
                                                                  )
                                                                : Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                        border: Border.all(
                                                                            width: 1,
                                                                            color: AppColor.white_gray)),
                                                                  )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Text(
                                                          "${model.makePaymentCardList[index].amt}  ${model.makePaymentCardList[index].currency}",
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              color: AppColor.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                      ],
                                                    )),
                                              )
                                            : Center(
                                                child: Text(
                                                  'No Data Found',
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColor.dark_violet_4),
                                                ),
                                              );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 16,
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  AppStreamBuilder<bool>(
                                    initialData: false,
                                    stream: model.showButtonSubjectStream,
                                    dataBuilder: (BuildContext context, data) {
                                      return Visibility(
                                        visible: data!,
                                        child: AnimatedButton(
                                          buttonText: S.of(context).swipeToProceed,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 31,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      S.of(context).cancel,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.brightBlue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  //   height:
                                  //       MediaQuery.of(context).viewInsets.bottom,
                                  // ),
                                ],
                              )),
                        ),
                      );
                    }));
          }),
    );
  }
}
