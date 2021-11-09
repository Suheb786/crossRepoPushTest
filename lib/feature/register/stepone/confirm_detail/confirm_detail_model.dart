import 'package:domain/usecase/user/confirm_detail_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmDetailViewModel extends BasePageViewModel {
  final ConfirmDetailUseCase _confirmDetailUseCase;
  TextEditingController nameController = new TextEditingController();
  TextEditingController idNumberController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController nationalityController = new TextEditingController();
  TextEditingController expiryDateController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController motherNameController = new TextEditingController();

  final GlobalKey<AppTextFieldState> nameKey = GlobalKey(debugLabel: "name");

  final GlobalKey<AppTextFieldState> idNumberKey =
      GlobalKey(debugLabel: "idNumber");

  final GlobalKey<AppTextFieldState> dobKey = GlobalKey(debugLabel: "dob");

  final GlobalKey<AppTextFieldState> nationalityKey =
      GlobalKey(debugLabel: "nationality");

  final GlobalKey<AppTextFieldState> expiryDateKey =
      GlobalKey(debugLabel: "expiryDate");

  final GlobalKey<AppTextFieldState> genderKey =
      GlobalKey(debugLabel: "gender");

  final GlobalKey<AppTextFieldState> motherNameKey =
      GlobalKey(debugLabel: "mother's name");

  DateTime selectedDate = DateTime.now();

  DateTime selectedExpiryDate = DateTime.now();

  /// confirm detail request subject holder
  PublishSubject<ConfirmDetailUseCaseParams> _confirmDetailRequest =
      PublishSubject();

  /// confirm detail response subject holder
  // ignore: close_sinks
  PublishSubject<Resource<bool>> _confirmDetailResponse = PublishSubject();

  Stream<Resource<bool>> get confirmDetailResponseStream =>
      _confirmDetailResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ConfirmDetailViewModel(this._confirmDetailUseCase) {
    _confirmDetailRequest.listen((value) {
      RequestManager(value,
              createCall: () => _confirmDetailUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _confirmDetailResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void confirmDetail() {
    _confirmDetailRequest.safeAdd(ConfirmDetailUseCaseParams(
        name: nameController.text,
        idNumber: idNumberController.text,
        dateOfBirth: dobController.text,
        nationality: nationalityController.text,
        expiryDate: expiryDateController.text,
        gender: genderController.text,
        motherName: motherNameController.text));
  }

  void validateDetails() {
    if (nameController.text.isNotEmpty &&
        idNumberController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        nationalityController.text.isNotEmpty &&
        expiryDateController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        motherNameController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _confirmDetailRequest.close();
    _showButtonSubject.close();
    _confirmDetailResponse.close();
    super.dispose();
  }
}
