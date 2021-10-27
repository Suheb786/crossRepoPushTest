import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_view.dart';

class IdVerificationInfoPage extends BasePage<IdVerificationInfoViewModel> {
  @override
  IdVerificationInfoPageState createState() => IdVerificationInfoPageState();
}

class IdVerificationInfoPageState extends BaseStatefulPage<
    IdVerificationInfoViewModel,
    IdVerificationInfoPage> with TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return idVerificationInfoViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, IdVerificationInfoViewModel model) {
    return IdVerificationInfoView(provideBase());
  }
}
