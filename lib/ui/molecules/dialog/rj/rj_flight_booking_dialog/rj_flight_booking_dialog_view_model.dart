import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:rxdart/rxdart.dart';

class RjFlightBookingDialogViewModel extends BasePageViewModel {
  ///Controllers and Keys
  TextEditingController fromController = new TextEditingController();
  GlobalKey<AppTextFieldState> fromKey = GlobalKey(debugLabel: "from");

  TextEditingController toController = new TextEditingController();
  GlobalKey<AppTextFieldState> toKey = GlobalKey(debugLabel: "to");

  ///date selected for depart on
  TextEditingController selectedDepartOnDateController = new TextEditingController();
  GlobalKey<AppTextFieldState> selectedDepartOnDateKey = GlobalKey(debugLabel: "departOn");

  ///date selected for return on
  TextEditingController selectedReturnOnDateController = new TextEditingController();
  GlobalKey<AppTextFieldState> selectedReturnOnDateKey = GlobalKey(debugLabel: "returnOn");

  ScrollController scrollController = new ScrollController();

  DateTime initialDate = DateTime.now();

  List<Passenger> passengerList = [
    Passenger('Adult', '16 years +'),
    Passenger('Youth', '13 to 16 years'),
    Passenger('Children', '2 to 12 years'),
    Passenger('Infant', 'Below 2 years'),
  ];

  /// selectedTab

  BehaviorSubject<int> _selectedTabSubject = BehaviorSubject.seeded(0);

  Stream<int> get selectedTabStream => _selectedTabSubject.stream;

  /// selection of tab based on index
  void selectedTab(int selectedTabIndex) {
    _selectedTabSubject.add(selectedTabIndex);
  }

  PublishSubject<int> _selectedCabinClassSubject = PublishSubject();

  Stream<int> get selectedCabinClassSubjectStream => _selectedCabinClassSubject.stream;

  /// selection cabin class based on index
  void selectedCabinClass(int index) {
    _selectedCabinClassSubject.add(index);
  }

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
    CabinClassOption('Economy', AssetUtils.EconomySeat),
    CabinClassOption('Business', AssetUtils.BusinessSeat)
  ];
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
  Passenger(this.passengerType, this.passengerAgeRange);
}

class CabinClassOption {
  String option;
  String icon;

  CabinClassOption(this.option, this.icon);
}
