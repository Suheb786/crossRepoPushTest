import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/ui/molecules/profile/profile_item_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ProfileRowItem extends StatelessWidget {
  final String title;
  final ProviderBase providerBase;
  final Function(bool)? onToggle;

  const ProfileRowItem(
      {Key? key,
      required this.title,
      required this.providerBase,
      this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileItemViewModel>(
      providerBase: providerBase,
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: false,
          stream: model!.switchState,
          dataBuilder: (context, isActive) {
            return Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.text_color),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: CupertinoSwitch(
                            onChanged: (value) {
                              model.updateState(value);
                            },
                            value: isActive!,
                            activeColor: AppColor.vivid_orange,
                            trackColor: AppColor.white,
                          )),
                    ],
                  ),
                  onToggle?.call(isActive)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
