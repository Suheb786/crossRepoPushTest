import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_details_entity.g.dart';

@JsonSerializable()
class CustomerDetailsEntity extends BaseLayerDataTransformer<CustomerDetailsEntity, CustomerInformation> {
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
  @JsonKey(name: "countryCurr")
  final String? countryCurr;
  @JsonKey(name: "stateCurr")
  final String? stateCurr;
  @JsonKey(name: "cityCurr")
  final String? cityCurr;
  @JsonKey(name: "addressHomeCountry")
  final dynamic addressHomeCountry;
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
  final String? areYouAusTaxResidentInd;
  @JsonKey(name: "wereYouBornInTheUSInd")
  final String? wereYouBornInTheUsInd;
  @JsonKey(name: "countryUSOrUAEInd")
  final String? countryUsOrUaeInd;
  @JsonKey(name: "phone1")
  final String? phone1;
  @JsonKey(name: "phone2")
  final String? phone2;
  @JsonKey(name: "mobileNo")
  final String? mobileNo;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "nic")
  final String? nic;
  @JsonKey(name: "nationalCardNumber")
  final String? nationalCardNumber;
  @JsonKey(name: "nicExpirydate")
  final DateTime? nicExpirydate;
  @JsonKey(name: "dob")
  final DateTime? dob;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "maritalstatus")
  final String? maritalstatus;
  @JsonKey(name: "tinind")
  final dynamic tinInd;
  @JsonKey(name: "tinno1Ind")
  final dynamic tinno1Ind;
  @JsonKey(name: "taxCountry1Ind")
  final dynamic taxCountry1Ind;
  @JsonKey(name: "tinNo2Ind")
  final dynamic tinNo2Ind;
  @JsonKey(name: "taxCountry2Ind")
  final String? taxCountry2Ind;
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
  final dynamic fatcaNoReason;
  @JsonKey(name: "reasonBind")
  final dynamic reasonBind;
  @JsonKey(name: "groupCode")
  final String? groupCode;
  @JsonKey(name: "mdmid")
  final dynamic mdmid;
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
  final String? nationality;
  @JsonKey(name: "idIssueCountry")
  final String? idIssueCountry;
  @JsonKey(name: "passportNumber")
  final String? passportNumber;
  @JsonKey(name: "passportIssueDate")
  final DateTime? passportIssueDate;
  @JsonKey(name: "passportExpiry")
  final dynamic passportExpiry;
  @JsonKey(name: "passportIssueCountry")
  final String? passportIssueCountry;
  @JsonKey(name: "passportGender")
  final String? passportGender;
  @JsonKey(name: "onboardingCountry")
  final String? onboardingCountry;
  @JsonKey(name: "employerName")
  final String? employerName;
  @JsonKey(name: "incomeBracket")
  final String? incomeBracket;
  @JsonKey(name: "kycReviewDate")
  final DateTime? kycReviewDate;
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
  final dynamic refererPromoCode;
  @JsonKey(name: "ourBranchId")
  final dynamic ourBranchId;
  @JsonKey(name: "idType")
  final String? idType;
  @JsonKey(name: "firstNameAR")
  final String? firstNameAr;
  @JsonKey(name: "secondNameAR")
  final String? secondNameAr;
  @JsonKey(name: "thirdNameAR")
  final String? thirdNameAr;
  @JsonKey(name: "familyNameAR")
  final String? familyNameAr;
  @JsonKey(name: "motherFirstName")
  final String? motherFirstName;
  @JsonKey(name: "placeofBirth")
  final String? placeofBirth;
  @JsonKey(name: "countryofBirth")
  final String? countryofBirth;
  @JsonKey(name: "relationshipPep")
  final String? relationshipPep;
  @JsonKey(name: "namePep")
  final dynamic namePep;
  @JsonKey(name: "rolePep")
  final dynamic rolePep;
  @JsonKey(name: "beneficialOwner")
  final String? beneficialOwner;
  @JsonKey(name: "districtCorresp")
  final String? districtCorresp;
  @JsonKey(name: "addressLine1")
  final String? addressLine1;
  @JsonKey(name: "spouseName")
  final String? spouseName;
  @JsonKey(name: "specialNeedsPerson")
  final String? specialNeedsPerson;
  @JsonKey(name: "natureofSpecialNeeds")
  final String? natureofSpecialNeeds;
  @JsonKey(name: "employmentStatus")
  final String? employmentStatus;
  @JsonKey(name: "occupation")
  final String? occupation;
  @JsonKey(name: "mainSourceofIncome")
  final String? mainSourceofIncome;
  @JsonKey(name: "otherEmploymentStatus")
  final String? otherEmploymentStatus;
  @JsonKey(name: "annualIncome")
  final int? annualIncome;
  @JsonKey(name: "monthlyIncome")
  final dynamic monthlyIncome;
  @JsonKey(name: "additionalIncomeSource")
  final String? additionalIncomeSource;
  @JsonKey(name: "otherAdditionalIncomeSource")
  final String? otherAdditionalIncomeSource;
  @JsonKey(name: "additionalIncomeAmount")
  final int? additionalIncomeAmount;
  @JsonKey(name: "employerPhone")
  final String? employerPhone;
  @JsonKey(name: "reasonforBanking")
  final String? reasonforBanking;
  @JsonKey(name: "preferredLanguage")
  final dynamic preferredLanguage;
  @JsonKey(name: "accountOfficer")
  final dynamic accountOfficer;
  @JsonKey(name: "ifrsFields")
  final dynamic ifrsFields;
  @JsonKey(name: "cbjSecretNumber")
  final dynamic cbjSecretNumber;
  @JsonKey(name: "obligerRating")
  final dynamic obligerRating;
  @JsonKey(name: "smsSubscription")
  final dynamic smsSubscription;
  @JsonKey(name: "titlear")
  final dynamic titlear;
  @JsonKey(name: "empCountry")
  final String? empCountry;
  @JsonKey(name: "empState")
  final dynamic empState;
  @JsonKey(name: "empCity")
  final String? empCity;

  CustomerDetailsEntity(
      {this.categoryId,
      this.name,
      this.addressCors,
      this.cityCors,
      this.countryCors,
      this.stateCors,
      this.addressCurr,
      this.countryCurr,
      this.stateCurr,
      this.cityCurr,
      this.addressHomeCountry,
      this.countryHome,
      this.stateHome,
      this.cityHome,
      this.residentNonResident,
      this.countryofResidence,
      this.fatcaRelevantInd,
      this.crsRelevantInd,
      this.areYouAuSCitizenInd,
      this.areYouAusTaxResidentInd,
      this.wereYouBornInTheUsInd,
      this.countryUsOrUaeInd,
      this.phone1,
      this.phone2,
      this.mobileNo,
      this.email,
      this.nic,
      this.nationalCardNumber,
      this.nicExpirydate,
      this.dob,
      this.gender,
      this.maritalstatus,
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
      this.passportIssueDate,
      this.passportExpiry,
      this.passportIssueCountry,
      this.passportGender,
      this.onboardingCountry,
      this.employerName,
      this.incomeBracket,
      this.kycReviewDate,
      this.dualCitizenship,
      this.citizenCountry2,
      this.pep,
      this.blackList,
      this.hni,
      this.refererPromoCode,
      this.ourBranchId,
      this.idType,
      this.firstNameAr,
      this.secondNameAr,
      this.thirdNameAr,
      this.familyNameAr,
      this.motherFirstName,
      this.placeofBirth,
      this.countryofBirth,
      this.relationshipPep,
      this.namePep,
      this.rolePep,
      this.beneficialOwner,
      this.districtCorresp,
      this.addressLine1,
      this.spouseName,
      this.specialNeedsPerson,
      this.natureofSpecialNeeds,
      this.employmentStatus,
      this.occupation,
      this.mainSourceofIncome,
      this.otherEmploymentStatus,
      this.annualIncome,
      this.monthlyIncome,
      this.additionalIncomeSource,
      this.otherAdditionalIncomeSource,
      this.additionalIncomeAmount,
      this.employerPhone,
      this.reasonforBanking,
      this.preferredLanguage,
      this.accountOfficer,
      this.ifrsFields,
      this.cbjSecretNumber,
      this.obligerRating,
      this.smsSubscription,
      this.titlear,
      this.empCountry,
      this.empState,
      this.empCity});

  factory CustomerDetailsEntity.fromJson(Map<String, dynamic> json) => _$CustomerDetailsEntityFromJson(json);

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
        phone1: data.phone1,
        phone2: data.phone2,
        mobileNo: data.mobileNo,
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
        employerName: data.employerName,
        incomeBracket: data.incomeBracket,
        kycReviewDate: data.kycReviewDate,
        dualCitizenship: data.dualCitizenship,
        citizenCountry2: data.citizenCountry2,
        pep: data.pep,
        blackList: data.blackList,
        hni: data.hni,
        refererPromoCode: data.refererPromoCode,
        annualIncome: data.annualIncome,
        occupation: data.occupation,
        spouseName: data.spouseName,
        employmentStatus: data.employmentStatus,
        email: data.email,
        additionalIncomeSource: data.additionalIncomeSource,
        monthlyIncome: data.monthlyIncome,
        accountOfficer: data.accountOfficer,
        additionalIncomeAmount: data.additionalIncomeAmount,
        addressLine1: data.addressLine1,
        areYouAusTaxResidentInd: data.areYouAusTaxResidentInd,
        beneficialOwner: data.beneficialOwner,
        cbjSecretNumber: data.cbjSecretNumber,
        countryofBirth: data.countryofBirth,
        countryUsOrUaeInd: data.countryUsOrUaeInd,
        districtCorresp: data.districtCorresp,
        empCity: data.empCity,
        empCountry: data.empCountry,
        employerPhone: data.employerPhone,
        empState: data.empState,
        familyNameAr: data.familyNameAr,
        firstNameAr: data.firstNameAr,
        idType: data.idType,
        ifrsFields: data.ifrsFields,
        mainSourceofIncome: data.mainSourceofIncome,
        maritalstatus: data.maritalstatus,
        motherFirstName: data.motherFirstName,
        namePep: data.namePep,
        nationalCardNumber: data.nationalCardNumber,
        natureofSpecialNeeds: data.natureofSpecialNeeds,
        nic: data.nic,
        nicExpirydate: data.nicExpirydate,
        obligerRating: data.obligerRating,
        otherAdditionalIncomeSource: data.otherAdditionalIncomeSource,
        otherEmploymentStatus: data.otherEmploymentStatus,
        ourBranchId: data.ourBranchId,
        passportIssueDate: data.passportIssueDate,
        placeofBirth: data.placeofBirth,
        preferredLanguage: data.preferredLanguage,
        reasonforBanking: data.reasonforBanking,
        relationshipPep: data.relationshipPep,
        rolePep: data.rolePep,
        secondNameAr: data.secondNameAr,
        smsSubscription: data.smsSubscription,
        specialNeedsPerson: data.specialNeedsPerson,
        thirdNameAr: data.thirdNameAr,
        titlear: data.titlear,
        wereYouBornInTheUsInd: data.wereYouBornInTheUsInd);
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
      phone1: this.phone1,
      phone2: this.phone2,
      mobileNo: this.mobileNo,
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
      employerName: this.employerName,
      incomeBracket: this.incomeBracket,
      kycReviewDate: this.kycReviewDate,
      dualCitizenship: this.dualCitizenship,
      citizenCountry2: this.citizenCountry2,
      pep: this.pep,
      blackList: this.blackList,
      hni: this.hni,
      refererPromoCode: this.refererPromoCode,
      annualIncome: this.annualIncome,
      occupation: this.occupation,
      spouseName: this.spouseName,
      employmentStatus: this.employmentStatus,
      email: this.email,
      additionalIncomeSource: this.additionalIncomeSource,
      monthlyIncome: this.monthlyIncome,
      accountOfficer: this.accountOfficer,
      additionalIncomeAmount: this.additionalIncomeAmount,
      addressLine1: this.addressLine1,
      areYouAusTaxResidentInd: this.areYouAusTaxResidentInd,
      beneficialOwner: this.beneficialOwner,
      cbjSecretNumber: this.cbjSecretNumber,
      countryofBirth: this.countryofBirth,
      countryUsOrUaeInd: this.countryUsOrUaeInd,
      districtCorresp: this.districtCorresp,
      empCity: this.empCity,
      empCountry: this.empCountry,
      employerPhone: this.employerPhone,
      empState: this.empState,
      familyNameAr: this.familyNameAr,
      firstNameAr: this.firstNameAr,
      idType: this.idType,
      ifrsFields: this.ifrsFields,
      mainSourceofIncome: this.mainSourceofIncome,
      maritalstatus: this.maritalstatus,
      motherFirstName: this.motherFirstName,
      namePep: this.namePep,
      nationalCardNumber: this.nationalCardNumber,
      natureofSpecialNeeds: this.natureofSpecialNeeds,
      nic: this.nic,
      nicExpirydate: this.nicExpirydate,
      obligerRating: this.obligerRating,
      otherAdditionalIncomeSource: this.otherAdditionalIncomeSource,
      otherEmploymentStatus: this.otherEmploymentStatus,
      ourBranchId: this.ourBranchId,
      passportIssueDate: this.passportIssueDate,
      placeofBirth: this.placeofBirth,
      preferredLanguage: this.preferredLanguage,
      reasonforBanking: this.reasonforBanking,
      relationshipPep: this.relationshipPep,
      rolePep: this.rolePep,
      secondNameAr: this.secondNameAr,
      smsSubscription: this.smsSubscription,
      specialNeedsPerson: this.specialNeedsPerson,
      thirdNameAr: this.thirdNameAr,
      titlear: this.titlear,
      wereYouBornInTheUsInd: this.wereYouBornInTheUsInd,
    );
  }
}
