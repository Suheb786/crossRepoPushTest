import 'package:domain/constants/enum/check_send_money_message_enum.dart';

class TransferResponse {
  TransferResponse(
      {this.beneficiaryId: "",
      this.transferType: "",
      this.beneficiaryImage: "",
      this.toAmount,
      this.localEq,
      this.toAccount: "",
      this.name: "",
      this.messageEnum = CheckSendMoneyMessageEnum.NONE});

  String? beneficiaryId;
  String? transferType;
  String? beneficiaryImage;
  num? toAmount;
  num? localEq;
  String? toAccount;
  String? name;
  CheckSendMoneyMessageEnum? messageEnum;
}
