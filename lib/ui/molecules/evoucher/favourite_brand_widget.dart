import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FavouriteBrandGridItemWidget extends StatelessWidget {
  const FavouriteBrandGridItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          child: _buildItem(),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0, childAspectRatio: 1.0),
    );
  }

  Widget _buildItem() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.zero,
                width: 155.5,
                height: 100,
                decoration:
                    BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).playStation,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: AppColor.gray,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).favouriteBrandItemDescription,
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: AppColor.gray_black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
