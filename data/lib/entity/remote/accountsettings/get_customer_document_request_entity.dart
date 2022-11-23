import 'package:json_annotation/json_annotation.dart';

part 'get_customer_document_request_entity.g.dart';

@JsonSerializable()
class GetCustomerDocumentRequestEntity {
  @JsonKey(name: "DocId")
  final String docId;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetCustomerDocumentRequestEntity({this.docId: "", this.getToken: true, required this.baseData});

  factory GetCustomerDocumentRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerDocumentRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCustomerDocumentRequestEntityToJson(this);
}
