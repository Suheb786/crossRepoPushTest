import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentBeneficiaryEmptyWidget extends StatelessWidget {
  const PaymentBeneficiaryEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(builder: (p0, p1) {
          return CircleAvatar(
            radius: (p1.maxWidth) / 2.5,
            backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
          );
        }),
        Padding(
          padding: EdgeInsets.only(top: 6.0.h),
          child: Text(
            "",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 9.0.t, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
