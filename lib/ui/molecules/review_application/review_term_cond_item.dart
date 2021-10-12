import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/ui/molecules/review_application/review_item_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReviewTCItem extends StatelessWidget {
  final String title;
  final ProviderBase providerBase;
  final Function(bool)? onToggle;
  final bool isSelected;

  const ReviewTCItem(
      {Key? key,
      required this.title,
      required this.providerBase,
      required this.isSelected,
      this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReviewItemViewModel>(
      providerBase: providerBase,
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: false,
          stream: model!.checkBoxState,
          dataBuilder: (context, isActive) {
            return Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(
                        title,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.text_color),
                      ),
                    ],
                  ),
                  onToggle?.call(isActive!)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
