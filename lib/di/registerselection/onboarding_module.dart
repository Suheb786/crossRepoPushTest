import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/onboarding/registerselection/register_selection_page_model.dart';

final registerSelectionViewModelProvider = ChangeNotifierProvider.autoDispose<RegisterSelectionViewModel>(
  (ref) => RegisterSelectionViewModel(),
);
