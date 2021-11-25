import 'package:data/entity/remote/account/check_videocall_status_response_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_videocall_status_response_entity.g.dart';

@JsonSerializable()
class CheckVideoCallStatusResponseEntity extends BaseLayerDataTransformer<
    CheckVideoCallStatusResponseEntity, CheckVideoCallResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckVideoCallStatusResponseEntity(this.response);

  factory CheckVideoCallStatusResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CheckVideoCallStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckVideoCallStatusResponseEntityToJson(this);

  @override
  CheckVideoCallResponse transform() {
    return CheckVideoCallResponse(
        checkVideoCallResponseContent:
            CheckVideoCallStatusResponseContentEntity.fromJson(
                    this.response!.content)
                .transform());
  }
}
