import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_details_entity.g.dart';

@JsonSerializable()
class CustomerDetailsEntity extends BaseLayerDataTransformer<
    CustomerDetailsEntity, CustomerInformation> {
  @JsonKey(name: "categoryId")
  final String? categoryId;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "addressCors")
  final String? addressCors;
  @JsonKey(name: "cityCors")
  final String? cityCors;
  @JsonKey(name: "countryCors")
  final String? countryCors;
  @JsonKey(name: "stateCors")
  final String? stateCors;
  @JsonKey(name: "addressCurr")
  final String? addressCurr;
  @JsonKey(name: "cityCurr")
  final String? cityCurr;
  @JsonKey(name: "countryCurr")
  final String? countryCurr;
  @JsonKey(name: "stateCurr")
  final String? stateCurr;
  @JsonKey(name: "addressHomeCountry")
  final String? addressHomeCountry;
  @JsonKey(name: "countryHome")
  final String? countryHome;
  @JsonKey(name: "stateHome")
  final String? stateHome;
  @JsonKey(name: "cityHome")
  final String? cityHome;
  @JsonKey(name: "residentNonResident")
  final String? residentNonResident;
  @JsonKey(name: "countryofResidence")
  final String? countryofResidence;
  @JsonKey(name: "fatcaRelevantInd")
  final String? fatcaRelevantInd;
  @JsonKey(name: "crsRelevantInd")
  final String? crsRelevantInd;
  @JsonKey(name: "areYouAuSCitizenInd")
  final String? areYouAuSCitizenInd;
  @JsonKey(name: "areYouAUSTaxResidentInd")
  final String? areYouAUSTaxResidentInd;
  @JsonKey(name: "wereYouBornInTheUSInd")
  final String? wereYouBornInTheUSInd;
  @JsonKey(name: "countryUSOrUAEInd")
  final String? countryUSOrUAEInd;
  @JsonKey(name: "phone1")
  final String? phone1;
  @JsonKey(name: "phone2")
  final String? phone2;
  @JsonKey(name: "mobileNo")
  final String? mobileNo;
  @JsonKey(name: "customerEmail")
  final String? customerEmail;
  @JsonKey(name: "idno")
  final String? idno;
  @JsonKey(name: "idExpirydate")
  final String? idExpirydate;
  @JsonKey(name: "dob")
  final String? dob;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "tinInd")
  final String? tinInd;
  @JsonKey(name: "tinno1Ind")
  final String? tinno1Ind;
  @JsonKey(name: "taxCountry1Ind")
  final String? taxCountry1Ind;
  @JsonKey(name: "tinNo2Ind")
  final double? tinNo2Ind;
  @JsonKey(name: "taxCountry2Ind")
  final double? taxCountry2Ind;
  @JsonKey(name: "tinNo3Ind")
  final String? tinNo3Ind;
  @JsonKey(name: "taxCountry3Ind")
  final String? taxCountry3Ind;
  @JsonKey(name: "tinNo4Ind")
  final String? tinNo4Ind;
  @JsonKey(name: "taxCountry4Ind")
  final String? taxCountry4Ind;
  @JsonKey(name: "tinNo5Ind")
  final String? tinNo5Ind;
  @JsonKey(name: "taxCountry5Ind")
  final String? taxCountry5Ind;
  @JsonKey(name: "fatcaNoReason")
  final String? fatcaNoReason;
  @JsonKey(name: "reasonBind")
  final double? reasonBind;
  @JsonKey(name: "groupCode")
  final String? groupCode;
  @JsonKey(name: "mdmid")
  final String? mdmid;
  @JsonKey(name: "rManager")
  final String? rManager;
  @JsonKey(name: "riskProfile")
  final String? riskProfile;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "middleName")
  final String? middleName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "nationality")
  final double? nationality;
  @JsonKey(name: "idIssueCountry")
  final String? idIssueCountry;
  @JsonKey(name: "passportNumber")
  final String? passportNumber;
  @JsonKey(name: "passportExpiry")
  final String? passportExpiry;
  @JsonKey(name: "passportIssueCountry")
  final String? passportIssueCountry;
  @JsonKey(name: "passportGender")
  final String? passportGender;
  @JsonKey(name: "onboardingCountry")
  final String? onboardingCountry;
  @JsonKey(name: "profession")
  final String? profession;
  @JsonKey(name: "employerName")
  final double? employerName;
  @JsonKey(name: "incomeBracket")
  final String? incomeBracket;
  @JsonKey(name: "kycReviewDate")
  final String? kycReviewDate;
  @JsonKey(name: "dualCitizenship")
  final String? dualCitizenship;
  @JsonKey(name: "citizenCountry2")
  final String? citizenCountry2;
  @JsonKey(name: "pep")
  final String? pep;
  @JsonKey(name: "blackList")
  final String? blackList;
  @JsonKey(name: "hni")
  final String? hni;
  @JsonKey(name: "refererPromoCode")
  final String? refererPromoCode;
  @JsonKey(name: "ourBranchID")
  final String? ourBranchID;
  @JsonKey(name: "createBy")
  final String? createBy;

  CustomerDetailsEntity(
      {this.categoryId,
      this.name,
      this.addressCors,
      this.cityCors,
      this.countryCors,
      this.stateCors,
      this.addressCurr,
      this.cityCurr,
      this.countryCurr,
      this.stateCurr,
      this.addressHomeCountry,
      this.countryHome,
      this.stateHome,
      this.cityHome,
      this.residentNonResident,
      this.countryofResidence,
      this.fatcaRelevantInd,
      this.crsRelevantInd,
      this.areYouAuSCitizenInd,
      this.areYouAUSTaxResidentInd,
      this.wereYouBornInTheUSInd,
      this.countryUSOrUAEInd,
      this.phone1,
      this.phone2,
      this.mobileNo,
      this.customerEmail,
      this.idno,
      this.idExpirydate,
      this.dob,
      this.gender,
      this.tinInd,
      this.tinno1Ind,
      this.taxCountry1Ind,
      this.tinNo2Ind,
      this.taxCountry2Ind,
      this.tinNo3Ind,
      this.taxCountry3Ind,
      this.tinNo4Ind,
      this.taxCountry4Ind,
      this.tinNo5Ind,
      this.taxCountry5Ind,
      this.fatcaNoReason,
      this.reasonBind,
      this.groupCode,
      this.mdmid,
      this.rManager,
      this.riskProfile,
      this.firstName,
      this.middleName,
      this.lastName,
      this.nationality,
      this.idIssueCountry,
      this.passportNumber,
      this.passportExpiry,
      this.passportIssueCountry,
      this.passportGender,
      this.onboardingCountry,
      this.profession,
      this.employerName,
      this.incomeBracket,
      this.kycReviewDate,
      this.dualCitizenship,
      this.citizenCountry2,
      this.pep,
      this.blackList,
      this.hni,
      this.refererPromoCode,
      this.ourBranchID,
      this.createBy});

  factory CustomerDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsEntityToJson(this);

  @override
  CustomerDetailsEntity restore(CustomerInformation data) {
    return CustomerDetailsEntity(
        categoryId: data.categoryId,
        name: data.name,
        addressCors: data.addressCors,
        cityCors: data.cityCors,
        countryCors: data.countryCors,
        stateCors: data.stateCors,
        addressCurr: data.addressCurr,
        cityCurr: data.cityCurr,
        countryCurr: data.countryCurr,
        stateCurr: data.stateCurr,
        addressHomeCountry: data.addressHomeCountry,
        countryHome: data.countryHome,
        stateHome: data.stateHome,
        cityHome: data.cityHome,
        residentNonResident: data.residentNonResident,
        countryofResidence: data.countryofResidence,
        fatcaRelevantInd: data.fatcaRelevantInd,
        crsRelevantInd: data.crsRelevantInd,
        areYouAuSCitizenInd: data.areYouAuSCitizenInd,
        areYouAUSTaxResidentInd: data.areYouAUSTaxResidentInd,
        wereYouBornInTheUSInd: data.wereYouBornInTheUSInd,
        countryUSOrUAEInd: data.countryUSOrUAEInd,
        phone1: data.phone1,
        phone2: data.phone2,
        mobileNo: data.mobileNo,
        customerEmail: data.customerEmail,
        idno: data.idno,
        idExpirydate: data.idExpirydate,
        dob: data.dob,
        gender: data.gender,
        tinInd: data.tinInd,
        tinno1Ind: data.tinno1Ind,
        taxCountry1Ind: data.taxCountry1Ind,
        tinNo2Ind: data.tinNo2Ind,
        taxCountry2Ind: data.taxCountry2Ind,
        tinNo3Ind: data.tinNo3Ind,
        taxCountry3Ind: data.taxCountry3Ind,
        tinNo4Ind: data.tinNo4Ind,
        taxCountry4Ind: data.taxCountry4Ind,
        tinNo5Ind: data.tinNo5Ind,
        taxCountry5Ind: data.taxCountry5Ind,
        fatcaNoReason: data.fatcaNoReason,
        reasonBind: data.reasonBind,
        groupCode: data.groupCode,
        mdmid: data.mdmid,
        rManager: data.rManager,
        riskProfile: data.riskProfile,
        firstName: data.firstName,
        middleName: data.middleName,
        lastName: data.lastName,
        nationality: data.nationality,
        idIssueCountry: data.idIssueCountry,
        passportNumber: data.passportNumber,
        passportExpiry: data.passportExpiry,
        passportIssueCountry: data.passportIssueCountry,
        passportGender: data.passportGender,
        onboardingCountry: data.onboardingCountry,
        profession: data.profession,
        employerName: data.employerName,
        incomeBracket: data.incomeBracket,
        kycReviewDate: data.kycReviewDate,
        dualCitizenship: data.dualCitizenship,
        citizenCountry2: data.citizenCountry2,
        pep: data.pep,
        blackList: data.blackList,
        hni: data.hni,
        refererPromoCode: data.refererPromoCode,
        ourBranchID: data.ourBranchID,
        createBy: data.createBy);
  }

  @override
  CustomerInformation transform() {
    return CustomerInformation(
        categoryId: this.categoryId,
        name: this.name,
        addressCors: this.addressCors,
        cityCors: this.cityCors,
        countryCors: this.countryCors,
        stateCors: this.stateCors,
        addressCurr: this.addressCurr,
        cityCurr: this.cityCurr,
        countryCurr: this.countryCurr,
        stateCurr: this.stateCurr,
        addressHomeCountry: this.addressHomeCountry,
        countryHome: this.countryHome,
        stateHome: this.stateHome,
        cityHome: this.cityHome,
        residentNonResident: this.residentNonResident,
        countryofResidence: this.countryofResidence,
        fatcaRelevantInd: this.fatcaRelevantInd,
        crsRelevantInd: this.crsRelevantInd,
        areYouAuSCitizenInd: this.areYouAuSCitizenInd,
        areYouAUSTaxResidentInd: this.areYouAUSTaxResidentInd,
        wereYouBornInTheUSInd: this.wereYouBornInTheUSInd,
        countryUSOrUAEInd: this.countryUSOrUAEInd,
        phone1: this.phone1,
        phone2: this.phone2,
        mobileNo: this.mobileNo,
        customerEmail: this.customerEmail,
        idno: this.idno,
        idExpirydate: this.idExpirydate,
        dob: this.dob,
        gender: this.gender,
        tinInd: this.tinInd,
        tinno1Ind: this.tinno1Ind,
        taxCountry1Ind: this.taxCountry1Ind,
        tinNo2Ind: this.tinNo2Ind,
        taxCountry2Ind: this.taxCountry2Ind,
        tinNo3Ind: this.tinNo3Ind,
        taxCountry3Ind: this.taxCountry3Ind,
        tinNo4Ind: this.tinNo4Ind,
        taxCountry4Ind: this.taxCountry4Ind,
        tinNo5Ind: this.tinNo5Ind,
        taxCountry5Ind: this.taxCountry5Ind,
        fatcaNoReason: this.fatcaNoReason,
        reasonBind: this.reasonBind,
        groupCode: this.groupCode,
        mdmid: this.mdmid,
        rManager: this.rManager,
        riskProfile: this.riskProfile,
        firstName: this.firstName,
        middleName: this.middleName,
        lastName: this.lastName,
        nationality: this.nationality,
        idIssueCountry: this.idIssueCountry,
        passportNumber: this.passportNumber,
        passportExpiry: this.passportExpiry,
        passportIssueCountry: this.passportIssueCountry,
        passportGender: this.passportGender,
        onboardingCountry: this.onboardingCountry,
        profession: this.profession,
        employerName: this.employerName,
        incomeBracket: this.incomeBracket,
        kycReviewDate: this.kycReviewDate,
        dualCitizenship: this.dualCitizenship,
        citizenCountry2: this.citizenCountry2,
        pep: this.pep,
        blackList: this.blackList,
        hni: this.hni,
        refererPromoCode: this.refererPromoCode,
        ourBranchID: this.ourBranchID,
        createBy: this.createBy);
  }
}
