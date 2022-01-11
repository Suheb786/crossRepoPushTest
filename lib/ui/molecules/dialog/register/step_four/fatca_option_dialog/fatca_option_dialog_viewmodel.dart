import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class FatcaOptionDialogViewModel extends BasePageViewModel {
  AdditionalDataDropDownData? selectedOptionData = AdditionalDataDropDownData();

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  ///get country list response holder
  BehaviorSubject<Resource<List<AdditionalDataDropDownData>>>
      _optionDataSubject = BehaviorSubject();

  ///get country list response
  Stream<Resource<List<AdditionalDataDropDownData>>> get optionalDataStream =>
      _optionDataSubject.stream;

  List<AdditionalDataDropDownData>? allOptionalDataList = [];

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  void selectMobileNumber(int index) {
    List<AdditionalDataDropDownData>? countryList =
        _optionDataSubject.value.data;
    if (countryList!.isNotEmpty) {
      countryList.forEach((element) {
        element.isSelected = false;
      });
      countryList.elementAt(index).isSelected = true;
      selectedOptionData =
          countryList.firstWhere((element) => element.isSelected);
      _optionDataSubject.safeAdd(Resource.success(data: countryList));
    }
  }

  void setOptionData(List<AdditionalDataDropDownData> data) {
    _optionDataSubject.safeAdd(Resource.success(data: data));
    allOptionalDataList = data;
    selectMobileNumber(0);
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _optionDataSubject.close();
    super.dispose();
  }
}
