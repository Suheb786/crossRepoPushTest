import 'package:domain/model/card/get_card_applications/get_card_applications_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_card_application_content_entity.g.dart";

@JsonSerializable()
class GetCardApplicationContentEntity
    implements
        BaseLayerDataTransformer<GetCardApplicationContentEntity,
            GetCardApplicationsContent> {
  @JsonKey(name: "cardId")
  final String? cardId;
  @JsonKey(name: "loanValueId")
  final num? loanValueId;
  @JsonKey(name: "processLoanStep")
  final bool? processLoanStep;
  @JsonKey(name: "processLoanDate")
  final String? processLoanDate;
  @JsonKey(name: "issueCardOnNI")
  final bool? issueCardOnNI;
  @JsonKey(name: "issueCardDate")
  final String? issueCardDate;

  GetCardApplicationContentEntity(
      {this.cardId: "",
      this.loanValueId: 0,
      this.processLoanStep: false,
      this.processLoanDate: "",
      this.issueCardOnNI: false,
      this.issueCardDate: ""});

  factory GetCardApplicationContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCardApplicationContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCardApplicationContentEntityToJson(this);

  @override
  GetCardApplicationContentEntity restore(GetCardApplicationsContent response) {
    return GetCardApplicationContentEntity();
  }

  @override
  GetCardApplicationsContent transform() {
    return GetCardApplicationsContent(
        cardId: this.cardId,
        issueCardDate: this.issueCardDate,
        issueCardOnNI: this.issueCardOnNI,
        loanValueId: this.loanValueId,
        processLoanDate: this.processLoanDate,
        processLoanStep: this.processLoanStep);
  }
}
