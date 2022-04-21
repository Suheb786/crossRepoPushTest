import 'package:flip_card/flip_card_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class DcSettingVisaCardPageViewModel extends BasePageViewModel {
  final FlipCardController cardController = FlipCardController();

  @override
  void dispose() {
    // _cardIssuanceRequest.close();
    // _cardIssuanceResponse.close();
    super.dispose();
  }
}
