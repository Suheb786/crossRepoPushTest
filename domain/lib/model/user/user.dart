class User {
  String? token;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  bool? isCurrent;
  String? refreshToken;
  String? tokenType;
  int? expiredIn;

  User(
      {this.token,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.isCurrent,
      this.refreshToken,
      this.tokenType,
      this.expiredIn});
}
