import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

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
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: 1.0),
    );
  }

  Widget _buildItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: 155.5,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PlayStation",
                  style: TextStyle(
                      color: AppColor.gray,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet conspec",
                  maxLines: 2,
                  style: TextStyle(
                      color: AppColor.gray_black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
    );
  }
}
