import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class HelpCenterPageViewModel extends BasePageViewModel {
  PublishSubject<bool> _callEstablishSubject = PublishSubject();
  Stream<bool> get callEstablishStream => _callEstablishSubject.stream;

  void onCallEstablish() {
    _callEstablishSubject.safeAdd(true);
  }

  @override
  void dispose() {
    _callEstablishSubject.close();

    super.dispose();
  }
}
