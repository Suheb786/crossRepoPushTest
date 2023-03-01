import 'package:domain/model/rj/get_flight_detail/flight_detail_response.dart';
import 'package:domain/usecase/rj/get_flight_details_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RjConfirmFlightDetailViewModel extends BasePageViewModel {
  final GetFlightDetailsUseCase _getFlightDetailsUseCase;

  ///---------------Get Flight Details----------------------///
  PublishSubject<GetFlightDetailsUseCaseParams> _getFlightDetailsRequest = PublishSubject();

  PublishSubject<Resource<FlightDetailResponse>> _getFlightDetailsResponse = PublishSubject();

  Stream<Resource<FlightDetailResponse>> get getFlightDetailsStream => _getFlightDetailsResponse.stream;

  void getFlightDetails({required String referenceNumber}) {
    _getFlightDetailsRequest.safeAdd(GetFlightDetailsUseCaseParams(referenceNumber: referenceNumber));
  }

  FlightDetailResponse flightDetailResponse = FlightDetailResponse();

  ///---------------Get Flight Details----------------------///

  RjConfirmFlightDetailViewModel(this._getFlightDetailsUseCase) {
    _getFlightDetailsRequest.listen((value) {
      RequestManager(value, createCall: () => _getFlightDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getFlightDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
