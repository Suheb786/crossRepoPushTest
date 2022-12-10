import 'package:domain/model/qr/verify_qr_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "verify_qr_content_entity.g.dart";

@JsonSerializable()
class VerifyQRContentEntity implements BaseLayerDataTransformer<VerifyQRContentEntity, VerifyQRContent> {
  @JsonKey(name: "requestId")
  final String? requestId;
  @JsonKey(name: "toAccount")
  final String? toAccount;
  @JsonKey(name: "accountHolderName")
  final String? accountHolderName;
  @JsonKey(name: "amount")
  final String? amount;

  VerifyQRContentEntity({this.toAccount, this.accountHolderName, this.amount, this.requestId});

  factory VerifyQRContentEntity.fromJson(Map<String, dynamic> json) => _$VerifyQRContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyQRContentEntityToJson(this);

  @override
  VerifyQRContentEntity restore(VerifyQRContent response) {
    return VerifyQRContentEntity();
  }

  @override
  VerifyQRContent transform() {
    return VerifyQRContent(
        accountHolderName: this.accountHolderName ?? '',
        amount: this.amount ?? '',
        requestId: this.requestId ?? '',
        toAccount: this.toAccount ?? '');
  }
}
