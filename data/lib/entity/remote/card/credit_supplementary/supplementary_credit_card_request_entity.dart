import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_request_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardRequestEntity {
  @JsonKey(name: "PrimaryCardId")
  String? primaryCardId;
  @JsonKey(name: "Relationship")
  String? relationship;
  @JsonKey(name: "DOI")
  dynamic doi;
  @JsonKey(name: "Type")
  String? type;
  @JsonKey(name: "FullName")
  String? fullName;
  @JsonKey(name: "FirstName")
  String? firstName;
  @JsonKey(name: "MiddleName")
  String? middleName;
  @JsonKey(name: "FamilyName")
  String? familyName;
  @JsonKey(name: "IdNumber")
  String? idNumber;
  @JsonKey(name: "DOB")
  String? dob;
  @JsonKey(name: "DOE")
  String? doe;
  @JsonKey(name: "Gender")
  String? gender;
  @JsonKey(name: "DocumentCode")
  String? documentCode;
  @JsonKey(name: "DocumentNumber")
  String? documentNumber;
  @JsonKey(name: "Issuer")
  String? issuer;
  @JsonKey(name: "Nationality")
  String? nationality;
  @JsonKey(name: "OptionalData1")
  String? optionalData1;
  @JsonKey(name: "OptionalData2")
  String? optionalData2;
  @JsonKey(name: "MrtDraw")
  String? mrtDraw;
  @JsonKey(name: "FrontCardImage")
  String? frontCardImage;
  @JsonKey(name: "BackCardImage")
  String? backCardImage;
  @JsonKey(name: "NickName")
  String? nickName;
  @JsonKey(name: "SameLimit")
  bool? sameLimit;
  @JsonKey(name: "Limit")
  num? limit;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SupplementaryCreditCardRequestEntity({
    this.primaryCardId,
    this.type,
    this.limit,
    this.fullName,
    this.nationality,
    this.gender,
    this.firstName,
    this.dob,
    this.nickName,
    this.backCardImage,
    this.documentCode,
    this.documentNumber,
    this.doe,
    this.doi,
    this.familyName,
    this.frontCardImage,
    this.idNumber,
    this.issuer,
    this.middleName,
    this.mrtDraw,
    this.optionalData1,
    this.optionalData2,
    this.relationship,
    this.sameLimit,
    this.getToken = false,
    required this.baseData,
  });

  factory SupplementaryCreditCardRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryCreditCardRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupplementaryCreditCardRequestEntityToJson(this);
}
