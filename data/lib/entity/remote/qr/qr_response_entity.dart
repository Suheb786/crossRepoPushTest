import 'package:data/entity/remote/qr/qr_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/qr/qr_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "qr_response_entity.g.dart";

@JsonSerializable()
class QRResponseEntity implements BaseLayerDataTransformer<QRResponseEntity, QrResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  QRResponseEntity({this.response});

  factory QRResponseEntity.fromJson(Map<String, dynamic> json) => _$QRResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QRResponseEntityToJson(this);

  @override
  QRResponseEntity restore(QrResponse response) {
    return QRResponseEntity();
  }

  @override
  QrResponse transform() {
    return QrResponse(qrContent: QRContentEntity.fromJson(this.response!.content).transform());
  }
}
