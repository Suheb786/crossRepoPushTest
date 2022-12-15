import 'package:json_annotation/json_annotation.dart';

part 'get_prepaid_categories_request_entity.g.dart';

@JsonSerializable()
class GetPrePaidCategoriesRequestEntity {
  @JsonKey(name: "billerCode")
  String? billerCode;
  @JsonKey(name: "serviceCode")
  String? serviceCode;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetPrePaidCategoriesRequestEntity(
      {this.billerCode, this.serviceCode, this.getToken, required this.baseData});

  factory GetPrePaidCategoriesRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$GetPrePaidCategoriesRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetPrePaidCategoriesRequestEntityToJson(this);
}
