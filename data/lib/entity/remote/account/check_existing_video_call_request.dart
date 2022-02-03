import 'package:json_annotation/json_annotation.dart';

part 'check_existing_video_call_request.g.dart';

@JsonSerializable()
class CheckExistingVideoCallRequest {
  @JsonKey(name: "productId")
  final int? productId;
  @JsonKey(name: "dateToSend")
  final int? dateToSend;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  CheckExistingVideoCallRequest({
    this.productId: 1,
    this.dateToSend,
    required this.baseData,
  });

  factory CheckExistingVideoCallRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckExistingVideoCallRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckExistingVideoCallRequestToJson(this);
}
