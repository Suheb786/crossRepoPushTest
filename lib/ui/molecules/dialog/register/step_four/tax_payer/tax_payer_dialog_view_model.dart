import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:rxdart/rxdart.dart';

class TaxPayerDialogViewModel extends BasePageViewModel {
  List<String> taxPayerListW9 = ['Social Security', 'Employer'];
  List<String> taxPayerListW8 = ['U.S.', 'Foreign'];

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  List<String> getList(TaxPayerTypeEnum typeEnum) {
    switch (typeEnum) {
      case TaxPayerTypeEnum.W8:
        return taxPayerListW8;
      case TaxPayerTypeEnum.W9:
        return taxPayerListW9;
      default:
        return taxPayerListW8;
    }
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
