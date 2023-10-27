class ProfileInfoContent {
  ProfileInfoContent(
      {this.email = "",
      this.mobileNumber = "",
      this.biometric,
      this.profileImage,
      this.fullName,
      this.mobileCode,
      this.localProfileImageDB});

  String? email;
  String? mobileNumber;
  String? fullName;
  bool? biometric;
  dynamic profileImage;
  dynamic localProfileImageDB;
  String? mobileCode;
}
