import 'package:domain/model/card/get_card_applications/get_card_applications_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_card_application_content_entity.g.dart";

@JsonSerializable()
class GetCardApplicationContentEntity
    implements BaseLayerDataTransformer<GetCardApplicationContentEntity, GetCardApplicationsContent> {
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
  @JsonKey(name: "finalStep")
  final bool? finalStep;
  @JsonKey(name: "contactLessError")
  final int? contactLessError;
  @JsonKey(name: "linkCardError")
  final int? linkCardError;
  @JsonKey(name: "crifError")
  final int? crifError;
  @JsonKey(name: "manageSOError")
  final int? manageSOError;
  @JsonKey(name: "aramexError")
  final int? aramexError;

  GetCardApplicationContentEntity(
      {this.cardId= "",
      this.loanValueId= 0,
      this.processLoanStep= false,
      this.processLoanDate= "",
      this.issueCardOnNI= false,
      this.issueCardDate= "",
      this.finalStep= false,
      this.contactLessError= 0,
      this.linkCardError= 0,
      this.crifError= 0,
      this.manageSOError= 0,
      this.aramexError= 0});

  factory GetCardApplicationContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCardApplicationContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCardApplicationContentEntityToJson(this);

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
        processLoanStep: this.processLoanStep,
        finalStep: this.finalStep,
        contactLessError: this.contactLessError,
        aramexError: this.aramexError,
        crifError: this.crifError,
        linkCardError: this.linkCardError,
        manageSOError: this.manageSOError);
  }
}
