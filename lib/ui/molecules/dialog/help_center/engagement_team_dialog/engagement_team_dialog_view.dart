import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class EngagementTeamDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const EngagementTeamDialogView({
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
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 340),
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
                                S.of(context).engagementTeam,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32.0,left: 24.0,right: 24.0),
                              child: Text(
                                S.of(context).engagementTeamDescription,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.very_dark_gray_black),
                              ),
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
              ));
        },
        providerBase: providerBase());
  }
}
