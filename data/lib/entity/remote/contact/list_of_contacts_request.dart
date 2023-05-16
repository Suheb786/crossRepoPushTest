import 'package:json_annotation/json_annotation.dart';

part 'list_of_contacts_request.g.dart';

@JsonSerializable()
class ListOfContactRequest {
  @JsonKey(name: "IsFromMobile")
  final bool? isFromMobile;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ListOfContactRequest({
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory ListOfContactRequest.fromJson(Map<String, dynamic> json) => _$ListOfContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListOfContactRequestToJson(this);
}
