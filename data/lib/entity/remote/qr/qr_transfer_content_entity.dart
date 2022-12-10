import 'package:domain/model/qr/qr_transfer_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "qr_transfer_content_entity.g.dart";

@JsonSerializable()
class QRTransferContentEntity
    implements BaseLayerDataTransformer<QRTransferContentEntity, QRTransferContent> {
  @JsonKey(name: "iban")
  final String? iban;
  @JsonKey(name: "transferDate")
  final String? transferDate;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "amount")
  final num? amount;
  @JsonKey(name: "reference")
  final String? reference;

  QRTransferContentEntity({this.transferDate, this.name, this.amount, this.iban, this.reference});

  factory QRTransferContentEntity.fromJson(Map<String, dynamic> json) =>
      _$QRTransferContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QRTransferContentEntityToJson(this);

  @override
  QRTransferContentEntity restore(QRTransferContent response) {
    return QRTransferContentEntity();
  }

  @override
  QRTransferContent transform() {
    return QRTransferContent(
        name: this.name ?? '',
        amount: this.amount ?? 0.0,
        iban: this.iban ?? '',
        transferDate: this.transferDate ?? '',
        reference: this.reference ?? '');
  }
}
