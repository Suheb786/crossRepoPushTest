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
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildItem();
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 0.2, mainAxisSpacing: 0.2, childAspectRatio: 1.0),
    );
  }

  Widget _buildItem() {
    return Builder(builder: (context) {
      return Container(
        // width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: 155.5,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0, -0), blurRadius: 16.0),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).playStation,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: AppColor.gray,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
              child: Align(
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
            ),
          ],
        ),
      );
    });
  }
}
