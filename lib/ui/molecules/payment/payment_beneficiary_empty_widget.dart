import 'package:flutter/material.dart';

class PaymentBeneficiaryEmptyWidget extends StatelessWidget {
  const PaymentBeneficiaryEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            "",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
