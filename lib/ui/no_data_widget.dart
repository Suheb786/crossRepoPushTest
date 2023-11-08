import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../generated/l10n.dart';
import '../utils/asset_utils.dart';
import 'molecules/app_svg.dart';

class NoDataWidget extends StatefulWidget {
  String? errorMessage;
  String? icon;

  NoDataWidget({this.errorMessage, this.icon});

  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 96.h,
            width: 96.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Theme.of(context).inputDecorationTheme.hintStyle!.color!),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AppSvg.asset(
              widget.icon ?? AssetUtils.searchThin,
              width: 32.h,
              height: 32.h,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.errorMessage ?? S.of(context).noDataFound,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w600,
              fontSize: 12.t,
            ),
          ),
        ],
      ),
    );
  }
}
