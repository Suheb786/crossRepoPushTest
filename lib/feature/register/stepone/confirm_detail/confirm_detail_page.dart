import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_view.dart';

class ConfirmDetailPage extends BasePage<ConfirmDetailViewModel> {
  @override
  ConfirmDetailPageState createState() => ConfirmDetailPageState();
}

class ConfirmDetailPageState
    extends BaseStatefulPage<ConfirmDetailViewModel, ConfirmDetailPage>
    with AutomaticKeepAliveClientMixin {
  ConfirmDetailPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return confirmDetailViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  // @override
  // void onVisibilityGained() {
  //   getViewModel().scannedDocumentResult = ProviderScope.containerOf(context)
  //       .read(idVerificationInfoViewModelProvider)
  //       .scannedDocumentResult;
  //
  //   getViewModel().setData();
  //
  //   ///TODO: call ahwal API
  //   super.onVisibilityGained();
  // }
  //

  @override
  void onFocusGained() {
    getViewModel().scannedDocumentResult = ProviderScope.containerOf(context)
        .read(idVerificationInfoViewModelProvider)
        .scannedDocumentResult;

    //getViewModel().setData();

    ///TODO: call ahwal API
    super.onFocusGained();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, ConfirmDetailViewModel model) {
    return ConfirmDetailView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
