import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/ui/molecules/dialog/sub_accounts_dialogs/select_account_list_dialog/select_account_list_dialog_view_model.dart';

final selectFromListDialogPageViewModel =
    ChangeNotifierProvider.autoDispose<SelectAccountListDialogPageViewModel>(
  (ref) => SelectAccountListDialogPageViewModel(),
);
