class User {
  String? token;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? mobileCode;
  bool? isCurrent;
  String? refreshToken;
  String? tokenType;
  int? expiredIn;
  bool? isExisting;
  bool? newDevice;
  String? privatePEM;
  String? publicPEM;
  bool? isBiometricEnabled;
  String? cifNumber;
  String? accountNumber;
  String? applicationId;
  String? selectedLanguage;
  bool? applePay;
  bool? allCardsAddedToAppleWallet;
  bool? isRJPopUPClicked;
  bool? isEfawateerPopUPClicked;
  bool? isEVoucherPopUPClicked;
  bool? isApplePayPopUpClicked;
  dynamic localProfileImageDB;
  bool? isProfileApiCall;
  String? idWiseRefId;

  User(
      {this.token,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.mobileCode,
      this.isCurrent,
      this.refreshToken,
      this.tokenType,
      this.expiredIn,
      this.isExisting,
      this.publicPEM,
      this.privatePEM,
      this.cifNumber,
      this.accountNumber,
      this.newDevice = false,
      this.isBiometricEnabled,
      this.applicationId = "",
      this.selectedLanguage = 'en',
      this.applePay,
      this.allCardsAddedToAppleWallet,
      this.isRJPopUPClicked,
      this.isEfawateerPopUPClicked,
      this.isEVoucherPopUPClicked,
      this.isApplePayPopUpClicked,
      this.localProfileImageDB,
      this.isProfileApiCall,
      this.idWiseRefId});

  String get profileName => "${firstName ?? ""} ${lastName ?? ""}";

  factory User.fromJson(Map<String, dynamic> json) => User(
      token: json["token"],
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      mobile: json["mobile"],
      mobileCode: json["mobileCode"],
      isCurrent: json["isCurrent"],
      refreshToken: json["refreshToken"],
      tokenType: json["tokenType"],
      expiredIn: json["expiredIn"],
      isExisting: json["isExisting"],
      publicPEM: json["publicPEM"],
      privatePEM: json["privatePEM"],
      cifNumber: json["cifNumber"],
      accountNumber: json["accountNumber"],
      newDevice: json["newDevice"],
      isBiometricEnabled: json["isBiometricEnabled"],
      applicationId: json["applicationId"],
      allCardsAddedToAppleWallet: json["allCardsAddedToAppleWallet"],
      selectedLanguage: json["selectedLanguage"],
      isRJPopUPClicked: json["isRJPopUPClicked"],
      isEfawateerPopUPClicked: json["isEfawateerPopUPClicked"],
      isEVoucherPopUPClicked: json["isEVoucherPopUPClicked"],
      isApplePayPopUpClicked: json["isApplePayPopUpClicked"],
      localProfileImageDB: json["localProfileImageDB"],
      isProfileApiCall: json["isProfileApiCall"],
      idWiseRefId:json["idWiseRefId"]
  );

  Map<String, dynamic> toJson() =>
      {
        "token": token,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "mobileCode": mobileCode,
        "isCurrent": isCurrent,
        "refreshToken": refreshToken,
        "tokenType": tokenType,
        "expiredIn": expiredIn,
        "isExisting": isExisting,
        "publicPEM": publicPEM,
        "privatePEM": privatePEM,
        "cifNumber": cifNumber,
        "accountNumber": accountNumber,
        "newDevice": newDevice,
        "isBiometricEnabled": isBiometricEnabled,
        "applicationId": applicationId,
        "selectedLanguage": selectedLanguage,
        "allCardsAddedToAppleWallet": allCardsAddedToAppleWallet,
        "isRJPopUPClicked": isRJPopUPClicked,
        "isEfawateerPopUPClicked": isEfawateerPopUPClicked,
        "isEVoucherPopUPClicked": isEVoucherPopUPClicked,
        "isApplePayPopUpClicked": isApplePayPopUpClicked,
        "localProfileImageDB": localProfileImageDB,
        "isProfileApiCall": isProfileApiCall,
        "idWiseRefId":idWiseRefId
      };
}
