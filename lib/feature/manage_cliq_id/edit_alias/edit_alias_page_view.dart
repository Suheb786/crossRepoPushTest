import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/edit_alias/edit_alias_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EditAliasPageView extends BasePageViewWidget<EditAliasPageViewModel> {
  EditAliasPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 56.0, start: 24, end: 24, bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).editCliqId,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).editYourAlias,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: Card(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity!.isNegative) {}
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 24, top: 32, end: 24),
                        child: AppTextField(
                          labelText: S.of(context).alias.toUpperCase(),
                          hintText: S.of(context).pleaseEnter,
                          controller: model.aliasController,
                          key: model.aliasKey,
                          inputAction: TextInputAction.done,
                          onChanged: (value) {
                            model.validate();
                          },
                          inputType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppStreamBuilder<bool>(
                          stream: model.showButtonStream,
                          initialData: false,
                          dataBuilder: (context, isValid) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 26.0),
                              child: Visibility(
                                visible: isValid!,
                                child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: Center(
                          child: Text(
                            S.of(context).swipeDownToCancel,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400, color: AppColor.dark_gray_1),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
