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

  void checkBoxToggle(bool value) {
    isChecked.safeAdd(value);
    buttonVisibilty(value);
  }

  void buttonVisibilty(bool value) {
    if (isChecked.value == value) {
      isButtonVisible.safeAdd(value);
    }
  }

  IdWiseIntialPageViewModel(this._updateJourneyUseCase) {
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
  }

  void udpateJourney(
      {required String? userID,
      required String? refID,
      required String? journeyID,
      required String? status}) {
    _updateJourneyRequest.safeAdd(
        UpdateJourneyUseCaseParams(userID: userID, refID: refID, journeyID: journeyID, status: status));
  }
}
