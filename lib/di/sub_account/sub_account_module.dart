import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/sub_account/open_sub_account/open_sub_account_success/open_sub_account_success_page_view_model.dart';
import '../../feature/sub_account/transfer/select_transfer/select_transfer_page.dart';
import '../../feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import '../../feature/sub_account/transfer/transfer_success/transfer_success_page.dart';
import '../../feature/sub_account/transfer/transfer_success/transfer_success_page_view_model.dart';

///------------[Open-sub-Account-Success-Page-View-Model-Provider]-------------------///
final openSubAccountSuccessPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<OpenSubAccountSuccessPageViewModel>(
  (ref) => OpenSubAccountSuccessPageViewModel(),
);

///------------[Select-Transfer-Page-View-Model-Provider]-------------------///
final selectTransferPageViewModelProivder =
    ChangeNotifierProvider.autoDispose.family<SelectTransferPageViewModel, SelectTranferPageArgument>(
  (ref, arg) => SelectTransferPageViewModel(argument: arg),
);

///------------[Transfer-Success-Page-View-Model-Provider]-------------------///
final transferSuccessPageViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<TransferSuccessPageViewModel, TransferSuccessPageArgument>(
  (ref, arg) => TransferSuccessPageViewModel(arg),
);
