import 'package:json_annotation/json_annotation.dart';

part 'my_vouchers_request.g.dart';

@JsonSerializable()
class MyVouchersRequest {
  @JsonKey(name: "PageNo")
  final String? PageNo;

  @JsonKey(name: "FromDate")
  final String? FromDate;

  @JsonKey(name: "ToDate")
  final String? ToDate;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  MyVouchersRequest({
    this.PageNo,
    this.FromDate,
    this.ToDate,
    this.getToken = true,
    required this.baseData,
  });

  factory MyVouchersRequest.fromJson(Map<String, dynamic> json) => _$MyVouchersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyVouchersRequestToJson(this);
}
