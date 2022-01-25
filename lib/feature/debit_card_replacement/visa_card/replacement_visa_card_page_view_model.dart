import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ReplacementVisaCardPageViewModel extends BasePageViewModel {
  final FlipCardController cardController = FlipCardController();
  final CardIssuanceUseCase _cardIssuanceUseCase;

  PublishSubject<CardIssuanceUseCaseParams> _cardIssuanceRequest =
      PublishSubject();

  PublishSubject<Resource<CardIssuanceDetails>> _cardIssuanceResponse =
      PublishSubject();

  String? cardNumber;

  Stream<Resource<CardIssuanceDetails>> get cardIssuanceStream =>
      _cardIssuanceResponse.stream;

  ReplacementVisaCardPageViewModel(this._cardIssuanceUseCase) {
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
        }
      });
    });
    fetchCardIssuanceDetails();
  }

  void fetchCardIssuanceDetails() {
    _cardIssuanceRequest.safeAdd(CardIssuanceUseCaseParams());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
