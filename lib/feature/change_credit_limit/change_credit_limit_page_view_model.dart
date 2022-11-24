import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ChangeCreditLimitPageViewModel extends BasePageViewModel {
  BehaviorSubject<double> _valueSubject = BehaviorSubject();

  Stream<double> get valueStream => _valueSubject.stream;

  void updateValue(double value) {
    _valueSubject.safeAdd(value);
  }

  PublishSubject<SliderLimitValues> _sliderValueSubject = PublishSubject();

  Stream<SliderLimitValues> get sliderValueStream => _sliderValueSubject.stream;

  void updateSliderValue(SliderLimitValues value) {
    _sliderValueSubject.safeAdd(value);
  }
}

class SliderLimitValues {
  final double? minValue;
  final double? maxValue;
  final int? divisions;

  SliderLimitValues({this.minValue: 0.0, this.maxValue: 0.0, this.divisions: 0});
}
