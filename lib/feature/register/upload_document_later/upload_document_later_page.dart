import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/upload_document_later/upload_document_later_page_view.dart';
import 'package:neo_bank/feature/register/upload_document_later/upload_document_later_page_view_model.dart';

class UploadDocumentsLaterPage extends BasePage<UploadDocumentsLaterViewModel> {
  @override
  UploadDocumentsLaterPageState createState() => UploadDocumentsLaterPageState();
}

class UploadDocumentsLaterPageState
    extends BaseStatefulPage<UploadDocumentsLaterViewModel, UploadDocumentsLaterPage> {
  @override
  ProviderBase provideBase() {
    return uploadDocumentsLaterPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, UploadDocumentsLaterViewModel model) {
    return UploadDocumentsLaterPageView(provideBase());
  }
}
