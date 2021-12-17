import 'package:data/entity/remote/account/doc_status_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/doc_status_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc_status_response_entity.g.dart';

@JsonSerializable()
class DocStatusResponseEntity extends BaseLayerDataTransformer<
    DocStatusResponseEntity, DocStatusResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  DocStatusResponseEntity(this.response);

  factory DocStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DocStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DocStatusResponseEntityToJson(this);

  @override
  DocStatusResponse transform() {
    return DocStatusResponse(
        docStatusContent:
            DocStatusContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
