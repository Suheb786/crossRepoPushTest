import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class VersionUpdateDialogView extends StatelessWidget {
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;

  const VersionUpdateDialogView({
    this.onSelected,
    required this.image,
    required this.title,
    required this.descriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding:
            EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 41),
                    image != null
                        ? AppSvg.asset(image!, height: 50, width: 50)
                        : Container(),
                    SizedBox(height: 25),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColor.very_dark_gray),
                    ),
                    SizedBox(height: 31),
                    descriptionWidget,
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
                    SizedBox(height: 12),
                  ],
                ),
              )),
        ));
  }
}
