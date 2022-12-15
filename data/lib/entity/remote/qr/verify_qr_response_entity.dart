import 'package:data/entity/remote/qr/verify_qr_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "verify_qr_response_entity.g.dart";

@JsonSerializable()
class VerifyQRResponseEntity implements BaseLayerDataTransformer<VerifyQRResponseEntity, VerifyQrResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VerifyQRResponseEntity({this.response});

  factory VerifyQRResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyQRResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyQRResponseEntityToJson(this);

  @override
  VerifyQRResponseEntity restore(VerifyQrResponse response) {
    return VerifyQRResponseEntity();
  }

  @override
  VerifyQrResponse transform() {
    return VerifyQrResponse(qrContent: VerifyQRContentEntity.fromJson(this.response!.content).transform());
  }
}
