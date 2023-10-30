import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/user/get_current_user_usecase.dart';
import 'package:domain/usecase/user/update_journey_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/subjects.dart';

import '../../../utils/request_manager.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';

class IdWiseIntialPageViewModel extends BasePageViewModel {
  final UpdateJourneyUseCase _updateJourneyUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  ScrollController scrollController = ScrollController();

  ///checkBox Subject
  BehaviorSubject<bool> isChecked = BehaviorSubject();

  Stream<bool> get checkBoxStream => isChecked.stream;

  //button Subject
  BehaviorSubject<bool> isButtonVisible = BehaviorSubject();

  Stream<bool> get buttonStream => isButtonVisible.stream;

  ///update journey request subject holder
  PublishSubject<UpdateJourneyUseCaseParams> _updateJourneyRequest = PublishSubject();

  ///update journey response subject holder
  PublishSubject<Resource<bool>> _updateJourneyResponse = PublishSubject();

  Stream<Resource<bool>> get updateJourneyStream => _updateJourneyResponse.stream;

  final PublishSubject<GetCurrentUserUseCaseParams> _currentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _currentUserResponseSubject = PublishSubject();

  void checkBoxToggle(bool value) {
    isChecked.safeAdd(value);
    buttonVisibilty(value);
  }

  void buttonVisibilty(bool value) {
    if (isChecked.value == value) {
      isButtonVisible.safeAdd(value);
    }
  }

  IdWiseIntialPageViewModel(this._updateJourneyUseCase, this._getCurrentUserUseCase) {
    _updateJourneyRequest.listen((value) {
      RequestManager(value, createCall: () => _updateJourneyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateJourneyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _currentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _getCurrentUserUseCase.execute(params: value))
          .asFlow()
          .listen((event) async {
        if (event.status == Status.SUCCESS) {
          openIdwise(event.data!);
        }
      });
    });
  }

  void getCurrentUser() {
    _currentUserRequestSubject.add(GetCurrentUserUseCaseParams());
  }

  void udpateJourney(
      {required String? userID,
      required String? refID,
      required String? journeyID,
      required String? status}) {
    _updateJourneyRequest.safeAdd(
        UpdateJourneyUseCaseParams(userID: userID, refID: refID, journeyID: journeyID, status: status));
  }

  Future<void> openIdwise(User data) async {
    /*IdWiseHelper idWiseHelper = IdWiseHelper();
    idWiseHelper.initializeIdWise();
    var status = await idWiseHelper.startVerification('en', '123456789');
    debugPrint("STATUS : ${status.keys.first}");
    debugPrint("TEXT :  ${status.values.first}");

    if (status.keys.first == IDWiseStatus.COMPLETED) {
      udpateJourney(userID: data.id, refID: data.id, journeyID: status.values.first, status: "");
    }*/

    udpateJourney(userID: data.id, refID: data.id, journeyID: "example", status: "");
  }
}
