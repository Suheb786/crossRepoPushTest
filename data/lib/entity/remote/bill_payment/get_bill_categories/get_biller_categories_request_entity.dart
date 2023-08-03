import 'package:json_annotation/json_annotation.dart';

part 'get_biller_categories_request_entity.g.dart';

@JsonSerializable()
class GetBillerCategoriesRequestEntity {
  @JsonKey(name: "Type")
  String type;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetBillerCategoriesRequestEntity({required this.type, this.getToken = true, required this.baseData});

  factory GetBillerCategoriesRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBillerCategoriesRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillerCategoriesRequestEntityToJson(this);
}
