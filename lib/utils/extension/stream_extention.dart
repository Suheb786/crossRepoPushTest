import 'package:rxdart/rxdart.dart';

extension SafeSubjectAddExtn on Subject {
  void safeAdd(dynamic data) {
    if (!this.isClosed) {
      this.add(data);
    }
  }
}
