import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EditProfileAndroidBottomSheetWidget extends StatelessWidget {
  final Function()? onTakePhoto;

  final Function()? onSelectFromLibrary;

  final Function()? onRemovePhoto;
  final Function()? onCancel;

  final String? title;

  const EditProfileAndroidBottomSheetWidget({
    Key? key,
    this.onCancel,
    this.onRemovePhoto,
    this.onTakePhoto,
    this.onSelectFromLibrary,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Wrap(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  title ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            ///on takePhoto
            InkWell(
              onTap: () {
                onTakePhoto?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  S.of(context).takePhoto,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.sky_blue_mid),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            InkWell(
              onTap: () {
                onSelectFromLibrary?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  S.of(context).selectFromLibrary,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.sky_blue_mid),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            ///on Remove
            InkWell(
              onTap: () {
                onRemovePhoto?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  S.of(context).removePhoto,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            InkWell(
              onTap: () {
                onCancel?.call();
              },
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.sky_blue_mid),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
