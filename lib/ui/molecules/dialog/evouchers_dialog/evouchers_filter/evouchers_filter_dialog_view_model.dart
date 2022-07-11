import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:rxdart/rxdart.dart';

class EVouchersFilterDialogViewModel extends BasePageViewModel {
  ///Controllers and Keys
  TextEditingController categoryController = new TextEditingController();
  GlobalKey<AppTextFieldState> categoryKey = GlobalKey(debugLabel: "category");

  TextEditingController preferredRegionController = new TextEditingController();
  GlobalKey<AppTextFieldState> preferredRegionKey = GlobalKey(debugLabel: "preferredRegion");

  TextEditingController minPriceController = new TextEditingController();
  GlobalKey<AppTextFieldState> minPriceKey = GlobalKey(debugLabel: "minPrice");

  TextEditingController maxPriceController = new TextEditingController();
  GlobalKey<AppTextFieldState> maxPriceKey = GlobalKey(debugLabel: "maxPrice");

  List<String> categoryList = ['All Categories', 'Shopping', 'Games', 'Music', 'Dance', 'Surfing'];
  List<String> preferredRegionList = [
    'All Region',
    'Jordan',
    'United Kingdom',
    'Bahrain',
    'India',
    'Australia',
    'United States Of America'
  ];

  List<String> minMaxPriceList = [
    '0 JOD',
    '5 JOD',
    '10 JOD',
    '15 JOD',
    '20 JOD',
    '25 JOD',
    '30 JOD',
    '35 JOD',
    '45 JOD',
    '50 JOD'
  ];

  /// button subject
  BehaviorSubject<bool> _showResetButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showResetButtonSubject.stream;

  void showResetFilterButton() {
    if (categoryController.text.isNotEmpty ||
        preferredRegionController.text.isNotEmpty ||
        minPriceController.text.isNotEmpty ||
        maxPriceController.text.isNotEmpty) {
      _showResetButtonSubject.add(true);
    } else {
      _showResetButtonSubject.add(false);
    }
  }

  resetFilter() {
    categoryController.clear();
    preferredRegionController.clear();
    minPriceController.clear();
    maxPriceController.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
