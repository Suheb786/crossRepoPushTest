import 'package:flutter/material.dart';

class AddIncomeWidget extends StatelessWidget {
  final String? label;
  final Function()? onTap;

  const AddIncomeWidget({Key? key, this.onTap, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).accentTextTheme.bodyText1!.color!,
                width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label!,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.add,
              size: 16,
              color: Theme.of(context).primaryColorDark,
            )
          ],
        ),
      ),
    );
  }
}
