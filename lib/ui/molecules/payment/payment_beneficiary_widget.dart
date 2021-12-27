import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentBeneficiaryWidget extends StatelessWidget {
  final Function()? onTap;
  final Beneficiary? beneficiary;

  const PaymentBeneficiaryWidget({Key? key, this.onTap, this.beneficiary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              onTap?.call();
            },
            child: beneficiary!.imageUrl.toString().isNotEmpty
                ? CircleAvatar(
                    radius: 32,
                    backgroundImage: Image.memory(
                      beneficiary!.imageUrl,
                      fit: BoxFit.cover,
                    ).image,
                  )
                : CircleAvatar(
                    radius: 32,
                    backgroundColor: Theme.of(context).canvasColor,
                    child: Text(
                      StringUtils.getFirstInitials(beneficiary!.nickName),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1!
                              .color),
                    ),
                  )),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            beneficiary!.nickName!,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 9,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
