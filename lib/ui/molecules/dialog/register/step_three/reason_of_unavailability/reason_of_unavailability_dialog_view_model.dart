import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/model/register/reason_of_unavailability.dart';
import 'package:domain/constants/enum/reason_unavailability_enum.dart';
import 'package:rxdart/rxdart.dart';

class ReasonOfUnavailabilityDialogViewModel extends BasePageViewModel {
  ///reason list
  List<ReasonOfUnavailability> reasonOfUnavailabilityList = [
    ReasonOfUnavailability(
        type: 'Reason A',
        reasonDescription:
            'The Country where the Account Holder is resident does not issue TINs to its residents.',
        reasonUnavailabilityEnum: ReasonUnavailabilityEnum.REASON_A),
    ReasonOfUnavailability(
        type: 'Reason B',
        reasonDescription:
            'The Account Holder is otherwise unable to obtain a TIN.',
        reasonUnavailabilityEnum: ReasonUnavailabilityEnum.REASON_B),
    ReasonOfUnavailability(
        type: 'Reason C',
        reasonDescription:
            'TIN is not required as per the regulation of the Country you are considered a Resident for Taxation.',
        reasonUnavailabilityEnum: ReasonUnavailabilityEnum.REASON_C),
  ];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
