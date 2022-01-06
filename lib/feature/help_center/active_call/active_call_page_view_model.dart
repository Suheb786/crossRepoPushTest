import 'dart:async';

import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/help_center_extension.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:domain/usecase/infobip_audio/mute_unmute_usecase.dart';
import 'package:domain/usecase/infobip_audio/speaker_on_off_usecase.dart';
import 'package:domain/usecase/infobip_audio/hangup_call_usecase.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class ActiveCallPageViewModel extends BasePageViewModel {
  PublishSubject<String> _callDurationSubject = PublishSubject();

  Stream<String> get callDurationStream => _callDurationSubject.stream;

  PublishSubject<MuteUnMuteUseCaseParams> _muteUnMuteRequestSubject =
      PublishSubject();

  PublishSubject<SpeakerOnOffUseCaseParams> _speakerRequestSubject =
      PublishSubject();

  PublishSubject<HangupCallUseCaseParams> _hangupRequestSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _muteUnMuteResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _speakerResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _hangupResponseSubject = PublishSubject();

  Stream<Resource<bool>> get muteUnMuteResponseStream =>
      _muteUnMuteResponseSubject.stream;

  Stream<Resource<bool>> get hangupResponseStream =>
      _hangupResponseSubject.stream;

  Stream<Resource<bool>> get speakerResponseStream =>
      _speakerResponseSubject.stream;

  Stream newsStream = Stream.periodic(Duration(seconds: 1), (value) => value);
  late StreamSubscription _sub;
  final MuteUnMuteUseCase _muteUnMuteUseCase;
  final SpeakerOnOffUseCase _speakerOnOffUseCase;
  final HangupCallUseCase _hangupCallUseCase;

  ActiveCallPageViewModel(this._muteUnMuteUseCase, this._speakerOnOffUseCase,
      this._hangupCallUseCase) {
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
        _speakerResponseSubject.safeAdd(event);
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

    _sub = newsStream.listen((event) {
      print(event);
      _callDurationSubject
          .safeAdd(Duration(seconds: event).toHoursMinutesSeconds());
    });

    toggleMute();
    toggleSpeaker();
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

  @override
  void dispose() {
    _callDurationSubject.close();
    _muteUnMuteRequestSubject.close();
    _muteUnMuteResponseSubject.close();
    _speakerResponseSubject.close();
    _hangupRequestSubject.close();
    _speakerRequestSubject.close();
    _hangupResponseSubject.close();
    _sub.cancel();
    super.dispose();
  }
}
