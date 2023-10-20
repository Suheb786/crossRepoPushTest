import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/model/rj/destinations.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/base_page_view_model.dart';
import '../../../di/dashboard/dashboard_modules.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/request_manager.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';
import '../../../utils/time_utils.dart';

class RjFlightBookingViewModel extends BasePageViewModel {
  final GetDestinationUseCase _getDestinationUseCase;
  final GetOneWayTripLinkUseCase _getOneWayTripLinkUseCase;
  final GetTwoWayTripLinkUseCase _getTwoWayTripLinkUseCase;

  ///----------------Get Destination--------------///
  PublishSubject<GetDestinationUseCaseParams> _getDestinationRequest = PublishSubject();

  BehaviorSubject<Resource<DestinationResponse>> _getDestinationResponse = BehaviorSubject();

  Stream<Resource<DestinationResponse>> get getDestinationStream => _getDestinationResponse.stream;

  void getDestination() {
    _getDestinationRequest.safeAdd(GetDestinationUseCaseParams(language: 'EN', origin: 'AMM', service: ''));
  }

  ///----------------Get Destination--------------///

  ///----------------Get One Way Link--------------///
  PublishSubject<GetOneWayTripLinkUseCaseParams> _getOneWayLinkRequest = PublishSubject();

  PublishSubject<Resource<GetTripResponse>> _getOneWayLinkResponse = PublishSubject();

  Stream<Resource<GetTripResponse>> get getOneWayLinkStream => _getOneWayLinkResponse.stream;

  void getOneWayLink(BuildContext context) {
    _getOneWayLinkRequest.safeAdd(GetOneWayTripLinkUseCaseParams(
        language: 'EN',
        org: "AMM",
        des: selectedDestination.code,
        date1: TimeUtils.getFormattedDateForRJ(departOnDate),
        adults: '${passengerList[0].count}',
        youths: '${passengerList[1].count}',
        infants: '${passengerList[3].count}',
        childs: '${passengerList[2].count}',
        promoCode: '',
        customerRef: '',
        cabin: _selectedCabinClassSubject.value == 0 ? 'E' : 'B'));
  }

  ///----------------Get One Way Link--------------///

  ///----------------Get Two Way Link--------------///
  PublishSubject<GetTwoWayTripLinkUseCaseParams> _getTwoWayLinkRequest = PublishSubject();

  PublishSubject<Resource<GetTripResponse>> _getTwoWayLinkResponse = PublishSubject();

  Stream<Resource<GetTripResponse>> get getTwoWayLinkStream => _getTwoWayLinkResponse.stream;

  void getTwoWayLink(BuildContext context) {
    _getTwoWayLinkRequest.safeAdd(GetTwoWayTripLinkUseCaseParams(
        language: 'EN',
        org: "AMM",
        des: selectedDestination.code,
        toDate: TimeUtils.getFormattedDateForRJ(departOnDate),
        fromDate: TimeUtils.getFormattedDateForRJ(returnOnDate),
        departOnDate: departOnDate,
        returnOnDate: returnOnDate,
        adults: '${passengerList[0].count}',
        youths: '${passengerList[1].count}',
        infants: '${passengerList[3].count}',
        childs: '${passengerList[2].count}',
        promoCode: '',
        customerRef: '',
        cabin: _selectedCabinClassSubject.value == 0 ? 'E' : 'B'));
  }

  ///----------------Get Two Way Link--------------///

  ///Controllers and Keys
  TextEditingController fromController = new TextEditingController();

  TextEditingController toController = new TextEditingController();

  ///date selected for depart on
  TextEditingController selectedDepartOnDateController = new TextEditingController();

  ///date selected for return on
  TextEditingController selectedReturnOnDateController = new TextEditingController();

  ScrollController scrollController = new ScrollController();

  DateTime departOnDate = DateTime.now();
  DateTime returnOnDate = DateTime.now();

