import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/register/upload_document_later/document_upload_later_page/document_upload_later_page.dart';
import 'package:neo_bank/feature/register/upload_document_later/upload_document_later_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class UploadDocumentsLaterPageView extends BasePageViewWidget<UploadDocumentsLaterViewModel> {
  UploadDocumentsLaterPageView(ProviderBase model) : super(model);

  final List<Widget> pages = [DocumentUploadLaterPage(), BaseCardPage()];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              // Container(
              //   color: AppColor.black,
              //   height: 5,
              //   width: double.infinity,
              // ),
              // DotsIndicator(
              //   dotsCount: 4,
              //   position: 4.0,
              //   mainAxisSize: MainAxisSize.max,
              //   decorator: DotsDecorator(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(5)),
              //       activeSize: Size(MediaQuery.of(context).size.width / 6, 4),
              //       size: Size(MediaQuery.of(context).size.width / 6, 4),
              //       spacing: EdgeInsets.symmetric(horizontal: 1),
              //       activeShape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(5)),
              //       activeColor: Theme.of(context).colorScheme.secondary,
              //       color:
              //           Theme.of(context).primaryColorLight.withOpacity(0.3)),
              // ),
              Text(
                S.of(context).uploadDocuments,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10.t,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 32.h, start: 24.w, end: 24.w),
                child: ShowUpAnimation(
                  key: ValueKey(currentStep),
                  delayStart: Duration(milliseconds: 50),
                  animationDuration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Text(
                    S.of(context).pleaseUploadNecessaryInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20.t,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: AppSwiper(
                  key: ValueKey(currentStep),
                  appSwiperController: model.appSwiperController,
                  pages: pages,
                  onIndexChanged: (index) {
                    model.updatePage(index);
                  },
                  currentStep: currentStep,
                  pageController: model.uploadDocumentLaterController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
