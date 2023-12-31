import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/sub_account/open_sub_account/open_sub_account_success/open_sub_account_success_page.dart';
import '../../feature/sub_account/open_sub_account/open_sub_account_success/open_sub_account_success_page_view_model.dart';
import '../../feature/sub_account/transfer/select_transfer/select_transfer_page.dart';
import '../../feature/sub_account/transfer/select_transfer/select_transfer_page_view_model.dart';
import '../../feature/sub_account/transfer/transfer_success/transfer_success_page.dart';
import '../../feature/sub_account/transfer/transfer_success/transfer_success_page_view_model.dart';
import '../usecase/sub_account/sub_account_usecase_provider.dart';

///------------[Open-sub-Account-Success-Page-View-Model-Provider]-------------------///
final openSubAccountSuccessPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<OpenSubAccountSuccessPageViewModel, OpenSubAccountSuccessPageArgument>(
  (ref, arg) => OpenSubAccountSuccessPageViewModel(arg),
);

///------------[Select-Transfer-Page-View-Model-Provider]-------------------///
final selectTransferPageViewModelProivder =
    ChangeNotifierProvider.autoDispose.family<SelectTransferPageViewModel, SelectTranferPageArgument>(
  (ref, arg) => SelectTransferPageViewModel(
    argument: arg,
    accountToAccountTransferUseCase: ref.read(accountToAccountTransferUsecaseProvider),
  ),
);

///------------[Transfer-Success-Page-View-Model-Provider]-------------------///
final transferSuccessPageViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<TransferSuccessPageViewModel, TransferSuccessPageArgument>(
  (ref, arg) => TransferSuccessPageViewModel(
    argument: arg,
  ),
);
