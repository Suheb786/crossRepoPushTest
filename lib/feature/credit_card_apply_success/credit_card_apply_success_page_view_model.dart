import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';

class CreditCardApplySuccessPageViewModel extends BasePageViewModel {
  final CreditCardApplySuccessArguments creditCardApplySuccessArguments;

  CreditCardApplySuccessPageViewModel(this.creditCardApplySuccessArguments);

  String getTitle(BuildContext context, CreditSuccessState creditSuccessState) {
    switch (creditSuccessState) {
      case CreditSuccessState.Applied_Success:
        return S.of(context).yourCardIsReady;
      case CreditSuccessState.Submitted:
        return S.of(context).applicationSubmitted;
      case CreditSuccessState.Settlement_Account_Changed:
        return S.of(context).cardDetailsUpdated;
      case CreditSuccessState.Settlement_Percentage_Changed:
        return S.of(context).cardDetailsUpdated;
      case CreditSuccessState.Credit_Limit_Changed:
        return S.of(context).creditLimitChangedSuccess;
      case CreditSuccessState.Convert_Purchase_To_Installments:
        return S.of(context).purchaseInstallmentsSuccessfullySet;
      default:
        return "";
    }
  }

  String description(BuildContext context, CreditSuccessState creditSuccessState) {
    switch (creditSuccessState) {
      case CreditSuccessState.Applied_Success:
        return S.of(context).cardApplyMsg;
      case CreditSuccessState.Submitted:
        return S.of(context).applicationSubmittedDesc;
      case CreditSuccessState.Settlement_Account_Changed:
        return S.of(context).cardDetailsUpdatedDesc;
      case CreditSuccessState.Settlement_Percentage_Changed:
        return S.of(context).creditSettlementPercentageChangedDesc;
      case CreditSuccessState.Credit_Limit_Changed:
        return S.of(context).creditLimitChangedDesc;
      case CreditSuccessState.Convert_Purchase_To_Installments:
        return S.of(context).purchaseInstallmentsSuccessfullySetDesc;
      default:
        return "";
    }
  }
}
