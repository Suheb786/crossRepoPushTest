import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentBeneficiaryWidget extends StatelessWidget {
  final Function()? onTap;
  final Beneficiary? beneficiary;
  final TransferEnum transferEnum;

  const PaymentBeneficiaryWidget({Key? key, this.onTap, this.beneficiary, required this.transferEnum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              onTap?.call();
            },
            child: beneficiary!.imageUrl.isNotEmpty
                ? CircleAvatar(
                    radius: 32.0.w,
                    backgroundImage: Image.memory(
                      beneficiary!.imageUrl,
                      fit: BoxFit.cover,
                    ).image,
                  )
                : CircleAvatar(
                    radius: 32.0.w,
                    backgroundColor: transferEnum == TransferEnum.send
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorDark,
                    child: Text(
                      (beneficiary?.nickName ?? '').split(" ").length > 1
                          ? StringUtils.getFirstInitials(beneficiary?.nickName ?? '')
                          : beneficiary!.nickName![0],
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0.t,
                          color: transferEnum == TransferEnum.send
                              ? Theme.of(context).primaryTextTheme.bodyLarge?.color
                              : Theme.of(context).primaryTextTheme.bodyLarge?.color),
                    ),
                  )),
        Padding(
          padding: EdgeInsets.only(top: 6.0.h),
          child: Text(
            (beneficiary!.nickName != null && beneficiary!.nickName!.isNotEmpty)
                ? beneficiary!.nickName!
                : beneficiary!.fullName!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                overflow: TextOverflow.ellipsis,
                color: transferEnum == TransferEnum.send
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).primaryColorDark,
                fontSize: 9,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}

enum TransferEnum { send, request }
