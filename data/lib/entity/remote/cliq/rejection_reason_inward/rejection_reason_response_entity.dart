import 'package:data/entity/remote/cliq/rejection_reason_inward/rejection_reason_inward_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rejection_reason_response_entity.g.dart';

@JsonSerializable()
class RejectionReasonResponseEntity
    extends BaseLayerDataTransformer<RejectionReasonResponseEntity, List<RejectionReasonInward>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RejectionReasonResponseEntity(this.response);

  factory RejectionReasonResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RejectionReasonResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RejectionReasonResponseEntityToJson(this);

  @override
  List<RejectionReasonInward> transform() {
    var content = response?.content as List<dynamic>;
    List<RejectionReasonInward> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return RejectionReasonInwardEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
