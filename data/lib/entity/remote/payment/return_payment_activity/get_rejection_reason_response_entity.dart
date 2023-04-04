import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/get_rejection_reason/get_rejection_reason_response.dart';
import 'package:domain/model/payment/get_rejection_reason/reject_reasons_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:data/entity/remote/payment/return_payment_activity/reject_reason_list_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data/entity/remote/payment/return_payment_activity/reject_reason_list_response_entity.dart';
part 'get_rejection_reason_response_entity.g.dart';

@JsonSerializable()
class GetRejectionReasonResponseEntity
    extends BaseLayerDataTransformer<GetRejectionReasonResponseEntity, GetRejectionReasonResponseModel> {
  @JsonKey(name: "response")
  final ResponseEntity response;

  GetRejectionReasonResponseEntity(this.response);

  factory GetRejectionReasonResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetRejectionReasonResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetRejectionReasonResponseEntityToJson(this);

  @override
  GetRejectionReasonResponseModel transform() {
    return GetRejectionReasonResponseModel(
        rejectReasons: (this.response.content as List<dynamic>)
            .map((e) => RejctReasonListEntity.fromJson(e).transform())
            .toList());
  }
}
