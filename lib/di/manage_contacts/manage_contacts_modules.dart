import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';

final manageContactsListViewModelProvider =
ChangeNotifierProvider.autoDispose<ManageContactListPageViewModel>(
      (ref) => ManageContactListPageViewModel(),
);

///manage contact details
final manageContactDetailsViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<ManageContactDetailsPageViewModel, ContactsListModel>(
      (ref, args) =>
      ManageContactDetailsPageViewModel(
          ref.read(uploadDocumentUseCaseProvider), args),
);
