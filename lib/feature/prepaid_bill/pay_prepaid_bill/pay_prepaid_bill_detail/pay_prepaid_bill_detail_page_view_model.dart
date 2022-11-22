import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class PayPrePaidBillDetailPageViewModel extends BasePageViewModel {
  PayPrePaidBillDetailPageViewModel() {}
  final ScrollController controller = ScrollController();
  final TextEditingController billNameController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController refNoController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController payFromController = TextEditingController()..text = 'Savings Account';

  PublishSubject<bool> _switchStatusSubject = PublishSubject();

  Stream<bool> get totalBillAmtDueStream => _switchStatusSubject.stream;

  void switchStatus(bool isActive) {
    _switchStatusSubject.safeAdd(isActive);
  }

  @override
  void dispose() {
    _switchStatusSubject.close();
    super.dispose();
  }
}
