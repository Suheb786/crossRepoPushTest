import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class UploadDocumentBottomSheetWidget extends StatelessWidget {
  final Function()? onPhotoLibraryTap;
  final Function()? onCameraTap;
  final Function()? onCancelTap;
  final String? title;
  final String? firstOptionText;
  final String? secondOptionText;
  final String? buttonText;

  const UploadDocumentBottomSheetWidget(
      {Key? key,
      this.onCameraTap,
      this.onPhotoLibraryTap,
      this.onCancelTap,
      this.title,
      this.firstOptionText,
      this.secondOptionText,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 24, top: 32.0, bottom: 8.0),
              child: Text(
                title ?? "",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColor.gray_black),
              ),
            ),
            new ListTile(
                leading: new Icon(
                  Icons.photo_library,
                  color: AppColor.gray,
                ),
                title: Text(
                  firstOptionText ?? "",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.very_dark_violet),
                ),
                onTap: () {
                  onPhotoLibraryTap?.call();
                }),
            new ListTile(
              leading: new Icon(Icons.photo_camera, color: AppColor.gray),
              title: Text(
                secondOptionText ?? "",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.very_dark_violet),
              ),
              onTap: () {
                onCameraTap?.call();
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: AppColor.dark_grayish_violet1,
              ),
            ),
            InkWell(
              onTap: () {
                onCancelTap?.call();
              },
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  buttonText ?? "",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.gray_black),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
