import 'package:flutter/material.dart';

import '../../../../utils/color_utils.dart';

class TopBrandListItemWidget extends StatefulWidget {
  const TopBrandListItemWidget({Key? key}) : super(key: key);

  @override
  State<TopBrandListItemWidget> createState() => _TopBrandListItemWidgetState();
}

class _TopBrandListItemWidgetState extends State<TopBrandListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 109,
      alignment: Alignment.topCenter,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildListItem();
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildListItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0,left: 4),
      child: Card(
        elevation: 4,
        shadowColor: AppColor.card_shadow_color,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          height: 103,
          width: 103,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
