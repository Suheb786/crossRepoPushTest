import 'package:data/entity/remote/ahwal/ahwal_info_content_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/id_card/ahwal_details_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ahwal_detail_response_entity.g.dart';

@JsonSerializable()
class AhwalDetailResponseEntity
    implements
        BaseLayerDataTransformer<AhwalDetailResponseEntity,
            AhwalDetailResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  AhwalDetailResponseEntity({this.responseEntity});

  factory AhwalDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AhwalDetailResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AhwalDetailResponseEntityToJson(this);

  @override
  AhwalDetailResponseEntity restore(AhwalDetailResponse response) {
    return AhwalDetailResponseEntity();
  }

  @override
  AhwalDetailResponse transform() {
    return AhwalDetailResponse(
        contentData:
        AhwalInfoContentDataEntity.fromJson(this.responseEntity!.content)
            .transform());
  }
}
