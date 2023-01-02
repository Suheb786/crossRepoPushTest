import 'package:domain/model/qr/qr_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "qr_content_entity.g.dart";

@JsonSerializable()
class QRContentEntity implements BaseLayerDataTransformer<QRContentEntity, QRContent> {
  @JsonKey(name: "requestId")
  final String? requestId;

  QRContentEntity({this.requestId});

  factory QRContentEntity.fromJson(Map<String, dynamic> json) => _$QRContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QRContentEntityToJson(this);

  @override
  QRContentEntity restore(QRContent response) {
    return QRContentEntity();
  }

  @override
  QRContent transform() {
    return QRContent(requestId: this.requestId ?? '');
  }
}
