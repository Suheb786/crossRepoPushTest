class ProfileStatusInfo {
  final int? id;
  final String? userId;
  final bool? married;
  final bool? specialPerson;
  final String? employmentStatus;
  final String? employmentStatusAr;
  final String? spauseName;
  final String? natureSp;
  final DateTime? createdOn;
  final bool? isActive;

  ProfileStatusInfo(
      {this.id,
      this.userId,
      this.married,
      this.specialPerson,
      this.employmentStatus,
      this.spauseName,
      this.natureSp,
      this.createdOn,
      this.isActive,
      this.employmentStatusAr});
}
