import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/constants/enum/video_kyc_status_enum.dart';
import 'package:domain/model/account/video_kyc_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_call_status_response_entity.g.dart';

@JsonSerializable()
class VideoCallStatusResponseEntity
    extends BaseLayerDataTransformer<VideoCallStatusResponseEntity, VideoKycStatus> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VideoCallStatusResponseEntity(this.response);

  factory VideoCallStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VideoCallStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VideoCallStatusResponseEntityToJson(this);

  @override
  VideoKycStatus transform() {
    return VideoKycStatus(status: (this.response!.content as String).fromStatusValue());
  }
}
