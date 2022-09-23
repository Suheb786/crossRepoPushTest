import 'dart:async';

import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/usecase/infobip_audio/hangup_call_usecase.dart';
import 'package:domain/usecase/infobip_audio/init_infobip_audio_usecase.dart';
import 'package:domain/usecase/infobip_audio/mute_unmute_usecase.dart';
import 'package:domain/usecase/infobip_audio/speaker_on_off_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/help_center_extension.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class ActiveCallPageViewModel extends BasePageViewModel {
  PublishSubject<String> _callDurationSubject = PublishSubject();

  Stream<String> get callDurationStream => _callDurationSubject.stream;

  PublishSubject<MuteUnMuteUseCaseParams> _muteUnMuteRequestSubject = PublishSubject();

  PublishSubject<SpeakerOnOffUseCaseParams> _speakerRequestSubject = PublishSubject();

  PublishSubject<HangupCallUseCaseParams> _hangupRequestSubject = PublishSubject();

  PublishSubject<InfobipAudioPluginUseCaseParams> _initInfobipRequestSubject = PublishSubject();

  PublishSubject<InfobipCallStatusEnum> _callStatusSubject = PublishSubject();

  PublishSubject<Resource<bool>> _muteUnMuteResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _speakerResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _hangupResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _initInfobipResponseSubject = PublishSubject();

  Stream<Resource<bool>> get muteUnMuteResponseStream => _muteUnMuteResponseSubject.stream;

  Stream<Resource<bool>> get hangupResponseStream => _hangupResponseSubject.stream;

  Stream<Resource<bool>> get speakerResponseStream => _speakerResponseSubject.stream;

  Stream<InfobipCallStatusEnum> get callStatusStream => _callStatusSubject.stream;

  Stream callDurationCounterStream = Stream.periodic(Duration(seconds: 1), (value) => value);

  late StreamSubscription _callDurationCounterSubscription;
  final MuteUnMuteUseCase _muteUnMuteUseCase;
  final SpeakerOnOffUseCase _speakerOnOffUseCase;
  final HangupCallUseCase _hangupCallUseCase;
  final InfobipAudioPluginUseCase _infobipAudioPluginUseCase;

  ActiveCallPageViewModel(this._muteUnMuteUseCase, this._speakerOnOffUseCase, this._hangupCallUseCase,
      this._infobipAudioPluginUseCase) {
    _muteUnMuteRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _muteUnMuteUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _muteUnMuteResponseSubject.safeAdd(event);
      });
    });

    _speakerRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _speakerOnOffUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        if (event.data != null) {
          print("SPEAKER EVENT ::::: ${event.data}");
          _speakerResponseSubject.safeAdd(event);
        }
      });
    });

    _hangupRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _hangupCallUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _hangupResponseSubject.safeAdd(event);
      });
    });

    _initInfobipRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _infobipAudioPluginUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _initInfobipResponseSubject.safeAdd(event);
      });
    });

    _callDurationCounterSubscription = callDurationCounterStream.listen((event) {
      _callDurationSubject.safeAdd(Duration(seconds: event).toHoursMinutesSeconds());
    });
    getCurrentCallStatus();
  }

  toggleMute() {
    _muteUnMuteRequestSubject.safeAdd(MuteUnMuteUseCaseParams());
  }

  toggleSpeaker() {
    _speakerRequestSubject.safeAdd(SpeakerOnOffUseCaseParams());
  }

  hangup() {
    _hangupRequestSubject.safeAdd(HangupCallUseCaseParams());
  }

  getCurrentCallStatus() {
    _initInfobipRequestSubject
        .safeAdd(InfobipAudioPluginUseCaseParams(callback: (InfobipCallStatusEnum status) {
      _callStatusSubject.safeAdd(status);
    }));
  }

  @override
  void dispose() {
    _callDurationSubject.close();
    _muteUnMuteRequestSubject.close();
    _muteUnMuteResponseSubject.close();
    _speakerResponseSubject.close();
    _hangupRequestSubject.close();
    _speakerRequestSubject.close();
    _hangupResponseSubject.close();
    _callStatusSubject.close();

    _callDurationCounterSubscription.cancel();
    super.dispose();
  }
}
