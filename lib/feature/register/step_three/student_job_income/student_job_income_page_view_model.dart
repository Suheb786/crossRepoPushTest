import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:domain/usecase/register/student_job_income_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../utils/request_manager.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class StudentJobIncomePageViewModel extends BasePageViewModel {
  final StudentJobIncomeUseCase _studentIncomeUseCase;
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final GlobalKey<AppTextFieldState> studentIncomeKey =
      GlobalKey(debugLabel: "addStudentIncome");

  final TextEditingController studentIncomeController = TextEditingController();

  PublishSubject<StudentJobIncomeUseCaseParams> _studentIncomeRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _studentIncomeResponse = PublishSubject();

  Stream<Resource<bool>> get studentIncomeStream =>
      _studentIncomeResponse.stream;

  ///student income
  PublishSubject<UploadDocumentUseCaseParams> _uploadStudentRequest =
      PublishSubject();

  PublishSubject<String> _uploadStudentResponse = PublishSubject();

  Stream<String> get uploadStudentStream => _uploadStudentResponse.stream;

  ///is student document uploaded
  Stream<bool> get documentStudentStream => _documentStudentRequest.stream;

  PublishSubject<bool> _documentStudentRequest = PublishSubject();

  StudentJobIncomePageViewModel(this._studentIncomeUseCase, this._uploadDocumentUseCase) {
    _studentIncomeRequest.listen((value) {
      RequestManager(value,
              createCall: () => _studentIncomeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _studentIncomeResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _uploadStudentRequest.listen((value) {
      RequestManager(value,
          createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadStudentResponse.safeAdd(event.data!);
      });
    });
  }

  void uploadStudentDocument(DocumentTypeEnum type) {
    _uploadStudentRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updateStudentDocumentField(String value) {
    studentIncomeController.text = value.split("/").last;
    updateStudentUploadedStream(true);
  }

  void updateStudentUploadedStream(bool value) {
    _documentStudentRequest.safeAdd(value);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
