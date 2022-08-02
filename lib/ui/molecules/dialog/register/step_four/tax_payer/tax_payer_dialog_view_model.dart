import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class TaxPayerDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  List<String> taxPayerListW9 = ['Social Security', 'Employer'];
  List<String> taxPayerListW8 = ['U.S.', 'Foreign'];
  List<String> taxPayerListW9Ar = ['ان اجتماعي', 'لجهة الوظيفية'];
  List<String> taxPayerListW8Ar = ['U.S.', 'اجنبي'];

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
        return Intl.systemLocale == 'en' ? taxPayerListW8 : taxPayerListW8Ar;
      case TaxPayerTypeEnum.W9:
        return Intl.systemLocale == 'en' ? taxPayerListW9 : taxPayerListW9Ar;
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
