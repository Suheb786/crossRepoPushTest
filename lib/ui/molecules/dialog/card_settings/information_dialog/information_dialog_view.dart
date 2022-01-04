import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class InformationDialogView extends StatelessWidget {
  final Function? onDismissed;

  final Function? onSelected;
  final String image;
  final String title;
  final String description;

  const InformationDialogView({
    this.onDismissed,
    this.onSelected,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding:
            EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity!.isNegative) {
              onDismissed?.call();
            }
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 41),
                    AppSvg.asset(image, height: 50, width: 50),
                    SizedBox(height: 25),
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 31),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, height: 1.7),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        onSelected!.call();
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        height: 57,
                        width: 57,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color!),
                        child: AppSvg.asset(AssetUtils.tick,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onDismissed!.call();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
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
                    ),
                  ],
                ),
              )),
        ));
  }
}
