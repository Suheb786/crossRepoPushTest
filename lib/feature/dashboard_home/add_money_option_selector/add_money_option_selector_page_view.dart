import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dashboard/add_money_selector_option_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

class AddMoneyOptionSelectorPageView extends BasePageViewWidget<AddMoneyOptionSelectorViewModel> {
  AddMoneyOptionSelectorPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(top: 53.h, start: 29.w, end: 29.w),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppSvg.asset(AssetUtils.leftArrow,
                        matchTextDirection: true, color: Theme.of(context).accentColor),
                  )),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 11.w, bottom: 53.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 28.h),
                      child: Text(
                        S.of(context).waysYocCanAddMoneyToAccount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 20.t,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    AddMoneySelectorOptionsWidget(
                      image: AssetUtils.moneyIn,
                      title: S.of(context).requestMoneyFromOtherBank,
                      desc: S.of(context).requestMoneyFromOtherBankDesc,
                      buttonText: S.of(context).requestMoney,
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.PaymentHome,
                            arguments: NavigationType.ADD_MONEY);
                      },
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    AppStreamBuilder<GetDashboardDataContent>(
                      stream: ProviderScope.containerOf(context)
                          .read(appHomeViewModelProvider)
                          .getDashboardCardDataStream,
                      initialData: GetDashboardDataContent(),
                      dataBuilder: (context, cardData) {
                        return AddMoneySelectorOptionsWidget(
                          image: AssetUtils.receiveMoneyOther,
                          title: S.of(context).receiveMoneyFromOthers,
                          desc: S.of(context).receiveMoneyFromOthersDesc,
                          buttonText: S.of(context).shareAccountInfo,
                          onTap: () {
                            _shareFiles(model, context, cardData);
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    AddMoneySelectorOptionsWidget(
                      image: AssetUtils.dollar,
                      title: S.of(context).depositViaATM,
                      desc: S.of(context).depositViaATMDesc,
                      buttonText: S.of(context).locateATM,
                      onTap: () {},
                      isVisible: false,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    AddMoneySelectorOptionsWidget(
                      image: AssetUtils.dollar,
                      title: S.of(context).depositViaeFawateercom,
                      desc: S.of(context).depositViaeFawateercomDesc,
                      buttonText: S.of(context).locateATM,
                      onTap: () {},
                      isVisible: false,
                    ),
                    AppStreamBuilder<Resource<GetPlaceholderResponse>>(
                        stream: model.getPlaceHolderStream,
                        initialData: Resource.none(),
                        dataBuilder: (context, snapshot) {
                          switch (snapshot!.status) {
                            case Status.SUCCESS:
                              return (snapshot.data!.data!.status ?? false)
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 24.h),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: AppDivider(
                                                  color: AppColor.white.withOpacity(0.3),
                                                  indent: 12.w,
                                                  endIndent: 8.w,
                                                ),
                                              ),
                                              Text(
                                                S.of(context).or,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: Theme.of(context).accentColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.t),
                                              ),
                                              Expanded(
                                                child: AppDivider(
                                                  color: AppColor.white.withOpacity(0.3),
                                                  endIndent: 0,
                                                  indent: 8.w,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 0),
                                          child: Image.memory(
                                            snapshot.data!.data!.image,
                                            fit: BoxFit.fill,
                                          )
                                          /*Container(
                                            //height: 120,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: Image.memory(snapshot
                                                            .data!.data!.image)
                                                        .image,
                                                    fit: BoxFit.fill),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                          )*/
                                          ,
                                        ),
                                      ],
                                    )
                                  : Container();
                            default:
                              return Container();
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _shareFiles(
    AddMoneyOptionSelectorViewModel model,
    BuildContext context,
    GetDashboardDataContent? cardData,
  ) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'Hello! Here are my Blink account details: \n\n${cardData!.account!.accountTitle ?? ''} \n${cardData.account!.iban ?? '-'}\n\nOpen your Blink account today.',
        subject: 'Share account info',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
