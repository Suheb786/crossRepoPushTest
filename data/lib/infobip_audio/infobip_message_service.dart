// import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
// import 'package:infobip_mobilemessaging/models/Configuration.dart';
// import 'package:infobip_mobilemessaging/models/IOSChatSettings.dart';
// import 'package:infobip_mobilemessaging/models/LibraryEvent.dart';

class InfobipMessageService {
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> initPlatformState() async {
    // await InfobipMobilemessaging.init(
    //   Configuration(
    //     applicationCode:
    //         "ba5a5387c4c6d249017b320e2e9d5f7d-f5686c8d-d45a-4253-9b93-496e52f2a9dd",
    //     inAppChatEnabled: true,
    //     androidSettings: AndroidSettings(firebaseSenderId: "660487917685"),
    //     defaultMessageStorage: true,
    //     iosSettings: IOSSettings(
    //         notificationTypes: ["alert", "badge", "sound"],
    //         forceCleanup: false,
    //         logging: true),
    //   ),
    // );
    // InfobipMobilemessaging.setupiOSChatSettings(IOSChatSettings(
    //   title: 'Flutter Example Chat',
    //   sendButtonColor: '#ff5722',
    //   navigationBarItemsColor: '#ff8a50',
    //   navigationBarColor: '#c41c00',
    //   navigationBarTitleColor: '#000000',
    // ));
    return true;
  }
}
