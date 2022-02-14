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
      this.newDevice: false,
      this.isBiometricEnabled: false,
      this.applicationId: ""});

  String get profileName => "${firstName?[0] ?? ""} ${lastName?[0] ?? ""}";
}
