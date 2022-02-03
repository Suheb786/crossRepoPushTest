import 'package:data/entity/remote/account/check_existing_call_status_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_existing_call_response_entity.g.dart';

@JsonSerializable()
class CheckExistingCallResponseEntity extends BaseLayerDataTransformer<
    CheckExistingCallResponseEntity, CheckExistingCallStatus> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckExistingCallResponseEntity(this.response);

  factory CheckExistingCallResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckExistingCallResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckExistingCallResponseEntityToJson(this);

  @override
  CheckExistingCallStatus transform() {
    return CheckExistingCallStatusEntity.fromJson(
            response!.content as Map<String, dynamic>)
        .transform();
  }
}
