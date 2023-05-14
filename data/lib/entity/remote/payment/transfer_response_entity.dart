import 'package:domain/constants/enum/check_send_money_message_enum.dart';
import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "transfer_response_entity.g.dart";

@JsonSerializable()
class TransferResponseEntity implements BaseLayerDataTransformer<TransferResponseEntity, TransferResponse> {
  @JsonKey(name: "beneficiaryId")
  final String? beneficiaryId;
  @JsonKey(name: "transferType")
  final String? transferType;
  @JsonKey(name: "beneficiaryImage")
  final String? beneficiaryImage;
  @JsonKey(name: "toAmount")
  final num? toAmount;
  @JsonKey(name: "localEq")
  final num? localEq;
  @JsonKey(name: "toAccount")
  final String? toAccount;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "message")
  final String? message;

  TransferResponseEntity(
      {this.beneficiaryId,
      this.transferType,
      this.beneficiaryImage,
      this.toAmount,
      this.localEq,
      this.toAccount,
      this.name= "",
      this.message= ''});

  factory TransferResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferResponseEntityToJson(this);

  @override
  TransferResponseEntity restore(TransferResponse response) {
    return TransferResponseEntity();
  }

  @override
  TransferResponse transform() {
    return TransferResponse(
        beneficiaryId: this.beneficiaryId,
        beneficiaryImage: this.beneficiaryImage,
        localEq: this.localEq,
        toAccount: this.toAccount,
        toAmount: this.toAmount,
        transferType: this.transferType,
        name: this.name,
        messageEnum: this.message?.fromCheckSendMoneyMessageValue());
  }
}
