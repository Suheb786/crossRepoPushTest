import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/terms_and_condition/terms_and_condition_page_view_model.dart';

final termsAndConditionViewModelProvider =
    ChangeNotifierProvider.autoDispose<TermsAndConditionPageViewModel>(
  (ref) => TermsAndConditionPageViewModel(),
);
