import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/get_rejection_reason/reject_reasons_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data/entity/remote/payment/return_payment_activity/reject_reason_list_response_entity.dart';
part 'get_rejection_reason_response_entity.g.dart';

@JsonSerializable()
class GetRejectionReasonResponseEntity
    extends BaseLayerDataTransformer<GetRejectionReasonResponseEntity, List<RejectReasonsPayment>> {
  @JsonKey(name: "response")
  final ResponseEntity response;

  GetRejectionReasonResponseEntity(this.response);

  factory GetRejectionReasonResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetRejectionReasonResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetRejectionReasonResponseEntityToJson(this);

  @override
  List<RejectReasonsPayment> transform() {
    var content = response.content as List<dynamic>;
    List<RejectReasonsPayment> result = [];

    if (content.isNotEmpty) {
      result = content.map((e) {
        return RejctReasonListEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
