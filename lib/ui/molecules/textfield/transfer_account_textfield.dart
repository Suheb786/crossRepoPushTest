import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/string_utils.dart';
import '../app_svg.dart';

class TransferAccountTextField extends StatefulWidget {
  TransferAccountTextField(
      {Key? key,
      required this.context,
      required this.model,
      this.label,
      this.accuntNumber,
      this.availableAmount,
      this.accountName,
      this.obscureText})
      : super(key: key);
  final BuildContext context;
  final SelectTransferPageViewModel model;
  final String? label;
  final String? accuntNumber;
  final String? availableAmount;
  final String? accountName;
  final bool? obscureText;

  @override
  TransferAccountTextFieldState createState() => TransferAccountTextFieldState();
}

class TransferAccountTextFieldState extends State<TransferAccountTextField> {
  FocusNode _focusNode = FocusNode();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isValid = true;
    });
  }

  bool get isValid => _isValid;

  set isValid(bool value) {
    setState(() {
      _isValid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.all(16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1,
              color: !isValid
                  ? Theme.of(context).inputDecorationTheme.errorBorder!.borderSide.color
                  : _focusNode.hasFocus
                      ? (Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color)
                      : (Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 10.0.t,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.accountName ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.0.t,
                      color: Theme.of(context).colorScheme.shadow,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.accuntNumber ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12.0.t,
                      color: Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16.h),
                Text(
                  widget.availableAmount ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.0.t,
                      color: Theme.of(context).colorScheme.shadow,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                height: 16.h,
                width: 16.w,
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: AppSvg.asset(AssetUtils.downArrow, color: Theme.of(context).primaryColorDark)),
          )
        ],
      ),
    );
  }
}
