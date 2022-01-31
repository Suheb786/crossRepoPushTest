import 'package:domain/constants/enum/customer_status_enum.dart';

class CustomerStatus {
  final CustomerStatusEnum? nextPage;
  final CustomerStatusEnum? secondNextPage;
  final String? applicationId;

  CustomerStatus({this.applicationId, this.nextPage, this.secondNextPage});
}
