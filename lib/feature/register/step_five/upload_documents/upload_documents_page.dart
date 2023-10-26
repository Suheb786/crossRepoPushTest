import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page_view.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page_view_model.dart';

class UploadDocumentsPage extends BasePage<UploadDocumentsPageViewModel> {
  @override
  UploadDocumentsPageState createState() => UploadDocumentsPageState();
}

class UploadDocumentsPageState extends BaseStatefulPage<UploadDocumentsPageViewModel, UploadDocumentsPage> {
  @override
  ProviderBase provideBase() {
    return uploadDocumentsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, UploadDocumentsPageViewModel model) {
    return UploadDocumentsPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(UploadDocumentsPageViewModel model, {param}) async {
    return false;
  }
}
