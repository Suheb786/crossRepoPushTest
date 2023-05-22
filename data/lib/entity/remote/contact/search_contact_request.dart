import 'package:json_annotation/json_annotation.dart';

part 'search_contact_request.g.dart';

@JsonSerializable()
class SearchContactRequest {
  @JsonKey(name: "SearchText")
  final String? searchText;

  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SearchContactRequest({
    this.searchText,
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory SearchContactRequest.fromJson(Map<String, dynamic> json) => _$SearchContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchContactRequestToJson(this);
}
