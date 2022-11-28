import 'package:domain/constants/enum/reason_unavailability_enum.dart';

class ReasonOfUnavailability {
  final String? type;
  final String? reasonDescription;
  final ReasonUnavailabilityEnum? reasonUnavailabilityEnum;

  ReasonOfUnavailability({this.type, this.reasonDescription, this.reasonUnavailabilityEnum});
}
