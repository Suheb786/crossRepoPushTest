import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_page_view.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_view_model.dart';

class SendToNewRecipientPage extends BasePage<SendToNewRecipientViewModel> {
  @override
  SendToNewRecipientPageState createState() => SendToNewRecipientPageState();
}

class SendToNewRecipientPageState
    extends BaseStatefulPage<SendToNewRecipientViewModel, SendToNewRecipientPage> {
  @override
  ProviderBase provideBase() {
    return sendToNewRecipientViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, SendToNewRecipientViewModel model) {
    return SendToNewRecipientPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
