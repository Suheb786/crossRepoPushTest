import 'package:data/entity/remote/account/request_call_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_call_response_entity.g.dart';

@JsonSerializable()
class RequestCallResponseEntity extends BaseLayerDataTransformer<
    RequestCallResponseEntity, RequestCallStatus> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RequestCallResponseEntity(this.response);

  factory RequestCallResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestCallResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCallResponseEntityToJson(this);

  @override
  RequestCallStatus transform() {
    return RequestCallEntity.fromJson(response!.content as Map<String, dynamic>)
        .transform();
  }
}
