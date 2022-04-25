import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/block_country/block_country_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/cancellation_reason_dialog/cancellation_reason_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/card_cancel_dialog/card_cancel_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/report_stolen_debit_card/report_stolen_debit_card_dialog_view_model.dart';

final cancelCardDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CardCancelDialogViewModel>(
        (ref) => CardCancelDialogViewModel());

final cancelReasonCardDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<CancellationReasonDialogModel>(
        (ref) => CancellationReasonDialogModel());

final blockCountryDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<BlockCountryDialogModel>(
        (ref) => BlockCountryDialogModel());

final reportStolenDebitCardDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<ReportStolenDebitCardDialogViewModel>(
        (ref) => ReportStolenDebitCardDialogViewModel());
