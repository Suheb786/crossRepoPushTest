import 'package:data/entity/remote/qr/qr_transfer_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "qr_transfer_response_entity.g.dart";

@JsonSerializable()
class QRTransferResponseEntity
    implements BaseLayerDataTransformer<QRTransferResponseEntity, QRTransferResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  QRTransferResponseEntity({this.response});

  factory QRTransferResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$QRTransferResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QRTransferResponseEntityToJson(this);

  @override
  QRTransferResponseEntity restore(QRTransferResponse response) {
    return QRTransferResponseEntity();
  }

  @override
  QRTransferResponse transform() {
    return QRTransferResponse(
        qrContent: QRTransferContentEntity.fromJson(this.response!.content).transform());
  }
}
