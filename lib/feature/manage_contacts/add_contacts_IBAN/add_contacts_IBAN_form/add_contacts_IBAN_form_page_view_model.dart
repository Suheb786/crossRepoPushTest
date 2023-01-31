import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/subjects.dart';

class AddContactsIBANformPageViewModel extends BasePageViewModel {
  PublishSubject<bool> showbuttom = PublishSubject();
  Stream<bool> get showStreamButom => showbuttom.stream;
}
