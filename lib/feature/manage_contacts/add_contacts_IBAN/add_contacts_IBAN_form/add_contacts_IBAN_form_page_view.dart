import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';

import 'add_contacts_IBAN_form_page_view_model.dart';

class AddContactsIBANformPageView extends BasePageViewWidget<AddContactsIBANformPageViewModel> {
  AddContactsIBANformPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return ShakeAnimatedWidget(
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom - 50 <= 0
                  ? 0
                  : MediaQuery.of(context).viewInsets.bottom - 48),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
            child: Column(
              children: [
                //   Expanded(
                //       child: Column(
                //     children: [
                //       SingleChildScrollView(
                //         physics: ClampingScrollPhysics(),
                //         child: AppTextField(
                //           labelText: " fdsf",
                //           hintText: 'fdf',
                //           // controller: model.cliqIdTypeController,
                //           // key: model.clickIdTypeKey,
                //           readOnly: true,
                //           suffixIcon: (isValid, value) {
                //             return Container(
                //                 height: 16.h,
                //                 width: 16.w,
                //                 padding: EdgeInsets.symmetric(horizontal: 7.w),
                //                 child: AppSvg.asset(AssetUtils.downArrow,
                //                     color: Theme.of(context).primaryColorDark));
                //           },
                //         ),
                //       ),
                //       Column(
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.symmetric(vertical: 16.0.h),
                //             child: AppStreamBuilder<bool>(
                //                 stream: model.showStreamButom,
                //                 initialData: false,
                //                 dataBuilder: (context, isValid) {
                //                   return Visibility(
                //                     visible: isValid!,
                //                     child: AnimatedButton(
                //                       buttonText: "",
                //                     ),
                //                   );
                //                 }),
                //           ),
                //           Center(
                //             child: InkWell(
                //               onTap: () {
                //                 Navigator.pop(context);
                //               },
                //               child: Text(
                //                 "fdjf",
                //                 style: TextStyle(
                //                   color: AppColor.brightBlue,
                //                   fontSize: 14.t,
                //                   letterSpacing: 1.0,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   )),
                //   Column(
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.symmetric(vertical: 16.0.h),
                //         child: AppStreamBuilder<bool>(
                //             stream: model.showStreamButom,
                //             initialData: false,
                //             dataBuilder: (context, isValid) {
                //               return Visibility(
                //                 visible: isValid!,
                //                 child: AnimatedButton(
                //                   buttonText: 'df',
                //                 ),
                //               );
                //             }),
                //       ),
                //       Center(
                //         child: InkWell(
                //           onTap: () {
                //             Navigator.pop(context);
                //           },
                //           child: Text(
                //             'ff',
                //             style: TextStyle(
                //               color: AppColor.brightBlue,
                //               fontSize: 14.t,
                //               letterSpacing: 1.0,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
