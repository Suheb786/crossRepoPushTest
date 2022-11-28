import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_call_entity.g.dart';

@JsonSerializable()
class RequestCallEntity implements BaseLayerDataTransformer<RequestCallEntity, RequestCallStatus> {
  @JsonKey(name: "conferenceLink")
  final String? conferenceLink;
  @JsonKey(name: "callId")
  final String? callId;

  RequestCallEntity({this.conferenceLink: "", this.callId: ""});

  factory RequestCallEntity.fromJson(Map<String, dynamic> json) => _$RequestCallEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCallEntityToJson(this);

  @override
  RequestCallEntity restore(RequestCallStatus response) {
    return RequestCallEntity();
  }

  @override
  RequestCallStatus transform() {
    return RequestCallStatus(callId: this.callId ?? "", conferenceLink: this.conferenceLink ?? "");
  }
}
