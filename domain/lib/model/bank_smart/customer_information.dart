class CustomerInformation {
  final String? categoryId;
  final String? name;
  final String? addressCors;
  final String? cityCors;
  final String? countryCors;
  final String? stateCors;
  final String? addressCurr;
  final String? countryCurr;
  final String? stateCurr;
  final String? cityCurr;
  final dynamic addressHomeCountry;
  final String? countryHome;
  final String? stateHome;
  final String? cityHome;
  final String? residentNonResident;
  final String? countryofResidence;
  final String? fatcaRelevantInd;
  final String? crsRelevantInd;
  final String? areYouAuSCitizenInd;
  final String? areYouAusTaxResidentInd;
  final String? wereYouBornInTheUsInd;
  final String? countryUsOrUaeInd;
  final String? phone1;
  final String? phone2;
  final String? mobileNo;
  final String? email;
  final String? nic;
  final String? nationalCardNumber;
  final DateTime? nicExpirydate;
  final DateTime? dob;
  final String? gender;
  final String? maritalstatus;
  final String? tinInd;
  final dynamic tinno1Ind;
  final dynamic taxCountry1Ind;
  final dynamic tinNo2Ind;
  final String? taxCountry2Ind;
  final String? tinNo3Ind;
  final String? taxCountry3Ind;
  final String? tinNo4Ind;
  final String? taxCountry4Ind;
  final String? tinNo5Ind;
  final String? taxCountry5Ind;
  final dynamic fatcaNoReason;
  final dynamic reasonBind;
  final String? groupCode;
  final dynamic mdmid;
  final String? rManager;
  final String? riskProfile;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? nationality;
  final String? idIssueCountry;
  final String? passportNumber;
  final DateTime? passportIssueDate;
  final dynamic passportExpiry;
  final String? passportIssueCountry;
  final String? passportGender;
  final String? onboardingCountry;
  final String? employerName;
  final String? incomeBracket;
  final DateTime? kycReviewDate;
  final String? dualCitizenship;
  final String? citizenCountry2;
  final String? pep;
  final String? blackList;
  final String? hni;
  final dynamic refererPromoCode;
  final dynamic ourBranchId;
  final String? idType;
  final String? firstNameAr;
  final String? secondNameAr;
  final String? thirdNameAr;
  final String? familyNameAr;
  final String? motherFirstName;
  final String? placeofBirth;
  final String? countryofBirth;
  final String? relationshipPep;
  final dynamic namePep;
  final dynamic rolePep;
  final String? beneficialOwner;
  final String? districtCorresp;
  final String? addressLine1;
  final String? spouseName;
  final String? specialNeedsPerson;
  final String? natureofSpecialNeeds;
  final String? employmentStatus;
  final String? occupation;
  final String? mainSourceofIncome;
  final String? otherEmploymentStatus;
  final int? annualIncome;
  final dynamic monthlyIncome;
  final String? additionalIncomeSource;
  final String? otherAdditionalIncomeSource;
  final int? additionalIncomeAmount;
  final String? employerPhone;
  final String? reasonforBanking;
  final dynamic preferredLanguage;
  final dynamic accountOfficer;
  final dynamic ifrsFields;
  final dynamic cbjSecretNumber;
  final dynamic obligerRating;
  final dynamic smsSubscription;
  final dynamic titlear;
  final String? empCountry;
  final dynamic empState;
  final String? empCity;

  CustomerInformation({
    this.categoryId,
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
    this.passportExpiry,
    this.passportIssueCountry,
    this.passportGender,
    this.onboardingCountry,
    this.employerName,
    this.incomeBracket,
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
    this.empCity,
    this.nicExpirydate,
    this.dob,
    this.passportIssueDate,
    this.kycReviewDate,
  });
}
