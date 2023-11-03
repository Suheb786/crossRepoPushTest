
import 'package:domain/model/user/update_journey/update_journey.dart';
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
  String journeyId = '';
  String referenceNumber = '';

  ScrollController scrollController = ScrollController();

  ///checkBox Subject
  BehaviorSubject<bool> isChecked = BehaviorSubject();
  Stream<bool> get checkBoxStream => isChecked.stream;

  ///update journey request subject holder
  PublishSubject<UpdateJourneyUseCaseParams> _updateJourneyRequest = PublishSubject();

  ///update journey response subject holder
  PublishSubject<Resource<UpdateJourney>> _updateJourneyResponse = PublishSubject();

  Stream<Resource<UpdateJourney>> get updateJourneyStream => _updateJourneyResponse.stream;

  final PublishSubject<GetCurrentUserUseCaseParams> _currentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _currentUserResponseSubject = PublishSubject();

  void checkBoxToggle(bool value) {
    isChecked.safeAdd(value);
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
    var status = await idWiseHelper.startVerification(Localizations.localeOf(appLevelKey.currentState!.context).languageCode, data.idWiseRefId ?? '');

    debugPrint("STATUS : ${status.keys.first}");
    debugPrint("TEXT :  ${status.values.first}");

    if (status.keys.first == IDWiseStatus.COMPLETED) {
      referenceNumber = data.idWiseRefId!;
      journeyId = status.values.first;
      udpateJourney(userID: data.id, refID: data.idWiseRefId, journeyID: status.values.first, status: "");
    } else if (status.keys.first == IDWiseStatus.ERROR) {

    }*/
    referenceNumber = data.idWiseRefId ?? '';
    journeyId = "65423170f0ae36ab6f7ef75a";
    udpateJourney(userID: data.id, refID: data.idWiseRefId, journeyID: journeyId, status: "");
  }
}
