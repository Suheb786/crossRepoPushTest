import 'package:data/entity/remote/forget_password/allowed_services_entity.dart';
import 'package:domain/model/forget_password/check_forget_password_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_forget_password_content_entity.g.dart";

@JsonSerializable()
class CheckForgetPasswordContentEntity
    implements
        BaseLayerDataTransformer<CheckForgetPasswordContentEntity,
            CheckForgetPasswordContent> {
  @JsonKey(name: "languageCode")
  String? languageCode;
  @JsonKey(name: "isZxAccount")
  bool? isZxAccount;
  @JsonKey(name: "zxAccountNumber")
  String? zxAccountNumber;
  @JsonKey(name: "isZXAccountDecativated")
  bool? isZxAccountDecativated;
  @JsonKey(name: "isProccessAccount")
  bool? isProccessAccount;
  @JsonKey(name: "previousSerial")
  String? previousSerial;
  @JsonKey(name: "getDebitAuth")
  List<dynamic>? getDebitAuth;
  @JsonKey(name: "isGetDebitAuth")
  bool? isGetDebitAuth;
  @JsonKey(name: "fullName")
  String? fullName;
  @JsonKey(name: "emailId")
  String? emailId;
  @JsonKey(name: "mobileStatus")
  bool? mobileStatus;
  @JsonKey(name: "mobileNumber")
  String? mobileNumber;
  @JsonKey(name: "emailStatus")
  bool? emailStatus;
  @JsonKey(name: "userId")
  String? userId;
  @JsonKey(name: "account")
  bool? account;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "existing")
  bool? existing;
  @JsonKey(name: "newDevice")
  bool? newDevice;
  @JsonKey(name: "isSaudi")
  bool? isSaudi;
  @JsonKey(name: "gIsSaudi")
  bool? gIsSaudi;
  @JsonKey(name: "nationality")
  String? nationality;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "dob")
  DateTime? dob;
  @JsonKey(name: "isTalent")
  bool? isTalent;
  @JsonKey(name: "idIssuer")
  String? idIssuer;
  @JsonKey(name: "debitCardRequested")
  bool? debitCardRequested;
  @JsonKey(name: "debitCardRequestStatus")
  String? debitCardRequestStatus;
  @JsonKey(name: "syncContacts")
  bool? syncContacts;
  @JsonKey(name: "allowMeToDiscoverable")
  bool? allowMeToDiscoverable;
  @JsonKey(name: "mtAccount")
  dynamic mtAccount;
  @JsonKey(name: "mtId")
  dynamic mtId;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "benBlobImage")
  String? benBlobImage;
  @JsonKey(name: "nameOnCard")
  String? nameOnCard;
  @JsonKey(name: "closureDate")
  DateTime? closureDate;
  @JsonKey(name: "accountStatus")
  String? accountStatus;
  @JsonKey(name: "accountNumber")
  String? accountNumber;
  @JsonKey(name: "tokenTimeOut")
  num? tokenTimeOut;
  @JsonKey(name: "isUserBlackListed")
  bool? isUserBlackListed;
  @JsonKey(name: "isAccountBlackListed")
  bool? isAccountBlackListed;
  @JsonKey(name: "allowedServices")
  AllowedServicesEntity? allowedServices;
  @JsonKey(name: "isRating")
  bool? isRating;
  @JsonKey(name: "lastLogin")
  String? lastLogin;
  @JsonKey(name: "cif")
  String? cif;
  @JsonKey(name: "idno")
  String? idno;
  @JsonKey(name: "cardNumber")
  String? cardNumber;
  @JsonKey(name: "isKycExpire")
  bool? isKycExpire;
  @JsonKey(name: "isIdExpire")
  bool? isIdExpire;
  @JsonKey(name: "kycExpireTemp")
  bool? kycExpireTemp;
  @JsonKey(name: "idExpireTemp")
  bool? idExpireTemp;
  @JsonKey(name: "imtfStatus")
  dynamic imtfStatus;
  @JsonKey(name: "inboxStatus")
  bool? inboxStatus;
  @JsonKey(name: "isCoachMark")
  bool? isCoachMark;
  @JsonKey(name: "scheduleTime")
  dynamic scheduleTime;
  @JsonKey(name: "isCallschedule")
  bool? isCallschedule;

  CheckForgetPasswordContentEntity(
      {this.status,
      this.cardNumber,
      this.image,
      this.fullName,
      this.account,
      this.mobileNumber,
      this.accountNumber,
      this.accountStatus,
      this.allowedServices,
      this.allowMeToDiscoverable,
      this.benBlobImage,
      this.cif,
      this.closureDate,
      this.debitCardRequested,
      this.debitCardRequestStatus,
      this.dob,
      this.emailId,
      this.emailStatus,
      this.existing,
      this.firstName,
      this.gender,
      this.getDebitAuth,
      this.gIsSaudi,
      this.idExpireTemp,
      this.idIssuer,
      this.idno,
      this.imtfStatus,
      this.inboxStatus,
      this.isAccountBlackListed,
      this.isCallschedule,
      this.isCoachMark,
      this.isGetDebitAuth,
      this.isIdExpire,
      this.isKycExpire,
      this.isProccessAccount,
      this.isRating,
      this.isSaudi,
      this.tokenTimeOut,
      this.isTalent,
      this.isUserBlackListed,
      this.isZxAccount,
      this.isZxAccountDecativated,
      this.kycExpireTemp,
      this.languageCode,
      this.lastLogin,
      this.lastName,
      this.mobileStatus,
      this.mtAccount,
      this.mtId,
      this.nameOnCard,
      this.nationality,
      this.newDevice,
      this.previousSerial,
      this.scheduleTime,
      this.syncContacts,
      this.userId,
      this.userName,
      this.zxAccountNumber});

  factory CheckForgetPasswordContentEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CheckForgetPasswordContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckForgetPasswordContentEntityToJson(this);

  @override
  CheckForgetPasswordContentEntity restore(
      CheckForgetPasswordContent response) {
    return CheckForgetPasswordContentEntity();
  }

  @override
  CheckForgetPasswordContent transform() {
    return CheckForgetPasswordContent(
        cardNumber: this.cardNumber,
        image: this.image,
        status: this.status,
        account: this.account,
        accountNumber: this.accountNumber,
        accountStatus: this.accountStatus,
        allowedServices: this.allowedServices!.transform(),
        allowMeToDiscoverable: this.allowMeToDiscoverable,
        benBlobImage: this.benBlobImage,
        cif: this.cif,
        closureDate: this.closureDate,
        debitCardRequested: this.debitCardRequested,
        debitCardRequestStatus: this.debitCardRequestStatus,
        dob: this.dob,
        emailId: this.emailId,
        emailStatus: this.emailStatus,
        existing: this.existing,
        firstName: this.firstName,
        fullName: this.fullName,
        gender: this.gender,
        getDebitAuth: this.getDebitAuth,
        gIsSaudi: this.gIsSaudi,
        idExpireTemp: this.idExpireTemp,
        idIssuer: this.idIssuer,
        idno: this.idno,
        imtfStatus: this.imtfStatus,
        inboxStatus: this.inboxStatus,
        isAccountBlackListed: this.isAccountBlackListed,
        isCallschedule: this.isCallschedule,
        isCoachMark: this.isCoachMark,
        isGetDebitAuth: this.isGetDebitAuth,
        isIdExpire: this.isIdExpire,
        isKycExpire: this.isKycExpire,
        isProccessAccount: this.isProccessAccount,
        isRating: this.isRating,
        isSaudi: this.isSaudi,
        isTalent: this.isTalent,
        isUserBlackListed: this.isUserBlackListed,
        isZxAccount: this.isZxAccount,
        isZxAccountDecativated: this.isZxAccountDecativated,
        kycExpireTemp: this.kycExpireTemp,
        languageCode: this.languageCode,
        lastLogin: this.lastLogin,
        lastName: this.lastName,
        mobileNumber: this.mobileNumber,
        mobileStatus: this.mobileStatus,
        mtAccount: this.mtAccount,
        mtId: this.mtId,
        nameOnCard: this.nameOnCard,
        nationality: this.nationality,
        newDevice: this.newDevice,
        previousSerial: this.previousSerial,
        scheduleTime: this.scheduleTime,
        syncContacts: this.syncContacts,
        tokenTimeOut: this.tokenTimeOut,
        userId: this.userId,
        userName: this.userName,
        zxAccountNumber: this.zxAccountNumber);
  }
}
