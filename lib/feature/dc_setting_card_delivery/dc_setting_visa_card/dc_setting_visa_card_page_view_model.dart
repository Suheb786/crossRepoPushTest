import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DcSettingVisaCardPageViewModel extends BasePageViewModel {
  final FlipCardController cardController = FlipCardController();
  final CardIssuanceUseCase _cardIssuanceUseCase;

  PublishSubject<CardIssuanceUseCaseParams> _cardIssuanceRequest = PublishSubject();

  BehaviorSubject<Resource<CardIssuanceDetails>> _cardIssuanceResponse = BehaviorSubject();

  String? cardNumber;

  Stream<Resource<CardIssuanceDetails>> get cardIssuanceStream => _cardIssuanceResponse.stream;

  /// card delivery pop up request
  PublishSubject<bool> _cardDeliveryPopUpResponse = PublishSubject();

  /// card delivery pop up response
  PublishSubject<bool> _cardDeliveryRequest = PublishSubject();

  /// card delivery pop up stream
  Stream<bool> get cardDeliveryPopUpDataStream => _cardDeliveryPopUpResponse.stream;

  void triggerPopup() {
    _cardDeliveryRequest.safeAdd(true);
  }

  DcSettingVisaCardPageViewModel(this._cardIssuanceUseCase) {
    _cardIssuanceRequest.listen((value) {
      RequestManager(value, createCall: () => _cardIssuanceUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cardIssuanceResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          cardNumber = event.data!.cardNumber;
          triggerPopup();
        }
      });
    });

    _cardDeliveryRequest.listen((value) {
      _cardDeliveryPopUpResponse.safeAdd(value);
    });
    fetchCardIssuanceDetails();
  }

  void fetchCardIssuanceDetails() {
    _cardIssuanceRequest.safeAdd(CardIssuanceUseCaseParams());
  }

  @override
  void dispose() {
    // _cardIssuanceRequest.close();
    // _cardIssuanceResponse.close();
    super.dispose();
  }
}
