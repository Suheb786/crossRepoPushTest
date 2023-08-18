import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/sub_account/transfer/select_transfer/select_transfer_page.dart';
import '../../feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import '../../feature/sub_account/transfer/transfer_success/transfer_success_page_view_model.dart';

///------------[Select-Transfer-Page-View-Model]-------------------///
final selectTransferPageViewModel =
    ChangeNotifierProvider.autoDispose.family<SelectTransferPageViewModel, SelectTranferPageArgument>(
  (ref, arg) => SelectTransferPageViewModel(argument: arg),
);

///------------[Transfer-Success-Page-View-Model]-------------------///
final transferSuccessPageViewModel = ChangeNotifierProvider.autoDispose<TransferSuccessPageViewModel>(
  (ref) => TransferSuccessPageViewModel(),
);
