import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import '../app_svg.dart';

class UploadDocumentItem extends StatelessWidget {
  final String title;
  final String desc;
  final bool isUploaded;
  final String uploadText;
  final Function()? onTap;

  const UploadDocumentItem(
      {Key? key,
      required this.title,
      required this.desc,
      required this.isUploaded,
      required this.uploadText,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              softWrap: true,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                desc,
                softWrap: true,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.dark_violet2,
                  border: Border.all(width: 2, color: AppColor.light_violet),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.0),
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              uploadText,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isUploaded?AppColor.vivid_orange:AppColor.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // !isActive!
                    //     ?
                    InkWell(
                      onTap: () {
                        onTap?.call();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: isUploaded ? 8.0 : 17),
                        child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: isUploaded
                                  ? AppColor.strong_violet
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: AppSvg.asset(
                                  isUploaded
                                      ? AssetUtils.delete
                                      : AssetUtils.upload,
                                  width: 16,
                                  height: 16),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
