import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:data/helper/dynamic_link.dart';
import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/enum/credit_card_call_status_enum.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/constants/enum/primary_secondary_card_enum.dart';
import 'package:domain/constants/enum/primary_secondary_enum.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/apple_pay/get_antelop_cards_list_usecase.dart';
import 'package:domain/usecase/bank_smart/create_account_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_usecase.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:domain/usecase/dashboard/get_placeholder_usecase.dart';
import 'package:domain/usecase/dynamic_link/init_dynamic_link_usecase.dart';
import 'package:domain/usecase/payment/verify_qr_usecase.dart';
import 'package:domain/usecase/sub_account/deactivate_sub_account_usecase.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';
import 'package:domain/usecase/user/get_current_user_usecase.dart';
import 'package:domain/usecase/user/save_user_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/my_account_page_widget.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/ui/molecules/card/apply_credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/apply_debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_issuance_failure_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_not_delivered_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_error_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/dormant_account_debit_card_disbaled_widget.dart';
import 'package:neo_bank/ui/molecules/card/get_credit_card_now_widget.dart';
import 'package:neo_bank/ui/molecules/card/offer_for_you_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/resume_credit_card_application_view.dart';
import 'package:neo_bank/ui/molecules/card/rj_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/verify_credit_card_videocall_widget.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di/app/app_modules.dart';
import '../account_transaction/account_transaction_page.dart';
import '../card_transaction/card_transaction_page.dart';

class AppHomeViewModel extends BasePageViewModel {
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final VerifyQRUseCase _verifyQRUseCase;
  final GetAccountUseCase _getAccountUseCase;
  final CreateAccountUseCase _createAccountUseCase;
  final CloseSubAccountUseCase _closeSubAccountUsecase;

  final UpdateNickNameSubAccountUseCase _updateNickNameSubAccountUseCase;

  String? accountNo = "";
  String? iban = "";

  Timer? timer;
  final GetPlaceholderUseCase _getPlaceholderUseCase;

  final GetAntelopCardsListUseCase _getAntelopCardsListUseCase;

  final InitDynamicLinkUseCase _initDynamicLinkUseCase;

  ///Init Dynamic links
  PublishSubject<InitDynamicLinkUseCaseParams> _initDynamicLinkRequestRequest = PublishSubject();

  final PageController appSwiperController = PageController(viewportFraction: 0.8);

  BehaviorSubject<int> _currentStep = BehaviorSubject();

  Stream<int> get currentStep => _currentStep.stream;

  ///Timeline Arguments
  PublishSubject<bool> _showTimeLineSubject = PublishSubject();

  Stream<bool> get showTimeLineStream => _showTimeLineSubject.stream;

  BehaviorSubject<bool> _showRequestMoneyPopUpSubject = BehaviorSubject.seeded(false);

  bool isShowBalenceUpdatedToast = false;

  CardType cardType = CardType.DEBIT;

  ChangeCardPinArguments changeCardPinArguments = ChangeCardPinArguments();

  CreditCard currentCreditCard = CreditCard();

  GetDashboardDataContent dashboardDataContent = GetDashboardDataContent();

  /// ------------------------------Request money pop-up------------------///
  PublishSubject<bool> _requestMoneyPopUpResponse = PublishSubject();

  PublishSubject<bool> _requestMoneyRequest = PublishSubject();

  Stream<bool> get getRequestMoneyPopUpDataStream => _requestMoneyPopUpResponse.stream;

  /// ------------------------------Request money pop-up------------------///

  ///------------------------------dashboard card data response ------------------///
  BehaviorSubject<GetDashboardDataContent> _dashboardCardResponse =
      BehaviorSubject.seeded(GetDashboardDataContent());

  Stream<GetDashboardDataContent> get getDashboardCardDataStream => _dashboardCardResponse.stream;

  PublishSubject<GetDashboardDataUseCaseParams> _getDashboardDataRequest = PublishSubject();

  BehaviorSubject<Resource<GetDashboardDataResponse>> _getDashboardDataResponse = BehaviorSubject();

  Stream<Resource<GetDashboardDataResponse>> get getDashboardDataStream => _getDashboardDataResponse.stream;

  ///------------------------------dashboard card data response ------------------///

  Size deviceSize = Size(0, 0);

  ///pages response
  BehaviorSubject<List> _pagesResponseSubject = BehaviorSubject();

  ///pages response stream
  Stream<List> get pageStream => _pagesResponseSubject.stream;

  List pages = [];

  List<TimeLineSwipeUpArgs> cardTypeList = [];

  TimeLineArguments timeLineArguments = TimeLineArguments(timelineListArguments: []);

  List<TimeLineListArguments> timeLineListArguments = [];
  List<TimeLineListArguments> blinkTimeLineListArguments = [];

  ///*-------------------update nick name stream--------------------///
  PublishSubject<CloseSubAccountUseCaseParams> _closeSubAccountRequest = PublishSubject();

  BehaviorSubject<Resource<bool>> _closeSubAccountResponse = BehaviorSubject();

  Stream<Resource<bool>> get _closeSubAccountResponseStream => _closeSubAccountResponse.stream;

  ///subscription pop up stream
  PublishSubject<bool> _showSubSubscriptionPopUpStream = PublishSubject();

  Stream<bool> get showSubSubscriptionPopUpStream => _showSubSubscriptionPopUpStream.stream;

  /// get placeholder request

  PublishSubject<GetPlaceholderUseCaseParams> _getPlaceHolderRequest = PublishSubject();

