import 'package:domain/model/account/check_videocall_status_response_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_videocall_status_response_content_entity.g.dart';

@JsonSerializable()
class CheckVideoCallStatusResponseContentEntity
    implements
        BaseLayerDataTransformer<CheckVideoCallStatusResponseContentEntity,
            CheckVideoCallResponseContent> {
  @JsonKey(name: "status")
  final bool? status;

  CheckVideoCallStatusResponseContentEntity({this.status});

  factory CheckVideoCallStatusResponseContentEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CheckVideoCallStatusResponseContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckVideoCallStatusResponseContentEntityToJson(this);

  @override
  CheckVideoCallStatusResponseContentEntity restore(
      CheckVideoCallResponseContent response) {
    return CheckVideoCallStatusResponseContentEntity();
  }

  @override
  CheckVideoCallResponseContent transform() {
    return CheckVideoCallResponseContent(status: this.status);
  }
}
