import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/debit_card_settings/debit_card_settings_usecase_provider.dart';
import 'package:neo_bank/feature/debit_card_settings/debit_card_settings_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/cancellation_reason_dialog/cancellation_reason_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/card_cancel_dialog/card_cancel_dialog_view_model.dart';

final debitCardSettingsViewModelProvider =
    ChangeNotifierProvider.autoDispose<DebitCardSettingsPageViewModel>((ref) =>
        DebitCardSettingsPageViewModel(
            ref.read(freezeDebitCardUseCaseProvider),
            ref.read(unFreezeDebitCardUseCaseProvider),
            ref.read(cancelDebitCardUseCaseProvider)));

final cancelCardDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CardCancelDialogViewModel>(
        (ref) => CardCancelDialogViewModel());

final cancelReasonCardDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CancellationReasonDialogModel>(
        (ref) => CancellationReasonDialogModel());
