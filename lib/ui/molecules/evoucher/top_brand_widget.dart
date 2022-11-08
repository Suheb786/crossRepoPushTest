import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBrandListItemWidget extends StatefulWidget {
  const TopBrandListItemWidget({Key? key}) : super(key: key);

  @override
  State<TopBrandListItemWidget> createState() => _TopBrandListItemWidgetState();
}

class _TopBrandListItemWidgetState extends State<TopBrandListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildListItem();
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  Widget _buildListItem() {
    return Container(
      height: 103,
      width: 103.66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.yellow,
      ),
    );
  }
}
