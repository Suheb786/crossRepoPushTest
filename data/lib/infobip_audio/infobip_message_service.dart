import 'package:domain/constants/enum/infobip_utils_enum.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:infobip_mobilemessaging/models/Configuration.dart';
import 'package:infobip_mobilemessaging/models/IOSChatSettings.dart';
import 'package:infobip_mobilemessaging/models/UserData.dart';

class InfobipMessageService {
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> initPlatformState() async {
    await InfobipMobilemessaging.init(
      Configuration(
        applicationCode: InfobipUtilsConstants.APPLICATION_CODE,
        inAppChatEnabled: true,
        androidSettings: AndroidSettings(
            firebaseSenderId: InfobipUtilsConstants.FIREBASE_SENDER_ID),
        defaultMessageStorage: true,
        iosSettings: IOSSettings(
            notificationTypes: ["alert", "badge", "sound"],
            forceCleanup: true,
            logging: true),
      ),
    );
    return true;
  }

  Future<bool> showChat() async {
    await InfobipMobilemessaging.showChat();
    return true;
  }
}
