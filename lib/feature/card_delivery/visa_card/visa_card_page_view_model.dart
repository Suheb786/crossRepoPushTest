import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:domain/usecase/dashboard/get_placeholder_usecase.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class VisaCardPageViewModel extends BasePageViewModel {
  final FlipCardController cardController = FlipCardController();
  final CardIssuanceUseCase _cardIssuanceUseCase;
  final GetPlaceholderUseCase _getPlaceholderUseCase;

  PublishSubject<CardIssuanceUseCaseParams> _cardIssuanceRequest =
      PublishSubject();

  BehaviorSubject<Resource<CardIssuanceDetails>> _cardIssuanceResponse =
      BehaviorSubject();

  String? cardNumber;

  Stream<Resource<CardIssuanceDetails>> get cardIssuanceStream =>
      _cardIssuanceResponse.stream;

  /// get placeholder request
  PublishSubject<GetPlaceholderUseCaseParams> _getPlaceHolderRequest =
      PublishSubject();

  BehaviorSubject<Resource<GetPlaceholderResponse>> _getPlaceHolderResponse =
      BehaviorSubject();

  Stream<Resource<GetPlaceholderResponse>> get getPlaceHolderStream =>
      _getPlaceHolderResponse.stream;

  PlaceholderData onBoardingPlaceholderData = PlaceholderData();

  /// card delivery pop up request
  PublishSubject<bool> _cardDeliveryPopUpResponse = PublishSubject();

  /// card delivery pop up response
  PublishSubject<bool> _cardDeliveryRequest = PublishSubject();

  /// card delivery pop up stream
  Stream<bool> get cardDeliveryPopUpDataStream =>
      _cardDeliveryPopUpResponse.stream;

  void triggerPopup() {
    _cardDeliveryRequest.safeAdd(true);
  }

  VisaCardPageViewModel(
      this._cardIssuanceUseCase, this._getPlaceholderUseCase) {
    _cardIssuanceRequest.listen((value) {
      RequestManager(value,
              createCall: () => _cardIssuanceUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cardIssuanceResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          cardNumber = event.data!.cardNumber;
          getPlaceholder();
        }
      });
    });

    _getPlaceHolderRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getPlaceholderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPlaceHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
        } else if (event.status == Status.SUCCESS) {
          onBoardingPlaceholderData = event.data!.data!;
          if (event.data!.data!.status ?? false) {
            triggerPopup();
          }
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

  ///on boarding placeholder
  void getPlaceholder() {
    _getPlaceHolderRequest
        .safeAdd(GetPlaceholderUseCaseParams(placeholderId: 1));
  }

  @override
  void dispose() {
    // _cardIssuanceRequest.close();
    // _cardIssuanceResponse.close();
    super.dispose();
  }
}
