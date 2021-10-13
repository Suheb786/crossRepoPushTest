import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/rxdart.dart';

class ReviewApplicationPageViewModel extends BasePageViewModel {
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.add(value);
  }
}
