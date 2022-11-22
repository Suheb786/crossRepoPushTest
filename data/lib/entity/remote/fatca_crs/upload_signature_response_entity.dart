import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_signature_response_entity.g.dart';

@JsonSerializable()
class UploadSignatureResponseEntity
    extends BaseLayerDataTransformer<UploadSignatureResponseEntity, UploadSignatureResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  UploadSignatureResponseEntity({this.responseEntity});

  factory UploadSignatureResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UploadSignatureResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UploadSignatureResponseEntityToJson(this);

  @override
  UploadSignatureResponse transform() {
    return UploadSignatureResponse(id: this.responseEntity!.content);
  }
}
