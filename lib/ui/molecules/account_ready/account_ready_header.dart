import 'package:flutter/material.dart';

class AccountReadyHeader extends StatelessWidget {
  String? title;
  String? subTitle;

  AccountReadyHeader({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            subTitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Theme.of(context).accentColor),
          ),
        ],
      ),
    );
  }
}
