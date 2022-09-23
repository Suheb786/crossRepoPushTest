import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class UploadDocumentBottomSheetWidget extends StatelessWidget {
  final Function()? onPhotoLibraryTap;
  final Function()? onCameraTap;
  final Function()? onCancelTap;
  final String? title;

  const UploadDocumentBottomSheetWidget({
    Key? key,
    this.onCameraTap,
    this.onPhotoLibraryTap,
    this.onCancelTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.only(start: 24.w, top: 32.0.h, bottom: 8.0.h),
              child: Text(
                title ?? "",
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            new ListTile(
                leading: new Icon(
                  Icons.upload_file,
                  color: AppColor.gray,
                ),
                title: Text(
                  S.of(context).uploadDocument,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColorDark),
                ),
                onTap: () {
                  onPhotoLibraryTap?.call();
                }),
            new ListTile(
              leading: new Icon(Icons.photo_camera, color: AppColor.gray),
              title: Text(
                S.of(context).takePhoto,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColorDark),
              ),
              onTap: () {
                onCameraTap?.call();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
              onTap: () {
                onCancelTap?.call();
              },
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 24.0.h),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentTextTheme.bodyText1!.color,
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
