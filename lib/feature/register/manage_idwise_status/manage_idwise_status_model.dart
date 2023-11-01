import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/base_page_view_model.dart';

class ManageIDWiseStatusViewModel extends BasePageViewModel {
  final BehaviorSubject<bool> verifyNationalID = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> verifySelfie = BehaviorSubject.seeded(false);

  Stream<bool> get verifyNationalIDStream => verifyNationalID.stream;

  Stream<bool> get verifySelfieStream => verifySelfie.stream;

  ManageIDWiseStatusViewModel() {
    nationalIDVerification();
  }

  void nationalIDVerification() {
    Future.delayed(Duration(milliseconds: 1200), () {
      verifyNationalID.safeAdd(true);
      selfieVerification();
    });
  }

  void selfieVerification() {
    Future.delayed(Duration(milliseconds: 1000), () {
      verifySelfie.safeAdd(true);
    });
  }
}
