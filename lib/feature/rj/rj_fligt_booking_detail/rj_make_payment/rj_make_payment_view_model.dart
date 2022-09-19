import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class RjMakePaymentViewModel extends BasePageViewModel {
  RjMakePaymentViewModel() {
    // _itemSelectedSubject.safeAdd(Resource.success(data:makePaymentCardList ));
  }

  List<MakePaymentCard> makePaymentCardList = [
    MakePaymentCard('My Credit Card', '•••• •••• •••• 2111', '7,896.320', 'JOD', false),
    MakePaymentCard('My Credit Card', '•••• •••• •••• 2111', '7,896.320', 'JOD', false),
    MakePaymentCard('My Credit Card', '•••• •••• •••• 2111', '7,896.320', 'JOD', false),
    MakePaymentCard('My Credit Card', '•••• •••• •••• 2111', '7,896.320', 'JOD', false),
    MakePaymentCard('My Credit Card', '•••• •••• •••• 2111', '7,896.320', 'JOD', false),
  ];
  PublishSubject<Resource<List<MakePaymentCard>>> _itemSelectedSubject = PublishSubject();

  Stream<Resource<List<MakePaymentCard>>> get itemSelectedStream => _itemSelectedSubject.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject();

  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  @override
  void dispose() {
    super.dispose();
  }

  void addMakePaymentItem() {
    _itemSelectedSubject.safeAdd(Resource.success(data: makePaymentCardList));
  }

  void selectedItem(int index) {
    if (makePaymentCardList.isNotEmpty) {
      makePaymentCardList.forEach((element) {
        element.isSelected = false;
      });
      makePaymentCardList[index].isSelected = true;
    }
    _itemSelectedSubject.safeAdd(Resource.success(data: makePaymentCardList));
    _showButtonSubject.safeAdd(true);
  }
}

class MakePaymentCard {
  final String cardName;
  final String cardNo;
  final String amt;
  final String currency;
  bool isSelected;

  MakePaymentCard(this.cardName, this.cardNo, this.amt, this.currency, this.isSelected);
}
