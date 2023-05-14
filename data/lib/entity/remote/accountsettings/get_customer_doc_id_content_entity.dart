import 'package:domain/model/profile_settings/get_customer_doc_id/get_customer_doc_id_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_doc_id_content_entity.g.dart';

@JsonSerializable()
class GetCustomerDocIdContentEntity
    extends BaseLayerDataTransformer<GetCustomerDocIdContentEntity, GetCustomerDocIdContent> {
  @JsonKey(name: "proofOfIncome")
  final String? proofOfIncome;
  @JsonKey(name: "proofOfAddress")
  final String? proofOfAddress;

  GetCustomerDocIdContentEntity({this.proofOfAddress= "", this.proofOfIncome= ""});

  factory GetCustomerDocIdContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerDocIdContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCustomerDocIdContentEntityToJson(this);

  @override
  GetCustomerDocIdContentEntity restore(GetCustomerDocIdContent response) {
    return GetCustomerDocIdContentEntity();
  }

  @override
  GetCustomerDocIdContent transform() {
    return GetCustomerDocIdContent(proofOfAddress: this.proofOfAddress, proofOfIncome: this.proofOfIncome);
  }
}
