import 'package:json_annotation/json_annotation.dart';
part 'remove_or_reapply_supplementary_debit_card_request_entity.g.dart';


@JsonSerializable()
class RemoveOrReApplySupplementaryDebitCardRequestEnity {
  @JsonKey(name: "getToken")
  final bool? getToken;

  @JsonKey(name: "Status")
  final String? status;

  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;

  @JsonKey(name: "ReApply")
  final bool? reApply;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  RemoveOrReApplySupplementaryDebitCardRequestEnity(
      {this.getToken,
      this.status,
      this.tokenizedPan,
      this.reApply,
     required this.baseData});


 factory RemoveOrReApplySupplementaryDebitCardRequestEnity.fromJson(
          Map<String, dynamic> json) =>
      _$RemoveOrReApplySupplementaryDebitCardRequestEnityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemoveOrReApplySupplementaryDebitCardRequestEnityToJson(this);

}
