import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui/molecules/dialog/sub_accounts_dialogs/select_from_list_dialog/select_from_list_dialog_view_model.dart';

final selectFromListDialogPageViewModel =
    ChangeNotifierProvider.autoDispose<SelectFromListDialogPageViewModel>(
  (ref) => SelectFromListDialogPageViewModel(),
);
