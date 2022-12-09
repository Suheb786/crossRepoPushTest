import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:rxdart/rxdart.dart';

class RjBookingPageViewModel extends BasePageViewModel {
  final RjBookingPageArguments rjBookingPageArguments;
  InAppWebViewController? webViewController;

  RjBookingPageViewModel(this.rjBookingPageArguments);

  /// indicator progress value subject holder
  PublishSubject<double> _indicatorProgressSubject = PublishSubject();

  /// indicator progress value stream
  Stream<double> get indicatorProgressStream => _indicatorProgressSubject.stream;

  ///indicator progress value set function
  void setIndicatorProgressValue(double progress) {
    _indicatorProgressSubject.add(progress);
  }

  loadNewUrl() {
    webViewController?.loadUrl(
        urlRequest: URLRequest(
            url: Uri.parse(
                'http://10.6.13.2:2186/RJFlightConfirmation/Index/?customerReferece=BLNKY239UKFW11&status=SUCCESS&token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0LnVzZXIucmpAbWFpbC5jb20iLCJhY2Nlc3NUb2tlbiI6ImNvb2tpZSIsIm5iZiI6MTY3MDQwNzM5MywiZXhwIjoxNjcwNDA5MTkzLCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo0NDMxMS8iLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo0NDMxMS8ifQ.7aYHSkTGjkhwYusODiqBk7nAa2wkWtJf8Q4YqWoTkLc')));
  }
}
