import 'dart:convert';

import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/usecase/card_delivery/create_issuance_usecase.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_3des/flutter_3des.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:steel_crypt/steel_crypt.dart';

class VisaCardPageViewModel extends BasePageViewModel {
  final FlipCardController cardController = FlipCardController();
  final CardIssuanceUseCase _cardIssuanceUseCase;

  PublishSubject<CardIssuanceUseCaseParams> _cardIssuanceRequest =
  PublishSubject();

  PublishSubject<Resource<CardIssuanceDetails>> _cardIssuanceResponse =
  PublishSubject();

  Stream<Resource<CardIssuanceDetails>> get cardIssuanceStream =>
      _cardIssuanceResponse.stream;

  VisaCardPageViewModel(this._cardIssuanceUseCase) {
    _cardIssuanceRequest.listen((value) {
      RequestManager(value,
          createCall: () => _cardIssuanceUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cardIssuanceResponse.safeAdd(event);
      });
    });
    fetchCardIssuanceDetails();
  }

  void fetchCardIssuanceDetails() {
    _cardIssuanceRequest.safeAdd(CardIssuanceUseCaseParams());
  }

  Future<String> getDecryptedData(String encryptedResponse) async {
    String base64ToHex(String source) =>
        base64Decode(LineSplitter.split(source).join())
            .map((e) => e.toRadixString(16).padLeft(2, '0'))
            .join();

    final hex = base64ToHex(encryptedResponse);

    print("data $encryptedResponse");
    print("hex $hex");

    var decrypt = await Flutter3des.decryptFromBase64(
        encryptedResponse, "0123456789ABCDEFFEDCBA98765432100123456789ABCDEF",
        iv: "AB9B545DAEC2ABC74FB90D15CE04B997");

    print("DECRYPT $decrypt");

    var aesCrypt = AesCrypt(
      // key: "0123456789ABCDEFFEDCBA98765432100123456789ABCDEF",
        key: "AB9B545DAEC2ABC74FB90D15CE04B997",
        padding: PaddingAES.iso78164);
    String decrypted = aesCrypt.ecb.decrypt(enc: hex);
    //var aesCrypt = AesCrypt(key: Constants.KEY, padding: PaddingAES.iso78164);
    // String decrypted =
    //     aesCrypt.cbc.decrypt(enc: encryptedResponse, iv: Constants.IV);
    print("decrypted data is $decrypted");
    return decrypted;
  }

  @override
  void dispose() {
    _cardIssuanceRequest.close();
    _cardIssuanceResponse.close();
    super.dispose();
  }
}
