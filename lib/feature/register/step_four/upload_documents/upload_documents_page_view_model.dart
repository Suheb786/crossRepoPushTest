import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/user/upload_documents_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class UploadDocumentsPageViewModel extends BasePageViewModel {
  final UploadDocumentsUseCase _documentsUseCase;

  UploadDocumentsPageViewModel(this._documentsUseCase) {
    _documentsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _documentsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _documentsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  PublishSubject<UploadDocumentsUseCaseParams> _documentsRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _documentsResponse = PublishSubject();

  Stream<Resource<bool>> get documentsStream => _documentsResponse.stream;

  void validateTextFields() {
    // _documentsRequest.safeAdd(UploadDocumentsUseCaseParams(
    //   incomeProof: "incomeProof",
    //   addressProof: "addressProof",
    // ));
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 500), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }
}
