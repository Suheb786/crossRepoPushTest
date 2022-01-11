import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:infobip_mobilemessaging/models/Configuration.dart';
import 'package:infobip_mobilemessaging/models/IOSChatSettings.dart';
import 'package:infobip_mobilemessaging/models/UserData.dart';

class InfobipMessageService {
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> initPlatformState() async {
    await InfobipMobilemessaging.init(
      Configuration(
        applicationCode:
            "ba5a5387c4c6d249017b320e2e9d5f7d-f5686c8d-d45a-4253-9b93-496e52f2a9dd",
        inAppChatEnabled: true,
        androidSettings: AndroidSettings(firebaseSenderId: "660487917685"),
        defaultMessageStorage: true,
        iosSettings: IOSSettings(
            notificationTypes: ["alert", "badge", "sound"],
            forceCleanup: false,
            logging: true),
      ),
    );
    InfobipMobilemessaging.saveUser(UserData(firstName: "Amit"));
    InfobipMobilemessaging.setupiOSChatSettings(IOSChatSettings(
      title: 'Flutter Example Chat',
      sendButtonColor: '#E53E51',
      navigationBarItemsColor: '#E53E51',
      navigationBarColor: '#E53E51',
      navigationBarTitleColor: '#000000',
    ));
    return true;
  }

  Future<bool> showChat() async {
    await InfobipMobilemessaging.showChat();
    return true;
  }
}
