class CheckExistingCallStatus {
  final bool isExist;
  final bool isExpire;
  final String scheduledDate;
  final String scheduledTime;

  CheckExistingCallStatus(
      {this.isExist: false,
      this.isExpire: false,
      this.scheduledDate: "",
      this.scheduledTime: ""});
}
