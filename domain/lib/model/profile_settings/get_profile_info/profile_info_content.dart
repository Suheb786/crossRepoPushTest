class ProfileInfoContent {
  ProfileInfoContent(
      {this.email: "",
      this.mobileNumber: "",
      this.biometric,
      this.profileImage,
      this.fullName});

  String? email;
  String? mobileNumber;
  String? fullName;
  bool? biometric;
  dynamic profileImage;
}