  DateTime initialDate = DateTime.now();
  List<Passenger> passengerList = [
    Passenger(S.current.adult, S.current.sixTeenYearsPlus),
    Passenger(S.current.youth, S.current.threeToSixteenYears),
    Passenger(S.current.children, S.current.twoToTwelve),
    Passenger(S.current.infant, S.current.belowTwoYears),
  ];

  /// ------------- tabChange listener -----------------------

  ValueNotifier<int> tabChangeNotifier = ValueNotifier(0);

  PublishSubject<int> switchTabSubject = PublishSubject();

  Stream<int> get switchTabStream => switchTabSubject.stream;

  RjFlightBookingViewModel(
      this._getDestinationUseCase, this._getOneWayTripLinkUseCase, this._getTwoWayTripLinkUseCase) {
    _getDestinationRequest.listen((value) {
      RequestManager(value, createCall: () => _getDestinationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDestinationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _getOneWayLinkRequest.listen((value) {
      RequestManager(value, createCall: () => _getOneWayTripLinkUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getOneWayLinkResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _getTwoWayLinkRequest.listen((value) {
      RequestManager(value, createCall: () => _getTwoWayTripLinkUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getTwoWayLinkResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getDestination();
  }

  /// selectedTab

  BehaviorSubject<int> _selectedTabSubject = BehaviorSubject.seeded(0);

  Stream<int> get selectedTabStream => _selectedTabSubject.stream;

  /// selection of tab based on index
  void selectedTab(int selectedTabIndex) {
    selectedReturnOnDateController.clear();
    _selectedTabSubject.add(selectedTabIndex);
  }

  BehaviorSubject<int> _selectedCabinClassSubject = BehaviorSubject.seeded(0);

  Stream<int> get selectedCabinClassSubjectStream => _selectedCabinClassSubject.stream;

  /// selection cabin class based on index
  void selectedCabinClass(int index) {
    _selectedCabinClassSubject.add(index);
  }

  Destinations selectedDestination = Destinations();

  ///-------------Field validation-------------///

  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  bool isValid() {
    bool valid = false;
    if (_selectedTabSubject.value == 0) {
      if (toController.text.isNotEmpty && selectedDepartOnDateController.text.isNotEmpty) {
        valid = true;
      }
    } else if (toController.text.isNotEmpty &&
        selectedDepartOnDateController.text.isNotEmpty &&
        selectedReturnOnDateController.text.isNotEmpty) {
      valid = true;
    }
    int passengerType = 0;
    passengerList.forEach((element) {
      if (element.count == 0) {
        passengerType++;
      }
    });
    valid = passengerType != passengerList.length;

    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  ///-------------Field validation-------------///

  @override
  void dispose() {
    _selectedCabinClassSubject.close();
    super.dispose();
  }

  List<RjBookingFlightTabOption> rjBookingFlightTabOptionList = [
    RjBookingFlightTabOption('One-Way'),
    RjBookingFlightTabOption('Return')
  ];

  List<CabinClassOption> cabinClassOptionList = [
    CabinClassOption(S.current.economy, AssetUtils.EconomySeat),
    CabinClassOption(S.current.business, AssetUtils.BusinessSeat)
  ];

  void getTripLink(BuildContext context) {
    if (tabChangeNotifier.value == 0) {
      getOneWayLink(context);
    } else {
      getTwoWayLink(context);
    }
  }

  void animateBackToDashboard(BuildContext context) {
    final dashboardProvider = ProviderScope.containerOf(context).read(
      appHomeViewModelProvider,
    );

    dashboardProvider.animateReverseTransactionPage();
  }
}

class RjBookingFlightTabOption {
  String option;

  RjBookingFlightTabOption(
    this.option,
  );
}

class Passenger {
  String passengerType;
  String passengerAgeRange;
  int count;

  Passenger(this.passengerType, this.passengerAgeRange, {this.count = 0});
}

class CabinClassOption {
  String option;
  String icon;

  CabinClassOption(this.option, this.icon);
}
