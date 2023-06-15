import 'package:json_annotation/json_annotation.dart';

part 'search_contact_request.g.dart';

@JsonSerializable()
class SearchContactRequest {
  @JsonKey(name: "SearchText")
  final String searchText;

  @JsonKey(name: "IsFromMobile")
  final bool isFromMobile;

  @JsonKey(name: "BeneType")
  final String beneType;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SearchContactRequest({
    required this.searchText,
    required this.isFromMobile,
    required this.beneType,
    this.getToken = true,
    required this.baseData,
  });

  factory SearchContactRequest.fromJson(Map<String, dynamic> json) => _$SearchContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchContactRequestToJson(this);
}
