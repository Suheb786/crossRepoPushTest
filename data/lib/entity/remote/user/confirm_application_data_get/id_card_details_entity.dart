import 'package:domain/model/user/confirm_application_data_get/id_card_details_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_card_details_entity.g.dart';

@JsonSerializable()
class IdCardDetailsEntity implements BaseLayerDataTransformer<IdCardDetailsEntity, IdCardDetailsInfo> {
  @JsonKey(name: "fullNameEn")
  final String? fullNameEn;
  @JsonKey(name: "fullNameAr")
  final String? fullNameAr;
  @JsonKey(name: "nationalID")
  final String? nationalID;
  @JsonKey(name: "placeOfBirthEn")
  final String? placeOfBirthEn;
  @JsonKey(name: "placeOfBirthAr")
  final String? placeOfBirthAr;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "motherNameEn")
  final String? motherNameEn;
  @JsonKey(name: "motherNameAr")
  final String? motherNameAr;
  @JsonKey(name: "dateOfBirth")
  final String? dateOfBirth;
  @JsonKey(name: "documentNo")
  final String? documentNo;
  @JsonKey(name: "issuingDate")
  final String? issuingDate;
  @JsonKey(name: "expiryDate")
  final String? expiryDate;
  @JsonKey(name: "issuingPlace")
  final String? issuingPlace;

  IdCardDetailsEntity(
      {this.fullNameEn,
      this.fullNameAr,
      this.nationalID,
      this.placeOfBirthEn,
      this.placeOfBirthAr,
      this.gender,
      this.motherNameEn,
      this.motherNameAr,
      this.dateOfBirth,
      this.documentNo,
      this.issuingDate,
      this.expiryDate,
      this.issuingPlace});

  factory IdCardDetailsEntity.fromJson(Map<String, dynamic> json) => _$IdCardDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$IdCardDetailsEntityToJson(this);

  @override
  IdCardDetailsEntity restore(IdCardDetailsInfo response) {
    return IdCardDetailsEntity(
      dateOfBirth: response.dateOfBirth,
      documentNo: response.documentNo,
      expiryDate: response.expiryDate,
      fullNameAr: response.fullNameAr,
      issuingDate: response.issuingDate,
      issuingPlace: response.issuingPlace,
      motherNameAr: response.motherNameAr,
      motherNameEn: response.motherNameEn,
      nationalID: response.nationalID,
      placeOfBirthAr: response.placeOfBirthAr,
      placeOfBirthEn: response.placeOfBirthEn,
      gender: response.gender,
      fullNameEn: response.fullNameEn,
    );
  }

  @override
  IdCardDetailsInfo transform() {
    return IdCardDetailsInfo(
      dateOfBirth: dateOfBirth,
      documentNo: documentNo,
      expiryDate: expiryDate,
      fullNameAr: fullNameAr,
      fullNameEn: fullNameEn,
      gender: gender,
      issuingDate: issuingDate,
      issuingPlace: issuingPlace,
      motherNameAr: motherNameAr,
      motherNameEn: motherNameEn,
      nationalID: nationalID,
      placeOfBirthAr: placeOfBirthAr,
      placeOfBirthEn: placeOfBirthEn,
    );
  }
}
