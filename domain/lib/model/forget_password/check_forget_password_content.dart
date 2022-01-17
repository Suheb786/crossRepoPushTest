import 'package:domain/model/forget_password/allowed_services.dart';

class CheckForgetPasswordContent {
  CheckForgetPasswordContent({
    this.languageCode,
    this.isZxAccount,
    this.zxAccountNumber,
    this.isZxAccountDecativated,
    this.isProccessAccount,
    this.previousSerial,
    this.getDebitAuth,
    this.isGetDebitAuth,
    this.fullName,
    this.emailId,
    this.mobileStatus,
    this.mobileNumber,
    this.emailStatus,
    this.userId,
    this.account,
    this.status,
    this.existing,
    this.newDevice,
    this.isSaudi,
    this.gIsSaudi,
    this.nationality,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.isTalent,
    this.idIssuer,
    this.debitCardRequested,
    this.debitCardRequestStatus,
    this.syncContacts,
    this.allowMeToDiscoverable,
    this.mtAccount,
    this.mtId,
    this.userName,
    this.image,
    this.benBlobImage,
    this.nameOnCard,
    this.closureDate,
    this.accountStatus,
    this.accountNumber,
    this.tokenTimeOut,
    this.isUserBlackListed,
    this.isAccountBlackListed,
    this.allowedServices,
    this.isRating,
    this.lastLogin,
    this.cif,
    this.idno,
    this.cardNumber,
    this.isKycExpire,
    this.isIdExpire,
    this.kycExpireTemp,
    this.idExpireTemp,
    this.imtfStatus,
    this.inboxStatus,
    this.isCoachMark,
    this.scheduleTime,
    this.isCallschedule,
  });

  String? languageCode;
  bool? isZxAccount;
  String? zxAccountNumber;
  bool? isZxAccountDecativated;
  bool? isProccessAccount;
  String? previousSerial;
  List<dynamic>? getDebitAuth;
  bool? isGetDebitAuth;
  String? fullName;
  String? emailId;
  bool? mobileStatus;
  String? mobileNumber;
  bool? emailStatus;
  String? userId;
  bool? account;
  String? status;
  bool? existing;
  bool? newDevice;
  bool? isSaudi;
  bool? gIsSaudi;
  String? nationality;
  String? firstName;
  String? lastName;
  String? gender;
  DateTime? dob;
  bool? isTalent;
  String? idIssuer;
  bool? debitCardRequested;
  String? debitCardRequestStatus;
  bool? syncContacts;
  bool? allowMeToDiscoverable;
  dynamic mtAccount;
  dynamic mtId;
  String? userName;
  String? image;
  String? benBlobImage;
  String? nameOnCard;
  DateTime? closureDate;
  String? accountStatus;
  String? accountNumber;
  num? tokenTimeOut;
  bool? isUserBlackListed;
  bool? isAccountBlackListed;
  AllowedServices? allowedServices;
  bool? isRating;
  String? lastLogin;
  String? cif;
  String? idno;
  String? cardNumber;
  bool? isKycExpire;
  bool? isIdExpire;
  bool? kycExpireTemp;
  bool? idExpireTemp;
  dynamic imtfStatus;
  bool? inboxStatus;
  bool? isCoachMark;
  dynamic scheduleTime;
  bool? isCallschedule;
}
