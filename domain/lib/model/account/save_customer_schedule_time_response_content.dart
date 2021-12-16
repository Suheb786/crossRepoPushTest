class SaveCustomerScheduleTimeResponseContent {
  SaveCustomerScheduleTimeResponseContent({
    this.id,
    this.customerId,
    this.referenceNo,
    this.scheduleDate,
    this.scheduleTime,
    this.createdOn,
    this.isActive,
  });

  int? id;
  String? customerId;
  String? referenceNo;
  String? scheduleDate;
  String? scheduleTime;
  DateTime? createdOn;
  bool? isActive;
}
