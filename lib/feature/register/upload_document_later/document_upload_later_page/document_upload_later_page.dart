import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/upload_document_later/document_upload_later_page/document_upload_later_page_view.dart';
import 'package:neo_bank/feature/register/upload_document_later/document_upload_later_page/document_upload_later_page_view_model.dart';

class DocumentUploadLaterPage extends BasePage<DocumentUploadLaterPageViewModel> {
  @override
  DocumentUploadLaterPageState createState() => DocumentUploadLaterPageState();
}

class DocumentUploadLaterPageState
    extends BaseStatefulPage<DocumentUploadLaterPageViewModel, DocumentUploadLaterPage> {
  @override
  ProviderBase provideBase() {
    return laterDocumentUploadViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, DocumentUploadLaterPageViewModel model) {
    return DocumentUploadLaterPageView(provideBase());
  }
}
