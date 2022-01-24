import 'package:domain/model/profile_settings/get_customer_doc/get_customer_document_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_document_content_entity.g.dart';

@JsonSerializable()
class GetCustomerDocumentContentEntity extends BaseLayerDataTransformer<
    GetCustomerDocumentContentEntity, GetCustomerDocumentContent> {
  @JsonKey(name: "doc")
  final String? doc;

  GetCustomerDocumentContentEntity({this.doc});

  factory GetCustomerDocumentContentEntity.fromJson(
          Map<String, dynamic> json) =>
      _$GetCustomerDocumentContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCustomerDocumentContentEntityToJson(this);

  @override
  GetCustomerDocumentContentEntity restore(
      GetCustomerDocumentContent response) {
    return GetCustomerDocumentContentEntity();
  }

  @override
  GetCustomerDocumentContent transform() {
    return GetCustomerDocumentContent(doc: this.doc);
  }
}
