import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui/molecules/dialog/card_settings/select_from_list_dialog/select_from_list_dialog_page_view_model.dart';

final selectFromListDialogPageViewModel =
    ChangeNotifierProvider.autoDispose<SelectFromListDialogPageViewModel>(
  (ref) => SelectFromListDialogPageViewModel(),
);
