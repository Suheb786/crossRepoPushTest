import 'package:json_annotation/json_annotation.dart';

part 'offers_request_entity.g.dart';

@JsonSerializable()
class OffersRequestEntity {
  @JsonKey(name: "CategoryId")
  final num categoryId;
  @JsonKey(name: "SearchText")
  final String searchText;

  @JsonKey(name: "PageNo")
  final int pageNo;

  @JsonKey(name: "TotalRecord")
  final int totalRecord;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  OffersRequestEntity({
    required this.baseData,
    this.getToken = true,
    required this.categoryId,
    required this.searchText,
    required this.pageNo,
    required this.totalRecord,
  });

  factory OffersRequestEntity.fromJson(Map<String, dynamic> json) => _$OffersRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffersRequestEntityToJson(this);
}
