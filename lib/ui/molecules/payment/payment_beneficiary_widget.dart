import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentBeneficiaryWidget extends StatelessWidget {
  final Function()? onTap;
  final Beneficiary? beneficiary;
  final TransferEnum transferEnum;

  const PaymentBeneficiaryWidget(
      {Key? key, this.onTap, this.beneficiary, required this.transferEnum})
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
                    backgroundColor: transferEnum == TransferEnum.send
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).primaryColor,
                    child: Text(
                      StringUtils.getFirstInitials(beneficiary!.fullName),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: transferEnum == TransferEnum.send
                              ? Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .color
                              : Theme.of(context).accentColor),
                    ),
                  )),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            ///TODO:change to nickname
            beneficiary!.fullName!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: transferEnum == TransferEnum.send
                    ? Theme
                    .of(context)
                    .accentColor
                    : Theme
                    .of(context)
                    .primaryColorDark,
                fontSize: 9,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}

enum TransferEnum { send, request }
