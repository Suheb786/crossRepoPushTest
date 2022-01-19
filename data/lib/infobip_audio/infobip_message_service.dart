import 'package:domain/constants/enum/infobip_utils_enum.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:infobip_mobilemessaging/models/Configuration.dart';
import 'package:infobip_mobilemessaging/models/IOSChatSettings.dart';
import 'package:infobip_mobilemessaging/models/LibraryEvent.dart';
import 'package:infobip_mobilemessaging/models/Message.dart';
import 'package:infobip_mobilemessaging/models/UserData.dart';

class InfobipMessageService {
  static List<String> libraryEvents = [''];

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> initPlatformState({required Function callback}) async {
    await InfobipMobilemessaging.init(
      Configuration(
        applicationCode: InfobipUtilsConstants.APPLICATION_CODE,
        inAppChatEnabled: true,
        androidSettings: AndroidSettings(
            firebaseSenderId: InfobipUtilsConstants.FIREBASE_SENDER_ID),
        defaultMessageStorage: true,
        iosSettings: IOSSettings(
            notificationTypes: ["alert", "badge", "sound"],
            forceCleanup: false,
            logging: true),
      ),
    );

    var installation = await InfobipMobilemessaging.fetchInstallation();
    print('Push Registration Id: ' +
        installation.getPushRegistrationId().toString());

    InfobipMobilemessaging.saveUser(UserData(firstName: "TEST USER"));

    InfobipMobilemessaging.on(LibraryEvent.TOKEN_RECEIVED, (String token) {
      print("Callback. TOKEN_RECEIVED event:" + token);
      addLibraryEvent("Token Received");
    });

    InfobipMobilemessaging.on(
        LibraryEvent.MESSAGE_RECEIVED,
        (Message message) => {
              print("Callback. MESSAGE_RECEIVED event, message title: " +
                  message.title! +
                  " body: " +
                  message.body!),
              addLibraryEvent("Message Received"),
              print("defaultMessageStorage().findAll():"),
              print(InfobipMobilemessaging.defaultMessageStorage()!.findAll())
            });
    InfobipMobilemessaging.on(
        LibraryEvent.USER_UPDATED,
        (event) => {
              print("Callback. USER_UPDATED event:" + event.toString()),
              addLibraryEvent("User Updated")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.PERSONALIZED,
        (event) => {
              print("Callback. PERSONALIZED event:" + event.toString()),
              addLibraryEvent("Personalized")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.INSTALLATION_UPDATED,
        (String event) => {
              print("Callback. INSTALLATION_UPDATED event:" + event.toString()),
              addLibraryEvent("Installation Updated")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.DEPERSONALIZED,
        (event) => {
              print("Callback. DEPERSONALIZED event:" + event.toString()),
              addLibraryEvent("Depersonalized")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.NOTIFICATION_ACTION_TAPPED,
        (event) => {
              print("Callback. NOTIFICATION_ACTION_TAPPED event:" +
                  event.toString()),
              addLibraryEvent("Notification Action Tapped")
            });
    InfobipMobilemessaging.on(
        LibraryEvent.NOTIFICATION_TAPPED,
        (Message message) => {
              print(
                  "Callback. NOTIFICATION_TAPPED event:" + message.toString()),
              addLibraryEvent("Notification Tapped"),
              if (message.chat!) {print('Chat Message Tapped')}
            });
    InfobipMobilemessaging.on(
        LibraryEvent.REGISTRATION_UPDATED,
        (String token) => {
              print("Callback. REGISTRATION_UPDATED event:" + token),
              addLibraryEvent("Registration Updated")
            });
    return true;
  }

  static void addLibraryEvent(String libraryEvent) {
    libraryEvents.add(libraryEvent);
  }

  Future<bool> showChat() async {
    InfobipMobilemessaging.resetMessageCounter();
    await InfobipMobilemessaging.showChat();
    return true;
  }
}