  BehaviorSubject<Resource<GetPlaceholderResponse>> _getPlaceHolderResponse = BehaviorSubject();

  Stream<Resource<GetPlaceholderResponse>> get getPlaceHolderStream => _getPlaceHolderResponse.stream;

  ///get Account subject holder
  PublishSubject<GetAccountUseCaseParams> _getAccountRequest = PublishSubject();

  ///get Account response holder
  PublishSubject<Resource<GetAccountResponse>> _getAccountResponse = PublishSubject();

  ///get Account stream
  Stream<Resource<GetAccountResponse>> get getAccountStream => _getAccountResponse.stream;

  ///create Account subject holder
  PublishSubject<CreateAccountUseCaseParams> _createAccountRequest = PublishSubject();

  ///create Account response holder
  PublishSubject<Resource<CreateAccountResponse>> _createAccountResponse = PublishSubject();

  ///create Account stream
  Stream<Resource<CreateAccountResponse>> get createAccountStream => _createAccountResponse.stream;

  PlaceholderData timelinePlaceholderData = PlaceholderData();

  /// get request money placeholder request
  PublishSubject<GetPlaceholderUseCaseParams> _getRequestMoneyPlaceHolderRequest = PublishSubject();

  BehaviorSubject<Resource<GetPlaceholderResponse>> _getRequestMoneyPlaceHolderResponse = BehaviorSubject();

  Stream<Resource<GetPlaceholderResponse>> get getRequestMoneyPlaceHolderStream =>
      _getRequestMoneyPlaceHolderResponse.stream;

  PlaceholderData requestMoneyPlaceholderData = PlaceholderData();

  ///Completed debit and credit cards
  List<DebitCard> debitCards = [];
  List<CreditCard> creditCards = [];

  ///--------Get current user ---------///

  final PublishSubject<GetCurrentUserUseCaseParams> _currentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _currentUserResponseSubject = PublishSubject();

  Stream<Resource<User>> get currentUser => _currentUserResponseSubject.stream;

  void getCurrentUser() {
    _currentUserRequestSubject.add(GetCurrentUserUseCaseParams());
  }

  ///--------Get current user ---------///

  ///--------Save current user ---------///

  final PublishSubject<SaveUserDataUseCaseParams> _saveCurrentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _saveCurrentUserResponseSubject = PublishSubject();

  Stream<Resource<User>> get saveCurrentUser => _saveCurrentUserResponseSubject.stream;

  void saveCurrentUserData({required User user}) {
    _saveCurrentUserRequestSubject.add(SaveUserDataUseCaseParams(user: user));
  }

  ///--------Save current user ---------///

  ///---------------Verify QR----------------------///
  PublishSubject<VerifyQRUseCaseParams> _verifyQRRequest = PublishSubject();

  PublishSubject<Resource<VerifyQrResponse>> _verifyQRResponse = PublishSubject();

  Stream<Resource<VerifyQrResponse>> get verifyQRStream => _verifyQRResponse.stream;

  void verifyQR({required String requestId}) {
    _verifyQRRequest.safeAdd(VerifyQRUseCaseParams(requestId: requestId, source: 'L'));
  }

  ///---------------Verify QR----------------------///

  bool showPopUp = false;

  ///--------------- Animations ----------------------///

  late AnimationController translateSidewaysController;
  late AnimationController scaleAnimationController;
  late AnimationController translateTimelineDownController;
  late AnimationController translateSettingsUpController;
  late AnimationController translateAccountSettingsUpController;
  late Animation<double> settingsAnimation;
  late Animation<double> accountSettingsAnimation;

  late AnimationController zoomController;
  late Animation<double> zoomAnimation;

  late ScrollController timelineScrollController;

  ///--------------- Animated Pages streams ----------------------///

  BehaviorSubject<DashboardAnimatedPage> pageSwitchSubject =
      BehaviorSubject.seeded(DashboardAnimatedPage.NULL);

  Stream<DashboardAnimatedPage> get pageSwitchStream => pageSwitchSubject.stream;

  bool isMyAccount(int index) {
    return cardTypeList[index].cardType == CardType.ACCOUNT;
  }

  bool isMySubAccount(int index) {
    return cardTypeList[index].cardType == CardType.SUBACCOUNT;
  }

  bool isCreditCard(int index) {
    return cardTypeList[index].cardType == CardType.CREDIT;
  }

  bool isDebitCard(int index) {
    return cardTypeList[index].cardType == CardType.DEBIT;
  }

  bool isOffer(int index) {
    return cardTypeList[index].cardType == CardType.OFFER;
  }

  bool isRJ(int index) {
    return cardTypeList[index].cardType == CardType.RJ;
  }

  ///--------------- Some Other params that i will name later on  ----------------------///
  DebitCard? selectedDebitCard;
  CreditCard? selectedCreditCard;
  Account? selectedAccount;
  bool firstTime = true;
  bool animationInitialized = false;

  ///--------------- Credit card settings params  ----------------------///

  bool creditCardIsFreezed = false;
  bool creditCardIsUnFreezed = false;
  bool creditCardIsCancelled = false;

  ///--------------- Debit card settings params  ----------------------///

  bool debitCardIsFreezed = false;
  bool debitCardIsUnFreezed = false;
  bool debitCardIsCancelled = false;
  bool debitCardLostStolenReported = false;
  bool debitCardIsReportDamagedCard = false;
  bool debitCardRemoveOrReapply = false;

  bool isSmallDevices = false;

