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
  String? privatePEM;
  String? publicPEM;
  bool? isBiometricEnabled;

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
      this.isBiometricEnabled: false});
}
