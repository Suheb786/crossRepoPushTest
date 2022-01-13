import 'package:domain/constants/enum/customer_status_enum.dart';

class CustomerStatus {
  final CustomerStatusEnum? nextPage;
  final CustomerStatusEnum? secondNextPage;

  CustomerStatus({this.nextPage, this.secondNextPage});
}