  AppHomeViewModel(
    this._getDashboardDataUseCase,
    this._getPlaceholderUseCase,
    this._initDynamicLinkUseCase,
    this._getCurrentUserUseCase,
    this._saveUserDataUseCase,
    this._verifyQRUseCase,
    this._getAntelopCardsListUseCase,
    this._getAccountUseCase,
    this._createAccountUseCase,
    this._closeSubAccountUsecase,
    this._updateNickNameSubAccountUseCase,
  ) {
    isShowBalenceUpdatedToast = false;
    deviceSize = MediaQuery.of(appLevelKey.currentContext!).size;
    isSmallDevices = deviceSize.height < ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
        deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
    _getDashboardDataRequest.listen((value) {
      RequestManager(value, createCall: () => _getDashboardDataUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDashboardDataResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          getTimelinePlaceholder();
          if (isShowBalenceUpdatedToast) {
            showSuccessToast("Your account balance is successfully updated.");
            isShowBalenceUpdatedToast = false;
          }
          dashboardDataContent = event.data!.dashboardDataContent!;
          _dashboardCardResponse.safeAdd(event.data!.dashboardDataContent);
          getDashboardPages(event.data!.dashboardDataContent!);
        }
      });
    });

    _getPlaceHolderRequest.listen((value) {
      RequestManager(value, createCall: () => _getPlaceholderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPlaceHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          triggerRequestMoneyPopup();

          ///fetching antelop cards
          initDynamicLink();
          timeLineArguments.placeholderData = timelinePlaceholderData;
        } else if (event.status == Status.SUCCESS) {
          ///fetching antelop cards
          triggerRequestMoneyPopup();
          initDynamicLink();
          timelinePlaceholderData = event.data!.data!;
          timeLineArguments.placeholderData = event.data!.data;
        }
      });
    });

    _getRequestMoneyPlaceHolderRequest.listen((value) {
      RequestManager(value, createCall: () => _getPlaceholderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getRequestMoneyPlaceHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
        } else if (event.status == Status.SUCCESS) {
          showRequestMoneyPopUp(false);
          if (event.data!.data!.status ?? false) {
            requestMoneyPlaceholderData = event.data!.data!;
            _requestMoneyRequest.safeAdd(true);
          }
        }
      });
    });

    _getAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _getAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          createAccount(
            customerAccountDetails: event.data!.content!.accountDetails!,
            customerInformation: event.data!.content!.customerInformation!,
            cif: "",
            isSubAccount: true,
          );
        }
      });
    });

    _createAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _createAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          accountNo = event.data?.content?.createAccountData?.accountNumber;
          iban = event.data?.content?.createAccountData?.iban;
        }
      });
    });
    _closeSubAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _closeSubAccountUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _closeSubAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          showHideSubAccountSettings(false);
          Future.delayed(Duration(milliseconds: 500), () {
            getDashboardData();
          });
        }
      });
    });

    _antelopGetCardsRequest.listen(
      (params) {
        RequestManager(params, createCall: () => _getAntelopCardsListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          _antelopGetCardResponse.safeAdd(event);
        });
      },
    );

    ///talabat placeholder
    // _sentMoneyRequest.listen((value) {
    //   _sentMoneyPopUpResponse.safeAdd(value);
    // });

    _requestMoneyRequest.listen((value) {
      _requestMoneyPopUpResponse.safeAdd(value);
    });

    _initDynamicLinkRequestRequest.listen((value) {
      RequestManager(value, createCall: () => _initDynamicLinkUseCase.execute(params: value))
          .asFlow()
          .listen((event) {});
    });

    _currentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _getCurrentUserUseCase.execute(params: value);
      }).asFlow().listen((event) async {
        _currentUserResponseSubject.add(event);
      });
    });

    _saveCurrentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _saveUserDataUseCase.execute(params: value);
      }).asFlow().listen((event) async {
        updateLoader();
        _saveCurrentUserResponseSubject.add(event);
      });
    });

    _verifyQRRequest.listen((value) {
      RequestManager(value, createCall: () => _verifyQRUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyQRResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _updateNickNameRequest.listen((value) {
      RequestManager(value, createCall: () => _updateNickNameSubAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _updateNickNameResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          getDashboardData();
        }
      });
    });

    getDashboardData();
    ProviderScope.containerOf(appLevelKey.currentContext!).read(appViewModel).startSessionWarningStream();
  }

  BehaviorSubject<Resource<bool>> _updateNickNameResponse = BehaviorSubject();

  Stream<Resource<bool>> get updateNickNameResponseStream => _updateNickNameResponse.stream;

  ///*-------------------update nick name api variable--------------------///
  PublishSubject<UpdateNickNameSubAccountUseCaseParams> _updateNickNameRequest = PublishSubject();

  void updateNickName({required String SubAccountNo, required String NickName}) {
    _updateNickNameRequest.safeAdd(
      UpdateNickNameSubAccountUseCaseParams(NickName: NickName, accountNo: SubAccountNo, GetToken: true),
    );
  }

  showPopUps() {
    if (!showPopUp) {
      showPopUp = true;
      getCurrentUser();
    }
  }

  void closeSubAccount({required String subAccountNo, required String iban}) {
    _closeSubAccountRequest
        .safeAdd(CloseSubAccountUseCaseParams(accountNo: subAccountNo, getToken: true, iban: iban));
  }

  void getAccount() {
    _getAccountRequest.safeAdd(GetAccountUseCaseParams());
  }

  void createAccount(
      {bool? isSubAccount,
      required CustomerAccountDetails customerAccountDetails,
      String? cif,
      required CustomerInformation customerInformation}) {
    _createAccountRequest.safeAdd(CreateAccountUseCaseParams(
        cif: cif,
        isSubAccount: isSubAccount,
        accountDetails: customerAccountDetails,
        customerInformation: customerInformation));
  }

  getOpenSubAccountCount(String? nickName) {
    int subAccountCount = 1;
    String? subAccountPrefix = nickName;
    List<Account> accounts =
        dashboardDataContent.accounts?.where((element) => (element.isSubAccount == false)).toList() ?? [];
    for (var account in accounts) {
      if (account.isSubAccount == true) {
        subAccountCount++;
      }
    }
    String result;
    if (subAccountCount == 0) {
      result = "$subAccountPrefix 1";
    } else {
      result = "$subAccountPrefix $subAccountCount";
    }
    print(result);
  }

  bool hasSubAccount(List<Account> accounts) {
    return accounts.any((account) => account.isSubAccount == true);
  }

  getMainAccount() {
    List<Account> mainAccounts =
        yourAllAccounts.where((account) => (account.isSelectedAccount == false)).toList();

    for (var account in mainAccounts) {
      return account;
    }
  }

  getMainAccountAvailableBalance() {
    List<Account> mainAccounts =
        yourAllAccounts.where((account) => (account.isSelectedAccount == false)).toList();

    for (var account in mainAccounts) {
      return account.availableBalance;
    }
  }

  List<Account> yourAllAccounts = [];

  List<Account> getAllMyAccounts() => yourAllAccounts;

  void getDashboardPages(GetDashboardDataContent dashboardDataContent) {
    pages.clear();
    timeLineListArguments.clear();
    blinkTimeLineListArguments.clear();
    debitCards.clear();
    creditCards.clear();
    cardTypeList.clear();
    yourAllAccounts.clear();

    ///Extracting Main Account
    var mainAccount =
        dashboardDataContent.accounts?.firstWhere((element) => !(element.isSubAccount ?? false));

    ///Adding subAccount into pages list first
    for (Account subAccount in (dashboardDataContent.accounts ?? [])) {
      if ((subAccount.isSubAccount ?? false)) {
        pages.add(MyAccountPageViewWidget(subAccount));
        cardTypeList.add(TimeLineSwipeUpArgs(
            object: subAccount,
            cardType: subAccount.isSubAccount ?? false ? CardType.SUBACCOUNT : CardType.ACCOUNT,
            swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES,
            timeLineEnum: TimeLineEnum.TIMELINE_YES));
      }
    }

    ///Adding main account
    dashboardDataContent.account = mainAccount;
    pages.add(MyAccountPageViewWidget(mainAccount!));
    cardTypeList.add(TimeLineSwipeUpArgs(
        object: mainAccount,
        cardType: mainAccount.isSubAccount ?? false ? CardType.SUBACCOUNT : CardType.ACCOUNT,
        swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES,
        timeLineEnum: TimeLineEnum.TIMELINE_YES));

    /// Adding all the accounts for the other pages to access so that we can show selection for the user to interact with the acocounts...
    yourAllAccounts.addAll(dashboardDataContent.accounts ?? []);

    ///setting timeline arguments value start
    timeLineArguments.availableBalance = dashboardDataContent.account!.availableBalance ?? '0.000';
    timeLineArguments.blinkWasBorn = dashboardDataContent.blinkWasBorn.toString();
    timeLineArguments.youJoinedBlink = dashboardDataContent.youJoinedBlink.toString();

    ///end

    if (dashboardDataContent.debitCardSomethingWrong ?? false) {
      pages.add(DebitCardErrorWidget(
        isSmallDevices: isSmallDevices,
      ));

      ///adding cardType
      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
    } else {
      if (dashboardDataContent.debitCard!.length > 0) {
        checkIfDebitCardThere(dashboardDataContent.debitCard);
        dashboardDataContent.debitCard!.forEach((debitCard) {
          if (debitCard.cardStatus == FreezeCardStatusEnum.L) {
            if (!(debitCard.isPINSet ?? true)) {
              if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                ///Dormant account widget
                pages.add(DormantAccountDebitCardDisabledWidget());

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                pages.add(ApplyDebitCardWidget(
                  debitRoutes: DebitRoutes.DASHBOARD,
                  isSmallDevice: isSmallDevices,
                  isPinSet: debitCard.isPINSet!,
                  cardHolderName: debitCard.accountTitle ?? '',
                  cardNo: debitCard.cardNumber ?? '',
                  primarySecondaryEnum: debitCard.primarySecondaryCard ?? PrimarySecondaryEnum.PRIMARY,
                ));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            } else {
              if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                ///Dormant account widget
                pages.add(DormantAccountDebitCardDisabledWidget());

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                pages.add(ApplyDebitCardWidget(
                  debitRoutes: DebitRoutes.DASHBOARD,
                  isSmallDevice: isSmallDevices,
                  isPinSet: true,
                  cardHolderName: debitCard.accountTitle ?? '',
                  cardNo: debitCard.cardNumber ?? '',
                  primarySecondaryEnum: debitCard.primarySecondaryCard ?? PrimarySecondaryEnum.PRIMARY,
                ));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            }
          } else {
            if (!(debitCard.isPINSet ?? true)) {
              if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                ///Dormant account widget
                pages.add(DormantAccountDebitCardDisabledWidget());

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                pages.add(ApplyDebitCardWidget(
                  debitRoutes: DebitRoutes.DASHBOARD,
                  isSmallDevice: isSmallDevices,
                  isPinSet: debitCard.isPINSet!,
                  cardHolderName: debitCard.accountTitle ?? '',
                  cardNo: debitCard.cardNumber ?? '',
                  primarySecondaryEnum: debitCard.primarySecondaryCard ?? PrimarySecondaryEnum.PRIMARY,
                ));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            } else {
              pages.add(DebitCardWidget(
                accountStatusEnum: dashboardDataContent.account?.accountStatusEnum ?? AccountStatusEnum.NONE,
                isPrimaryDebitCard: isPrimaryDebitCard,
                isSmallDevice: isSmallDevices,
                key: ValueKey('debit${debitCard.code}${debitCard.cvv}'),
                debitCard: debitCard,
                isDebitCardRequestPhysicalCardEnabled:
                    dashboardDataContent.dashboardFeatures?.isDebitCardRequestPhysicalCardEnabled ?? false,
                onSettingsClick: () {
                  /// showing settings page....
                  selectedDebitCard = debitCard;
                  selectedCreditCard = null;
                  showSettingPage(true);
                },
              ));

              ///time line list arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: debitCard.debitCardActivated.toString(),
                  cardDeliveredDatetime: debitCard.debitDeliveredDatetime.toString(),
                  cardId: '',
                  cardNumber: debitCard.cardNumber ?? '',
                  accountTitle: debitCard.accountTitle ?? '',
                  cardType: CardType.DEBIT,
                  isCardDelivered: debitCard.isDebitDelivered,
                  secureCode: debitCard.cardCode));

              ///adding cardType
              cardTypeList.add(TimeLineSwipeUpArgs(
                  cardType: CardType.DEBIT,
                  swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO,
                  timeLineEnum: TimeLineEnum.TIMELINE_YES));

              debitCards.add(debitCard);
            }
          }
        });
      } else {
        if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
          ///Dormant account widget
          pages.add(DormantAccountDebitCardDisabledWidget());

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        } else {
          pages.add(ApplyDebitCardWidget(
            debitRoutes: DebitRoutes.DASHBOARD,
            isSmallDevice: isSmallDevices,
            isPinSet: true,
            primarySecondaryEnum: PrimarySecondaryEnum.PRIMARY,
          ));

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        }
      }
    }

    if (dashboardDataContent.somethingWrong ?? false) {
      pages.add(CreditCardIssuanceFailureWidget(
        isSmallDevices: isSmallDevices,
        type: IssuanceType.failure,
      ));

      ///adding cardType
      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
    } else {
      if (dashboardDataContent.creditCard!.length > 0) {
        dashboardDataContent.creditCard!.forEach((creditCard) {
          if (creditCard.isCompleted ?? false) {
            if (creditCard.isCreditDelivered ?? false) {
              pages.add(CreditCardWidget(
                accountBalance: dashboardDataContent.account!.availableBalance,
                creditCard: creditCard,
                isChangePinEnabled: dashboardDataContent.dashboardFeatures?.isPinChangeEnabled ?? true,
                key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
                onPayBackClick: () {
                  selectedCreditCard = creditCard;
                  goToPayBackView(true);
                },
                onSettingsTap: () {
                  selectedCreditCard = creditCard;
                  selectedDebitCard = null;
                  showSettingPage(true);
                },
              ));

              ///time line list  arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                  cardDeliveredDatetime: creditCard.creditDeliveredDatetime ?? '',
                  cardId: creditCard.cardId ?? '',
                  cardNumber: creditCard.cardNumber ?? '',
                  accountTitle: creditCard.name ?? '',
                  cardType: CardType.CREDIT,
                  isCardDelivered: creditCard.isCreditDelivered,
                  secureCode: creditCard.cardCode,
                  isIssuedFromCMS: creditCard.issuedFromCms));

              ///adding cardType
              cardTypeList.add(TimeLineSwipeUpArgs(
                  cardType: CardType.CREDIT,
                  swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES,
                  timeLineEnum: TimeLineEnum.TIMELINE_YES,
                  object: creditCard));
              creditCards.add(creditCard);
            } else {
              pages.add(CreditCardNotDeliveredWidget(
                isSmallDevice: isSmallDevices,
                creditCard: creditCard,
                isChangePinEnabled: dashboardDataContent.dashboardFeatures?.isPinChangeEnabled ?? true,
                key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
                onSettingsTap: () {
                  selectedCreditCard = creditCard;
                  selectedDebitCard = null;
                  showSettingPage(true);
                },
              ));

              ///time line list  arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                  cardDeliveredDatetime: creditCard.creditDeliveredDatetime ?? '',
                  cardId: creditCard.cardId ?? '',
                  cardNumber: creditCard.cardNumber ?? '',
                  accountTitle: creditCard.name ?? '',
                  cardType: CardType.CREDIT,
                  isCardDelivered: creditCard.isCreditDelivered,
                  secureCode: creditCard.cardCode,
                  isIssuedFromCMS: creditCard.issuedFromCms));

              ///adding cardType
              cardTypeList
                  .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
            }
          } else {
            if (!(dashboardDataContent.dashboardFeatures?.isCreditCardFeatureEnabled ?? false)) {
              /*pages.add(CreditCardIssuanceFailureWidget(
                isSmallDevices: isSmallDevices,
                type: IssuanceType.service_unavailable,
              ));

              ///adding cardType
              cardTypeList
                  .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));*/
            } else {
              if (creditCard.primarySecondaryCard == PrimarySecondaryCardEnum.SECONDARY) {
              } else {
                switch (creditCard.callStatus) {
                  case CreditCardCallStatusEnum.APPROVED:
                    pages.add(GetCreditCardNowWidget(
                      isSmallDevices: isSmallDevices,
                      key: ValueKey('credit#GetCreditCardNowWidget#'),
                    ));
                    cardTypeList.add(
                        TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                    break;

                  case CreditCardCallStatusEnum.DROP:
                  case CreditCardCallStatusEnum.CALL_NOT_RECEIVED:
                    pages.add(VerifyCreditCardVideoCallWidget(
                      isSmallDevices: isSmallDevices,
                      creditCard: creditCard,
                    ));

                    ///adding cardType
                    cardTypeList.add(
                        TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                    break;

                  case CreditCardCallStatusEnum.REJECTED:
                    break;

                  default:
                    pages.add(ResumeCreditCardApplicationView(
                      isSmallDevices: isSmallDevices,
                    ));

                    ///adding cardType
                    cardTypeList.add(
                        TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                }
              }
            }
          }
        });
      } else {
        if (!(dashboardDataContent.dashboardFeatures?.isCreditCardFeatureEnabled ?? false)) {
          /*  pages.add(CreditCardIssuanceFailureWidget(
            isSmallDevices: isSmallDevices,
            type: IssuanceType.service_unavailable,
          ));

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));*/
        } else {
          pages.add(ApplyCreditCardWidget(
            isSmallDevices: isSmallDevices,
          ));

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        }
      }
    }

    /// adding rj card pages
    if ((dashboardDataContent.dashboardFeatures?.isRJFeatureEnabled ?? true)) {
      pages.add(RjCardWidget());

      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.RJ, swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES));
    }

    ///adding  offer for u card
    if ((dashboardDataContent.dashboardFeatures?.offers ?? true)) {
      pages.add(OfferForYouCardWidget());

      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.OFFER, swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES));
    }

    addPages(pages);

    ///Showing main Account first on login
    var mainAccountIndex = cardTypeList.lastIndexWhere((element) => element.cardType == CardType.ACCOUNT);
    appSwiperController.animateToPage(mainAccountIndex,
        duration: Duration(milliseconds: 500), curve: Curves.linear);

    blinkTimeLineListArguments.addAll(timeLineListArguments);
    timeLineArguments.timelineListArguments = blinkTimeLineListArguments;
    sortTimeLineArgumentsList();

    // if (pageSwitchSubject.value != DashboardAnimatedPage.NULL) {
    //   if (pageSwitchSubject.value != DashboardAnimatedPage.SETTINGS) {
    //     showSettingPage(false);
    //   }
    // }

    /// get Antelop Cards
    if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
      getAntelopCards();
    }
  }

  void addPages(List pagesList) {
    _pagesResponseSubject.safeAdd(pagesList);
  }

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void moveToPage(int index) {
    appSwiperController.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.linear);
  }

  List<Widget> buildPageIndicator(int currentPage, int totalPage) {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == currentPage ? indicator(true, i, currentPage) : indicator(false, i, currentPage));
    }
    return list;
  }

  bool isPrimaryDebitCard = true;

  checkIfDebitCardThere(List<DebitCard>? debitCards) {
    if (debitCards!.isNotEmpty) {
      DebitCard debitCard = debitCards.firstWhere(
          (debit) => debit.primarySecondaryCard == PrimarySecondaryEnum.PRIMARY,
          orElse: () => DebitCard());
      if (debitCard.cardNumber != null) {
        isPrimaryDebitCard = true;
      } else {
        isPrimaryDebitCard = false;
      }
    }
  }

  Widget indicator(bool isActive, int i, int currentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: getIndicatorSize(isActive, i, currentPage),
      width: getIndicatorSize(isActive, i, currentPage),
      decoration: BoxDecoration(
        color: getColor(isActive, i),
        shape: BoxShape.circle,
      ),
    );
  }

  void sortTimeLineArgumentsList() {
    if (blinkTimeLineListArguments.isNotEmpty) {
      ///sorting in descending order
      blinkTimeLineListArguments.sort((a, b) {
        return DateTime.parse(b.cardCardActivated ?? DateTime.now().toString())
            .compareTo(DateTime.parse(a.cardCardActivated ?? DateTime.now().toString()));
      });
    }
  }

  Color getColor(bool isActive, int i) {
    if (isActive) {
      return Colors.black;
    } else {
      return Color(0xFFA9A9A9);
    }
  }

  double getIndicatorSize(bool isActive, int i, int currentPage) {
    if (isActive) {
      return 7.0;
    } else if ((i == 0 || i == pages.length - 1) && !isActive) {
      return 5.0;
    }
    return 5.0;
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    _currentStep.safeAdd(index);
  }

  void updateShowTimeLineStream(bool value) {
    _showTimeLineSubject.add(value);
  }

  void getDashboardData() {
    _getDashboardDataRequest.safeAdd(GetDashboardDataUseCaseParams());
  }

  void balenceUpdate() {
    isShowBalenceUpdatedToast = true;
    _getDashboardDataRequest.safeAdd(GetDashboardDataUseCaseParams());
  }

  ///request money timeline placeholder
  void triggerRequestMoneyPopup() {
    if (_showRequestMoneyPopUpSubject.value) {
      _getRequestMoneyPlaceHolderRequest.safeAdd(GetPlaceholderUseCaseParams(placeholderId: 4));
    }
  }

  void triggerSubscriptionPopUp() {
    _showSubSubscriptionPopUpStream.safeAdd(true);
  }

  ///timeline placeholder
  void getTimelinePlaceholder() {
    _getPlaceHolderRequest.safeAdd(GetPlaceholderUseCaseParams(placeholderId: 5));
  }

  void showRequestMoneyPopUp(bool value) {
    _showRequestMoneyPopUpSubject.safeAdd(value);
  }

  bool isLinkOpened = false;

  initDynamicLink() async {
    Uri uri = await DynamicLinksService().initDynamicLinks();
    verifyQRData(uri: uri);
  }

  onResumeDynamicLink() {
    isLinkOpened = false;
    DynamicLinksService().onLink().distinct().listen((event) async {
      if (!isLinkOpened) {
        verifyQRData(uri: event.link);
      }
    });
  }

  void verifyQRData({required Uri uri}) {
    if (uri.path.isNotEmpty && uri.queryParameters.isNotEmpty && uri.path.contains("/payments")) {
      isLinkOpened = true;
      var requestId = uri.queryParameters['requestId']?.replaceAll(' ', '+');
      verifyQR(requestId: requestId ?? '');
    } else {
      showPopUps();
    }
  }

  ///--------------------Antelop Cards List-----------------///
  PublishSubject<GetAntelopCardsListUseCaseParams> _antelopGetCardsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _antelopGetCardResponse = PublishSubject();

  // isolates
  late ReceivePort receivePort;
  Isolate? isolate;

  void getAntelopCards() async {
    debugPrint("Enter in get antelop card from dashboard method");
    if (isolate != null) {
      debugPrint("Isolate not null");
      receivePort.close();
      isolate?.kill();
      isolate = null;
    }
    try {
      receivePort = ReceivePort();
      isolate = await Isolate.spawn(_getTokenCallBack, receivePort.sendPort);
      receivePort.listen(_handleMessage, onDone: () {});
    } on Exception catch (e) {
      debugPrint("isolate catch section " + e.toString());
    }
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    sendPort.send('Send Dashboard data');
  }

  void _handleMessage(message) {
    _antelopGetCardsRequest.safeAdd(GetAntelopCardsListUseCaseParams());
  }

  ///--------------------Antelop Cards List-----------------///

  ///--------------------Account dormant status -------------------///

  PublishSubject<bool> _showAccountDormantStatusPopUpRequest = PublishSubject();

  Stream<bool> get accountDormantStatusPopUpStream => _showAccountDormantStatusPopUpRequest.stream;

  void showAccountDormantPopUp(bool value) {
    _showAccountDormantStatusPopUpRequest.safeAdd(value);
  }

  ///--------------------Account dormant status -------------------///

  ///--------------------Add Another card To Apple Pay PopUp -------------------///

  PublishSubject<bool> _showAddAnotherCardToApplePayPopUpRequest = PublishSubject();

  Stream<bool> get showAddAnotherCardToApplePayPopUpStream =>
      _showAddAnotherCardToApplePayPopUpRequest.stream;

  void showAnotherAppToApplePayPupUp(bool value) {
    Future.delayed(Duration(milliseconds: 500), () {
      _showAddAnotherCardToApplePayPopUpRequest.safeAdd(value);
    });
  }

  ///--------------------Add Another card To Apple Pay PopUp -------------------///
  @override
  void dispose() {
    _currentStep.close();
    _showTimeLineSubject.close();
    _getPlaceHolderRequest.close();
    _getPlaceHolderResponse.close();
    _showRequestMoneyPopUpSubject.close();
    _verifyQRRequest.close();
    _verifyQRResponse.close();
    pageSwitchSubject.close();

    translateSidewaysController.dispose();
    translateSettingsUpController.dispose();
    translateAccountSettingsUpController.dispose();
    scaleAnimationController.dispose();
    translateTimelineDownController.dispose();
    appSwiperController.dispose();
    _updateNickNameRequest.close();
    _updateNickNameResponse.close();
    if (timer != null) {
      timer?.cancel();
    }

    super.dispose();
  }

  ///--------------- Animation methods... ----------------------///

  /// SETTINGS PAGE ANIMATIONS AND TRANSITIONS....
  showSettingPage(bool value, {bool updateDashboard = false, int currentStep = 0}) {
    if (value) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {},
      );
      animateForwardSettingsPage();
    } else {
      selectedDebitCard = selectedCreditCard = null;
      animateReverseSettingsPage();
    }

    pageSwitchSubject.add(value ? DashboardAnimatedPage.SETTINGS : DashboardAnimatedPage.NULL);
    _currentStep.add(_currentStep.value);
    if (updateDashboard) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (isDebitCard(currentStep)) {
          onDebitCardSettingsClosed();
        } else if (isCreditCard(currentStep)) {
          onCreditCardSettingsClosed();
        }
      });
    }
  }

  showHideAccountSettings(bool value, {Account? account}) {
    selectedAccount = account;
    if (value) {
      translateSidewaysController.forward();
      translateAccountSettingsUpController.forward();
    } else {
      translateSidewaysController.reverse();
      translateAccountSettingsUpController.reverse();
    }
    pageSwitchSubject.add(value ? DashboardAnimatedPage.ACT_SETTING : DashboardAnimatedPage.NULL);
  }

  showHideSubAccountSettings(bool value, {Account? account}) {
    selectedAccount = account;
    if (value) {
      translateSidewaysController.forward();
      translateAccountSettingsUpController.forward();
    } else {
      translateSidewaysController.reverse();
      translateAccountSettingsUpController.reverse();
    }
    pageSwitchSubject.add(value ? DashboardAnimatedPage.SUB_ACT_SETTING : DashboardAnimatedPage.NULL);
  }

  void closeSubAccountDialogAndRefreshPage() {
    Future.delayed(Duration(milliseconds: 200), () {
      showHideSubAccountSettings(false);
      Future.delayed(Duration(milliseconds: 500), () {
        getDashboardData();
      });
    });
  }

  animateForwardSettingsPage() {
    translateSidewaysController.forward();
    translateSettingsUpController.forward();
  }

  animateReverseSettingsPage() {
    translateSidewaysController.reverse();
    translateSettingsUpController.reverse();
  }

  /// PAYBACK PAGE ANIMATIONS AND TRANSITIONS....
  goToPayBackView(bool value) {
    if (value) {
      animateForwardSettingsPage();
    } else {
      animateReverseSettingsPage();
    }

    pageSwitchSubject.add(value ? DashboardAnimatedPage.PAYBACK : DashboardAnimatedPage.NULL);
  }

  animateForwardTimelinePage() {
    translateTimelineDownController.forward();
    translateSidewaysController.forward();
  }

  animateReverseTimelinePage() {
    translateTimelineDownController.reverse();
    translateSidewaysController.reverse();
  }

  /// TIMELINE PAGE ANIMATIONS AND TRANSITIONS....

  showTimeline(bool value) {
    if (value) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          timelineGlitchAnimation();
        },
      );
      animateForwardTimelinePage();
    } else {
      animateReverseTimelinePage();
    }
    pageSwitchSubject.add(value ? DashboardAnimatedPage.TIMELINE : DashboardAnimatedPage.NULL);
  }

  timelineGlitchAnimation() {
    if (timelineScrollController.positions.isNotEmpty && timelineScrollController.hasClients)
      timelineScrollController
          .animateTo(30, duration: const Duration(milliseconds: 400), curve: Curves.easeIn)
          .then((value) {
        if (timelineScrollController.positions.isNotEmpty && timelineScrollController.hasClients)
          timelineScrollController.animateTo(-30,
              duration: const Duration(milliseconds: 500), curve: Curves.easeInBack);
      });
  }

  goToTransactionPage(BuildContext context, int currentStep) {
    animateForwardTransactionPage();
    Navigator.of(context).push(CustomRoute.swipeUpRoute(CardTransactionPage(
      GetCreditCardTransactionArguments(
          cardId: (cardTypeList[currentStep].object as CreditCard).cardId,
          secureCode: (cardTypeList[currentStep].object as CreditCard).cardCode ?? '',
          isIssuedFromCMS: (cardTypeList[currentStep].object as CreditCard).issuedFromCms),
    )));
  }

  goToAccountTransactionPage(BuildContext context, Account? accountCardAccountNo) {
    animateForwardTransactionPage();
    Navigator.of(context).push(CustomRoute.swipeUpRoute(
        AccountTransactionPage(AccountTransactionPageArgument(accountCardAccountNo?.accountNo))));
  }

  goToOfferForYouPage(BuildContext context) {
    translateSettingsUpController.forward();
    scaleAnimationController.forward();
    Navigator.of(context).push(CustomRoute.swipeUpRoute(OfferForYouPage()));
  }

  animateForwardTransactionPage() {
    pageSwitchSubject.add(DashboardAnimatedPage.TRANSACTIONS);

    translateSettingsUpController.forward();
    scaleAnimationController.forward();
  }

  animateReverseTransactionPage() {
    pageSwitchSubject.add(DashboardAnimatedPage.NULL);
    translateSettingsUpController.reverse();
    scaleAnimationController.reverse();
  }

  ///Credit card logic
  bool showButtonsInCreditCard = true;

  showButtonsCreditCard() {
    showButtonsInCreditCard = !showButtonsInCreditCard;
    notifyListeners();
  }

  void onDebitCardSettingsClosed() {
    if (debitCardIsFreezed ||
        debitCardIsUnFreezed ||
        debitCardIsCancelled ||
        debitCardIsReportDamagedCard ||
        debitCardLostStolenReported) {
      getDashboardData();
    }
  }

  void onCreditCardSettingsClosed() {
    if (creditCardIsFreezed || creditCardIsUnFreezed || creditCardIsCancelled) {
      getDashboardData();
    }
  }
}

class TimeLineSwipeUpArgs {
  final CardType cardType;

  final SwipeUpEnum swipeUpEnum;

  final TimeLineEnum timeLineEnum;

  final Object? object;

  TimeLineSwipeUpArgs(
      {this.cardType = CardType.ACCOUNT,
      this.swipeUpEnum = SwipeUpEnum.SWIPE_UP_NO,
      this.timeLineEnum = TimeLineEnum.TIMELINE_NO,
      this.object = null});
}

enum SwipeUpEnum {
  SWIPE_UP_YES, // transactions
  SWIPE_UP_NO, // don't show transactions
}

enum TimeLineEnum {
  TIMELINE_YES, // time line
  TIMELINE_NO, // don't show time line
}

enum DashboardAnimatedPage {
  TIMELINE,
  PAYBACK,
  SETTINGS,
  TRANSACTIONS,
  ACT_SETTING,
  SUB_ACT_SETTING,
  OFFER,
  NULL
}

enum DashboardCardType { account, credit, debit, subAccount, rj }
